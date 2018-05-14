"
A PSQLSharedASTBuilderTest is a test class for testing the behavior of PSQLSharedASTBuilder
"
Class {
	#name : #PSQLSharedASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'PostgreSQL-AST-Builder-Tests'
}

{ #category : #initialization }
PSQLSharedASTBuilderTest >> setUp [
	builder := PSQLSharedASTBuilder new
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testOrderByClause [
	| node |
	node := builder orderByClause parse: 'ORDER BY c1, c2 ASC , c3 NULLS FIRST , c4 DESC NULLS LAST'.
	
	self
		assert: node class equals: PSQLASTOrderByClause;
		assert: node items size equals: 4;
		"c1"
		assert: node items first class equals: PSQLASTOrderByClauseItem;
		assert: node items first expression class equals: PSQLASTIdentifier;
		deny: node items first hasIsAscOrIsDesc;
		deny: node items first hasNullsFirstOrNullsLast;
		"c2"
		assert: node items second class equals: PSQLASTOrderByClauseItem;
		assert: node items second expression class equals: PSQLASTIdentifier;
		assert: node items second hasIsAscOrIsDesc;
		assert: node items second isAsc;
		deny: node items second isDesc;
		deny: node items second hasNullsFirstOrNullsLast;
		"c3"
		assert: node items third class equals: PSQLASTOrderByClauseItem;
		assert: node items third expression class equals: PSQLASTIdentifier;
		deny: node items third hasIsAscOrIsDesc;
		assert: node items third hasNullsFirstOrNullsLast;
		assert: node items third isNullsFirst;
		deny: node items third isNullsLast;
		"c4"
		assert: node items fourth class equals: PSQLASTOrderByClauseItem;
		assert: node items fourth expression class equals: PSQLASTIdentifier;
		assert: node items fourth hasIsAscOrIsDesc;
		assert: node items fourth isDesc;
		deny: node items fourth isAsc;
		assert: node items fourth hasNullsFirstOrNullsLast;
		deny: node items fourth isNullsFirst;
		assert: node items fourth isNullsLast
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testReturningClause [
	| node |
	node := builder returningClause parse: 'RETURNING *,id'.
	self
		assert: node class equals: PSQLASTReturningClause;
		assert: node returnedList size equals: 2
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testSetClause [
	| node |
	node := builder setClause parse: 'SET column = 1+1, (column1, column2, column3) = (SELECT c1,c2,c3 FROM foo), (column1, column2, column3) = (SELECT c1,c2,c3 FROM foo)'.
	self
		assert: node class equals: PSQLASTSetClause;
		assert: node items class equals: Array;
		assert: node items size equals: 3
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testSetItem1 [
	| node |
	node := builder setItem1 parse: 'column = 1+1'.
	self
		assert: node class equals: PSQLASTSetClauseItemType1;
		assert: node left class equals: PSQLASTIdentifier;
		assert: node right class equals: PSQLASTBinaryOperator
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testSetItem2 [
	| node |
	node := builder setItem2 parse: '(column1, column2, column3) = (1+1, DEFAULT, 42)'.
	self
		assert: node class equals: PSQLASTSetClauseItemType2;
		assert: node left class equals: Array;
		assert: node left size equals: 3;
		assert: node right class equals: Array;
		assert: node right size equals: 3;
		assert: node right first class equals: PSQLASTBinaryOperator;
		assert: node right second class equals: PSQLASTDefaultValue;
		assert: node right third class equals: PSQLASTNumericConstant.
		
	node left do: [ :leftItem |
		self assert: leftItem class equals: PSQLASTIdentifier ].
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testSetItem3 [
	| node |
	node := builder setItem3 parse: '(column1, column2, column3) = (SELECT c1,c2,c3 FROM foo)'.
	self
		assert: node class equals: PSQLASTSetClauseItemType3;
		assert: node left class equals: Array;
		assert: node left size equals: 3;
		assert: node right class equals: PSQLASTSelectQuery.
		
	node left do: [ :leftItem |
		self assert: leftItem class equals: PSQLASTIdentifier ].
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testUpdateDeleteWhereClause [
	| node |
	node := builder updateDeleteWhereClause parse: 'WHERE id = 1'.
	self
		assert: node class equals: PSQLASTUpdateDeleteWhereClause;
		deny: node hasCursor;
		assert: node hasCondition;
		assert: node condition class equals: PSQLASTBinaryOperator.
		
	node := builder updateDeleteWhereClause parse: 'WHERE CURRENT OF cursor'.
	self
		assert: node class equals: PSQLASTUpdateDeleteWhereClause;
		assert: node hasCursor;
		deny: node hasCondition;
		assert: node currentOfCursor class equals: PSQLASTIdentifier
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testWithClause [
	| node |
	node := builder withClause parse: 'WITH table AS (SELECT * FROM foo), table2(id,text) AS (SELECT * FROM bar)'.
	self
		assert: node class equals: PSQLASTWithClause;
		deny: node isRecursive;
		assert: node queries size equals: 2.
		
	node := builder withClause parse: 'WITH RECURSIVE table AS (SELECT * FROM foo), table2(id,text) AS (SELECT * FROM bar)'.
	self
		assert: node class equals: PSQLASTWithClause;
		assert: node isRecursive;
		assert: node queries size equals: 2.
]

{ #category : #'tests-shared' }
PSQLSharedASTBuilderTest >> testWithQuery [
	| node |
	node := builder withQuery parse: 'table AS (SELECT * FROM foo)'.
	self
		assert: node class equals: Association;
		assert: node key class equals: PSQLASTTableAlias;
		assert: node key identifier identifier equals: 'table';
		assert: node key columnAliases size equals: 0.
		
	node := builder withQuery parse: 'table(id,bar) AS (SELECT * FROM foo)'.
	self
		assert: node class equals: Association;
		assert: node key class equals: PSQLASTTableAlias;
		assert: node key identifier identifier equals: 'table';
		assert: node key columnAliases size equals: 2;
		assert: (node key columnAliases allSatisfy: [ :item | item class = PSQLASTIdentifier ])
]
