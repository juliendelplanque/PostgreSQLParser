Class {
	#name : #PSQLASTReflectiveVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'function'
	],
	#category : #'PostgreSQL-AST-Visitors-Tests'
}

{ #category : #helpers }
PSQLASTReflectiveVisitorTest >> createColumn: aName inTable: aFmxSQLTable [
	^ FmxSQLColumn new
		columnsContainer: aFmxSQLTable;
		name: aName;
		mooseModel: model;
		yourself
]

{ #category : #helpers }
PSQLASTReflectiveVisitorTest >> createStoredProcedure: aProcedureName [
	^ FmxSQLStoredProcedure new
		name: aProcedureName;
		mooseModel: model;
		yourself
]

{ #category : #helpers }
PSQLASTReflectiveVisitorTest >> createTable: aTableName [
	^ FmxSQLTable new
		name: aTableName;
		mooseModel: model;
		yourself
]

{ #category : #helpers }
PSQLASTReflectiveVisitorTest >> createTable: aTableName withColumns: aCollectionOfColumnNames [
	| table |
	table := self createTable: aTableName.
	aCollectionOfColumnNames do: [ :aColumnName | self createColumn: aColumnName inTable: table ].
	^ table
]

{ #category : #convenient }
PSQLASTReflectiveVisitorTest >> find: aClass in: aCollection thenDo: aBlockClosure [
	^ aCollection
		detect: [ :x | x class = aClass ]
		ifFound: [ :x | aBlockClosure cull: x ]
		ifNone: [ NotFound signalFor: aClass in: aCollection ]
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> parseAndVisitFunction: aFunctionCode [
	| visitor |
	visitor := (PSQLASTReflectiveVisitor model: model function: function).
	
	(PSQLPlpgSQLASTBuilder parse: (PSQLCommentsRemover parse: aFunctionCode))
		acceptVisitor: visitor.
		
	self assert: visitor errorReport errors isEmpty
]

{ #category : #running }
PSQLASTReflectiveVisitorTest >> setUp [
	model := MooseModel new.
	function := FmxSQLStoredProcedure new.
	function mooseModel: model.
	function name: 'currentFunction'
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testAliasingMethodsResult [
	self createTable: 'table1' withColumns: #('column1' 'column2').
	self
		parseAndVisitFunction:
			'DECLARE
BEGIN
	RETURN QUERY SELECT
		function1(column1,column2)::INTEGER AS res1,
		SUM(function2())::INTEGER AS res2
	FROM
		table1
	GROUP BY res1
	ORDER BY res2;
END;'
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testClassicDeclaration [
	self
		parseAndVisitFunction:
			' DECLARE
      "scope_v"            "delegation_scope";
BEGIN
END;'.
	self assert: function localVariables size equals: 1.
	self assert: function localVariables first name equals: 'scope_v'.
	self assert: function localVariables first type name equals: 'delegation_scope'
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testCopyTypeDeclaration [
	| table columnType column |
	table := FmxSQLTable new
		name: 'unit';
		mooseModel: model;
		yourself.
	columnType := FmxSQLType new
		name: 'myType';
		mooseModel: model;
		yourself.
	column := FmxSQLColumn new
		columnsContainer: table;
		mooseModel: model;
		name: 'id';
		type: columnType;
		yourself.
	self
		parseAndVisitFunction:
			' DECLARE
      "unit_id_v"          "unit"."id"%TYPE;
BEGIN
END;'.
	self assert: function localVariables size equals: 1.
	self assert: function localVariables first name equals: 'unit_id_v'.
	self assert: function localVariables first type equals: columnType
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testCursorDeclaration [
	self
		parseAndVisitFunction:
			' DECLARE
      curs1 refcursor;
BEGIN
END;'.
	self assert: function localVariables size equals: 1.
	self assert: function localVariables first name equals: 'curs1'.
	self assert: function localVariables first type name equals: 'refcursor'
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testCursorDeclaration2 [
	| cursor |
	self createTable: 'test_table'.
	self
		parseAndVisitFunction:
			'DECLARE
    curs2 CURSOR FOR SELECT * FROM test_table;
BEGIN
END;'.
	self assert: function localVariables size equals: 1.
	self assert: function localVariables first name equals: 'curs2'.
	self assert: function localVariables first type name equals: 'refcursor'.
	self assert: function references size equals: 1.
	self assert: function references first class equals: FmxSQLCursorReference.
	cursor := function references first cursor.
	self assert: cursor query class equals: FmxSQLSelectQuery.
	self assert: cursor query clauses size equals: 2.
	self
		find: FmxSQLFromClause
		in: cursor query clauses
		thenDo: [ :fromClause | 
			self assert: fromClause references size equals: 1.
			self assert: fromClause references first class equals: FmxSQLTableReference.
			self assert: fromClause references first table name equals: 'test_table' ]
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testCursorDeclaration3 [
	| cursor |
	self createTable: 'test_table'.
	self
		parseAndVisitFunction:
			'DECLARE
    curs refcursor;
BEGIN
	OPEN curs FOR SELECT * FROM test_table;
END;'.
	self assert: function localVariables size equals: 1.
	self assert: function localVariables first name equals: 'curs'.
	self assert: function localVariables first type name equals: 'refcursor'.
	self assert: function references size equals: 2.
	self assert: function references second class equals: FmxSQLCursorReference.
	self assert: function references first class equals: FmxSQLLocalVariableAccess.
	cursor := function references second cursor.
	self assert: cursor query class equals: FmxSQLSelectQuery.
	self
		find: FmxSQLFromClause
		in: cursor query clauses
		thenDo: [ :fromClause | 
			self assert: fromClause references size equals: 1.
			self assert: fromClause references first class equals: FmxSQLTableReference.
			self assert: fromClause references first table name equals: 'test_table' ]
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testCursorWithParameterDeclaration [
	| cursor testTable |
	testTable := self createTable: 'test_table'.
	self
		parseAndVisitFunction:
			'DECLARE
    curs2 CURSOR (curs_param integer) FOR SELECT * FROM test_table;
BEGIN
END;'.
	self assert: function localVariables size equals: 1.
	self assert: function localVariables first name equals: 'curs2'.
	self assert: function localVariables first type name equals: 'refcursor'.
	self assert: function references size equals: 1.
	self assert: function references first class equals: FmxSQLCursorReference.
	cursor := function references first cursor.
	self assert: cursor parameters size equals: 1.
	self assert: cursor parameters first name equals: 'curs_param'.
	self assert: cursor parameters first type name equals: 'integer'.
	self assert: cursor query class equals: FmxSQLSelectQuery.
	self
		find: FmxSQLFromClause
		in: cursor query clauses
		thenDo: [ :fromClause | 
			self assert: fromClause references size equals: 1.
			self assert: fromClause references first class equals: FmxSQLTableReference.
			self assert: fromClause references first table equals: testTable ]
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testCursorWithParameterDeclarationAndAccessToIt [
	| cursor |
	self createTable: 'test_table'.
	self
		parseAndVisitFunction:
			'DECLARE
    curs2 CURSOR (curs_param integer) FOR SELECT curs_param, * FROM test_table;
BEGIN
END;'.
	cursor := function references first cursor.
	self assert: cursor query clauses size equals: 2.
	self
		find: FmxSQLSelectClause
		in: cursor query clauses
		thenDo: [ :selectClause | 
			self assert: selectClause references size equals: 1.
			self assert: selectClause references first class equals: FmxSQLCursorParameterAccess.
			self assert: selectClause references first parameter equals: cursor parameters first ]
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testDeleteQueryInCodeWithWhereAndAnd [
	| table columnType column |
	table := FmxSQLTable new
		name: 'unit';
		mooseModel: model;
		yourself.
	columnType := FmxSQLType new
		name: 'myType';
		mooseModel: model;
		yourself.
	column := FmxSQLColumn new
		columnsContainer: table;
		mooseModel: model;
		name: 'id';
		type: columnType;
		yourself..
	self
		parseAndVisitFunction:
			' DECLARE
BEGIN
	DELETE FROM "direct_population_snapshot"
        WHERE "issue_id" = "issue_id_p"
        AND "event" = ''periodic'';
END;'.
	"self assert: function clauses size equals: 1"
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testRowTypeDeclaration [
	| table |
	table := FmxSQLTable new
		name: 'issue';
		mooseModel: model;
		yourself.
	self
		parseAndVisitFunction:
			' DECLARE
      "issue_row"          "issue"%ROWTYPE;
BEGIN
END;'.
	self assert: function localVariables size equals: 1.
	self assert: function localVariables first name equals: 'issue_row'.
	self assert: function localVariables first type equals: table
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testSelectWithJoinAndAliasing [
	self createTable: #initiative withColumns: #(id issue_id).
	self createTable: #battle withColumns: #(losing_iniative_id).
	self
		parseAndVisitFunction:
			'DECLARE
BEGIN
	SELECT "new_initiative"."id" AS "initiative_id"
		FROM "initiative" "old_initiative"
		JOIN "initiative" "new_initiative"
			ON "new_initiative"."issue_id" = 10
		JOIN "battle" "battle_win"
			ON "battle_win"."losing_initiative_id" = "old_initiative"."id";
END;'.
	
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testStoredProcedureInvocation [
	self createStoredProcedure: 'myFunction'.
	self
		parseAndVisitFunction:
			' DECLARE
BEGIN
	myFunction();
END;'
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testVariableAccess [
	self
		parseAndVisitFunction:
			' DECLARE
      "a"            INT4;
      "b"            INT4;
BEGIN
	"a"         := 0;
	"b"         := "a";
END;'.
	self assert: function localVariables size equals: 2.
	self assert: function localVariables first name equals: 'a'.
	self assert: function localVariables first type name equals: 'int4'.
	self assert: function localVariables second name equals: 'b'.
	self assert: function localVariables second type name equals: 'int4'.
	self assert: function references size equals: 3
]

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> testVariableAssignation [
	self
		parseAndVisitFunction:
			' DECLARE
      "a"            INT4;
BEGIN
	"a"         := 0;
END;'.
	self assert: function localVariables size equals: 1.
	self assert: function localVariables first name equals: 'a'.
	self assert: function localVariables first type name equals: 'int4'.
	self assert: function references size equals: 1
]
