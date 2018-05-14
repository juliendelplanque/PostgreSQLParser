Class {
	#name : #PSQLDeleteQueryASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'PostgreSQL-AST-Builder-Tests'
}

{ #category : #initialization }
PSQLDeleteQueryASTBuilderTest >> setUp [
	builder := PSQLDeleteQueryASTBuilder new
]

{ #category : #'tests-delete command' }
PSQLDeleteQueryASTBuilderTest >> testDeleteCommand [
	| node |
	node := builder deleteCommand parse: 'DELETE FROM films'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'films';
		deny: node hasWithClause;
		deny: node hasAlias;
		deny: node hasReturningClause;
		deny: node hasUsingList;
		deny: node hasWhereClause;
		deny: node areDescendantTablesIncluded.
		
	node := builder deleteCommand parse: 'DELETE FROM films * AS filmsalias'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'films';
		deny: node hasWithClause;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node alias identifier equals: 'filmsalias';
		deny: node hasReturningClause;
		deny: node hasUsingList;
		deny: node hasWhereClause;
		assert: node areDescendantTablesIncluded.
		
	node := builder deleteCommand parse: 'WITH t AS (
    DELETE FROM foo
)
DELETE FROM bar'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'bar';
		assert: node hasWithClause;
		assert: node withClause class equals: PSQLASTWithClause;
		deny: node hasAlias;
		deny: node hasReturningClause;
		deny: node hasUsingList;
		deny: node hasWhereClause;
		deny: node areDescendantTablesIncluded.
		
	node := builder deleteCommand parse: 'DELETE FROM tasks WHERE status = ''DONE'' RETURNING *'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'tasks';
		deny: node hasWithClause;
		deny: node hasAlias;
		assert: node hasReturningClause;
		assert: node returningClause class equals: PSQLASTReturningClause;
		deny: node hasUsingList;
		assert: node hasWhereClause;
		assert: node whereClause class equals: PSQLASTUpdateDeleteWhereClause;
		deny: node areDescendantTablesIncluded.
		
	node := builder deleteCommand parse: 'DELETE FROM tasks USING test WHERE status = ''DONE'' RETURNING *'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'tasks';
		deny: node hasWithClause;
		deny: node hasAlias;
		assert: node hasReturningClause;
		assert: node returningClause class equals: PSQLASTReturningClause;
		assert: node hasUsingList;
		assert: node usingList size equals: 1;
		assert: node hasWhereClause;
		assert: node whereClause class equals: PSQLASTUpdateDeleteWhereClause;
		deny: node areDescendantTablesIncluded.
]
