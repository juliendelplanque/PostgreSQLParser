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

{ #category : #parsing }
PSQLASTReflectiveVisitorTest >> parseAndVisitFunction: aFunctionCode [
	(PSQLPlpgSQLASTBuilder parse: (PSQLCommentsRemover parse: aFunctionCode))
		acceptVisitor: (PSQLASTReflectiveVisitor model: model function: function)
]

{ #category : #running }
PSQLASTReflectiveVisitorTest >> setUp [
	model := MooseModel new.
	function := FmxSQLStoredProcedure new.
	function mooseModel: model
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
