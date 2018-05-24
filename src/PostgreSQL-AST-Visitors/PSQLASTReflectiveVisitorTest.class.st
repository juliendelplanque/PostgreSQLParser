Class {
	#name : #PSQLASTReflectiveVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'function'
	],
	#category : #'PostgreSQL-AST-Visitors-Tests'
}

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
