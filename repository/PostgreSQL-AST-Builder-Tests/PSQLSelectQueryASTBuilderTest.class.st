Class {
	#name : #PSQLSelectQueryASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #PostgreSQL-AST-Builder-Tests
}

{ #category : #initialization }
PSQLSelectQueryASTBuilderTest >> setUp [
	builder := PSQLSelectQueryASTBuilder new
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testAllOrDistinctClause [
	| node |
	node := builder allOrDistinctClause parse: 'ALL'.
	
	self
		assert: node class equals: PSQLASTAllClause.
		
	node := builder allOrDistinctClause parse: 'DISTINCT'.
	
	self
		assert: node class equals: PSQLASTDistinctClause;
		deny: node hasExpressions.
		
	node := builder allOrDistinctClause parse: 'DISTINCT ON (c1, c2, fct())'.
	
	self
		assert: node class equals: PSQLASTDistinctClause;
		assert: node hasExpressions;
		assert: node expressions size equals: 3
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testColumnsAndAliasesSelected [
	| node |
	node := builder columnsAndAliasesSelected parse: '*'.
	
	self
		assert: node class equals: Array;
		assert: node size equals: 1;
		assert: node first class equals: PSQLASTWildCard.
		
	node := builder columnsAndAliasesSelected parse: 'id.*'.
	
	self
		assert: node class equals: Array;
		assert: node size equals: 1;
		assert: node first class equals: PSQLASTAttributeAccess;
		assert: node first accessed class equals: PSQLASTIdentifier ;
		assert: node first attributeIdentifier class equals: PSQLASTWildCard.
		
	node := builder columnsAndAliasesSelected parse: 'column AS c'.
	
	self
		assert: node class equals: Array;
		assert: node size equals: 1;
		assert: node first class equals: PSQLASTBinaryOperator;
		assert: node first operator equals: 'AS';
		assert: node first left class equals: PSQLASTIdentifier;
		assert: node first left identifier equals: 'column';
		assert: node first right class equals: PSQLASTIdentifier;
		assert: node first right identifier equals: 'c'.
		
	node := builder columnsAndAliasesSelected parse: '*, col AS c, count(x)'.
	
	self
		assert: node class equals: Array;
		assert: node size equals: 3.
		
	node := builder columnsAndAliasesSelected parse: 'count(*), foo'.
	
	self
		assert: node class equals: Array;
		assert: node size equals: 2;
		assert: node first class equals: PSQLASTAggregateFunctionCall;
		assert: node second class equals: PSQLASTIdentifier
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testFetchClause [
	| node |
	node := builder fetchClause parse: 'FETCH NEXT ROW ONLY'.
	
	self
		assert: node class equals: PSQLASTFetchClause;
		assert: node isNext;
		deny: node isFirst;
		deny: node hasCount.
		
	node := builder fetchClause parse: 'FETCH FIRST 5 ROWS ONLY'.
	
	self
		assert: node class equals: PSQLASTFetchClause;
		deny: node isNext;
		assert: node isFirst;
		assert: node hasCount;
		assert: node count class equals: PSQLASTNumericConstant
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testForClause [
	| node |
	node := builder forClause parse: 'FOR UPDATE'.
	
	self
		assert: node class equals: PSQLASTForClause;
		assert: node isUpdate;
		deny: node isShare;
		deny: node hasOfTables;
		deny: node isNoWait.
		
	node := builder forClause parse: 'FOR SHARE OF t1, t2, t3 NOWAIT'.
	
	self
		assert: node class equals: PSQLASTForClause;
		deny: node isUpdate;
		assert: node isShare;
		assert: node hasOfTables;
		assert: node ofTables class equals: Array;
		assert: node ofTables size equals: 3;
		assert: node ofTables first class equals: PSQLASTIdentifier;
		assert: node ofTables second class equals: PSQLASTIdentifier;
		assert: node ofTables third class equals: PSQLASTIdentifier;
		assert: node isNoWait
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testGroupByClause [
	| node |
	node := builder groupByClause parse: 'GROUP BY column'.
	
	self
		assert: node class equals: PSQLASTGroupByClause;
		assert: node expressions size equals: 1;
		assert: node expressions first class equals: PSQLASTIdentifier
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testHavingClause [
	| node |
	node := builder  havingClause parse: 'HAVING column'.
	
	self
		assert: node class equals: PSQLASTHavingClause;
		assert: node expressions size equals: 1;
		assert: node expressions first class equals: PSQLASTIdentifier
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testIntoClause [
	| node |
	node := builder intoClause parse: 'INTO t'.
	
	self
		assert: node class equals: PSQLASTIntoClause;
		deny: node isTemporary;
		deny: node isTemp;
		deny: node isUnlogged;
		deny: node hasTable;
		assert: node newTable class equals: PSQLASTIdentifier.
		
	node := builder intoClause parse: 'INTO TEMPORARY TABLE t'.
	
	self
		assert: node class equals: PSQLASTIntoClause;
		assert: node isTemporary;
		deny: node isTemp;
		deny: node isUnlogged;
		assert: node hasTable;
		assert: node newTable class equals: PSQLASTIdentifier.
		
	node := builder intoClause parse: 'INTO UNLOGGED t'.
	
	self
		assert: node class equals: PSQLASTIntoClause;
		deny: node isTemporary;
		deny: node isTemp;
		assert: node isUnlogged;
		deny: node hasTable;
		assert: node newTable class equals: PSQLASTIdentifier.
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testLimitClause [
	| node |
	node := builder limitClause parse: 'LIMIT ALL'.
	
	self
		assert: node class equals: PSQLASTLimitClause;
		assert: node limit class equals: PSQLASTAllClause.
		
	node := builder limitClause parse: 'LIMIT 42'.
	
	self
		assert: node class equals: PSQLASTLimitClause;
		assert: node limit class equals: PSQLASTNumericConstant.
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testOffsetClause [
	| node |
	node := builder offsetClause parse: 'OFFSET 42'.
	
	self
		assert: node class equals: PSQLASTOffsetClause;
		assert: node offset class equals: PSQLASTNumericConstant.
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testSelectCommand [
	| node |
	node := builder selectCommand parse: 'SELECT c1, c2, c3 FROM t ORDER BY c1 OFFSET 42'.
	
	self
		assert: node class equals: PSQLASTSelectQuery;
		assert: node allOrDistinctClause isNil;
		assert: node columnsAndAliasesSelected class equals: Array;
		assert: node columnsAndAliasesSelected size equals: 3;
		assert: node fromClause class equals: PSQLASTFromClause;
		assert: node whereClause isNil;
		assert: node groupByClause isNil;
		assert: node havingClause isNil;
		assert: node windowClause isNil;
		assert: node unionIntersectExceptClause isNil;
		assert: node orderByClause class equals: PSQLASTOrderByClause;
		assert: node limitClause isNil;
		assert: node offsetClause class equals: PSQLASTOffsetClause;
		assert: node fetchClause isNil;
		assert: node forClause isNil
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testSelectIntoCommandAlternative [
	| node |
	node := builder selectIntoCommandAlternative parse: 'SELECT INTO newTable c1, c2, c3 FROM t ORDER BY c1 OFFSET 42'.
	
	self
		assert: node class equals: PSQLASTAlternativeSelectIntoQuery;
		assert: node allOrDistinctClause isNil;
		assert: node columnsAndAliasesSelected class equals: Array;
		assert: node columnsAndAliasesSelected size equals: 3;
		assert: node intoClause class equals: PSQLASTIntoClause;
		assert: node intoClause newTable class equals: PSQLASTIdentifier;
		assert: node intoClause newTable identifier equals: 'newTable';
		deny: node intoClause isTemporary;
		deny: node intoClause isTemp;
		deny: node intoClause isUnlogged;
		assert: node fromClause class equals: PSQLASTFromClause;
		assert: node whereClause isNil;
		assert: node groupByClause isNil;
		assert: node havingClause isNil;
		assert: node windowClause isNil;
		assert: node unionIntersectExceptClause isNil;
		assert: node orderByClause class equals: PSQLASTOrderByClause;
		assert: node limitClause isNil;
		assert: node offsetClause class equals: PSQLASTOffsetClause;
		assert: node fetchClause isNil;
		assert: node forClause isNil
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testSelectIntoCommandClassic [
	| node |
	node := builder selectIntoCommandClassic parse: 'SELECT c1, c2, c3 INTO newTable FROM t ORDER BY c1 OFFSET 42'.
	
	self
		assert: node class equals: PSQLASTSelectIntoQuery;
		assert: node allOrDistinctClause isNil;
		assert: node columnsAndAliasesSelected class equals: Array;
		assert: node columnsAndAliasesSelected size equals: 3;
		assert: node intoClause class equals: PSQLASTIntoClause;
		assert: node fromClause class equals: PSQLASTFromClause;
		assert: node whereClause isNil;
		assert: node groupByClause isNil;
		assert: node havingClause isNil;
		assert: node windowClause isNil;
		assert: node unionIntersectExceptClause isNil;
		assert: node orderByClause class equals: PSQLASTOrderByClause;
		assert: node limitClause isNil;
		assert: node offsetClause class equals: PSQLASTOffsetClause;
		assert: node fetchClause isNil;
		assert: node forClause isNil
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testUnionIntersectExceptClause [
	| node |
	node := builder  unionIntersectExceptClause parse: 'UNION SELECT * FROM foo'.
	
	self
		assert: node class equals: PSQLASTUnionClause;
		assert: node isDistinct;
		deny: node isAll";
		assert: node selectQuery class equals: PSQLASTSelectQuery".
		
	node := builder  unionIntersectExceptClause parse: 'UNION DISTINCT SELECT * FROM foo'.
	
	self
		assert: node class equals: PSQLASTUnionClause;
		assert: node isDistinct;
		deny: node isAll;
		assert: node selectQuery class equals: PSQLASTSelectQuery.
		
	node := builder  unionIntersectExceptClause parse: 'UNION ALL SELECT * FROM foo'.
	
	self
		assert: node class equals: PSQLASTUnionClause;
		deny: node isDistinct;
		assert: node isAll;
		assert: node selectQuery class equals: PSQLASTSelectQuery.
		
	node := builder  unionIntersectExceptClause parse: 'INTERSECT ALL SELECT * FROM foo'.
	
	self
		assert: node class equals: PSQLASTIntersectClause;
		deny: node isDistinct;
		assert: node isAll;
		assert: node selectQuery class equals: PSQLASTSelectQuery.
		
	node := builder  unionIntersectExceptClause parse: 'EXCEPT DISTINCT SELECT * FROM foo'.
	
	self
		assert: node class equals: PSQLASTExceptClause;
		assert: node isDistinct;
		deny: node isAll;
		assert: node selectQuery class equals: PSQLASTSelectQuery
]

{ #category : #'tests-select command' }
PSQLSelectQueryASTBuilderTest >> testWhereClause [
	| node |
	node := builder whereClause parse: 'WHERE t.id = 42'.
	
	self
		assert: node class equals: PSQLASTSelectWhereClause;
		assert: node condition class equals: PSQLASTBinaryOperator
]
