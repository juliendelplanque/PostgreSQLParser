Class {
	#name : #PSQLInsertQueryASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'PostgreSQL-AST-Builder-Tests'
}

{ #category : #initialization }
PSQLInsertQueryASTBuilderTest >> setUp [
	builder := PSQLInsertQueryASTBuilder new
]

{ #category : #'tests-insert command' }
PSQLInsertQueryASTBuilderTest >> testConflictAction [
	| node |
	node := builder conflictAction parse: 'DO NOTHING'.
	self
		assert: node class equals: PSQLASTConflictAction;
		assert: node isDoNothing;
		deny: node isDoUpdateSet.
		
	node := builder conflictAction parse: 'DO UPDATE SET id = 1, foo=''bar'', default=DEFAULT'.
	self
		assert: node class equals: PSQLASTConflictAction;
		deny: node isDoNothing;
		assert: node isDoUpdateSet;
		assert: node setClause class equals: PSQLASTSetClause
]

{ #category : #'tests-insert command' }
PSQLInsertQueryASTBuilderTest >> testInsertCommand [
	| node |
	node := builder insertCommand parse: 'INSERT INTO table (id, name) VALUES (DEFAULT, ''john'')'.
	self
		assert: node class equals: PSQLASTInsertQuery;
		deny: node hasWithClause;
		deny: node hasAlias;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'table';
		assert: node hasColumns;
		assert: node columns size equals: 2;
		assert: node valuesClause class equals: Array;
		deny: node hasOnConflictClause;
		deny: node hasReturningClause.
		
	node := builder insertCommand parse: 'INSERT INTO table AS t (id, name) VALUES (DEFAULT, ''john''), (SELECT * FROM foo) ON CONFLICT DO NOTHING RETURNING *'.
	self
		assert: node class equals: PSQLASTInsertQuery;
		deny: node hasWithClause;
		assert: node hasAlias;
		assert: node alias identifier equals: 't';
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'table';
		assert: node hasColumns;
		assert: node columns size equals: 2;
		assert: node valuesClause class equals: Array;
		assert: node hasOnConflictClause;
		assert: node onConflictClause class equals: PSQLASTOnConflictClause;
		assert: node hasReturningClause;
		assert: node returningClause class equals: PSQLASTReturningClause
]

{ #category : #'tests-insert command' }
PSQLInsertQueryASTBuilderTest >> testOnConflictClause [
	| node |
	node := builder onConflictClause parse: 'ON CONFLICT DO NOTHING'.
	self
		assert: node class equals: PSQLASTOnConflictClause;
		deny: node hasTarget;
		assert: node action class equals: PSQLASTConflictAction.
		
	node := builder onConflictClause parse: 'ON CONFLICT DO UPDATE SET id = 1, foo=''bar'', default=DEFAULT'.
	self
		assert: node class equals: PSQLASTOnConflictClause;
		deny: node hasTarget;
		assert: node action class equals: PSQLASTConflictAction
]

{ #category : #'tests-insert command' }
PSQLInsertQueryASTBuilderTest >> testValuesClause [
	| node |
	node := builder valuesClause parse: 'VALUES (1, DEFAULT, var+1)'.
	self assert: node class equals: PSQLASTValuesClause.
	self assert: node values class equals: PSQLASTValuesCommand.
	node := builder valuesClause parse: 'DEFAULT VALUES'.
	self assert: node class equals: PSQLASTValuesClause.
	self assert: node values class equals: PSQLASTDefaultValues.
	node := builder valuesClause parse: 'SELECT * FROM foo'.
	self assert: node class equals: PSQLASTValuesClause.
	self assert: node values class equals: PSQLASTSelectQuery
]
