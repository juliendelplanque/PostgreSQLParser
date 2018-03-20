Class {
	#name : #PSQLUpdateQueryASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #PostgreSQL-AST-Builder-Tests
}

{ #category : #initialization }
PSQLUpdateQueryASTBuilderTest >> setUp [
	builder := PSQLUpdateQueryASTBuilder new
]

{ #category : #'tests-update command' }
PSQLUpdateQueryASTBuilderTest >> testUpdateCommand [
	| node |
	node := builder updateCommand parse: 'UPDATE films SET kind = ''Dramatic'' WHERE kind = ''Drama'''.
	self
		assert: node class equals: PSQLASTUpdateQuery;
		deny: node hasOnly;
		deny: node hasWithClause;
		assert: node tableName identifier equals: 'films';
		deny: node hasAlias;
		assert: node setClause class equals: PSQLASTSetClause;
		assert: node setClause items size equals: 1;
		assert: node hasWhereClause;
		assert: node whereClause class equals: PSQLASTUpdateDeleteWhereClause;
		deny: node hasFromClause;
		deny: node hasReturningClause.
		
	node := builder updateCommand parse: 'UPDATE ONLY accounts SET contact_first_name = first_name, contact_last_name = last_name FROM salesmen WHERE salesmen.id = accounts.sales_id'.
	self
		assert: node class equals: PSQLASTUpdateQuery;
		assert: node hasOnly;
		deny: node hasWithClause;
		assert: node tableName identifier equals: 'accounts';
		deny: node hasAlias;
		assert: node setClause class equals: PSQLASTSetClause;
		assert: node setClause items size equals: 2;
		assert: node hasWhereClause;
		assert: node whereClause class equals: PSQLASTUpdateDeleteWhereClause;
		assert: node hasFromClause;
		assert: node fromClause class equals: PSQLASTFromClause;
		deny: node hasReturningClause.
]
