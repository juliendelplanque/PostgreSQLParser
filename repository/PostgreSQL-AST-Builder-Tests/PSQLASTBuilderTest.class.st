"
A PSQLASTBuilderTest is a test class for testing the behavior of PSQLASTBuilder
"
Class {
	#name : #PSQLASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #PostgreSQL-AST-Builder-Tests
}

{ #category : #running }
PSQLASTBuilderTest >> setUp [
	builder := PSQLASTBuilder new
]

{ #category : #tests-expression }
PSQLASTBuilderTest >> testAggregateExpressionParserForm3With [
	| node |
	node := builder expression parse: 'count(*)'.
	self
		assert: node class equals: PSQLASTAggregateFunctionCall;
		assert: node functionIdentifier class equals: PSQLASTIdentifier;
		assert: node functionIdentifier identifier equals: 'count';
		assert: node expressions size equals: 1;
		assert: node expressions first class equals: PSQLASTWildCard
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testAllOrDistinctClause [
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

{ #category : #tests-shared }
PSQLASTBuilderTest >> testColumnDefinition [
		| node |
	node := builder columnDefinition parse: 'c VARYING CHAR'.
	self
		assert: node class equals: PSQLASTColumnDefinition;
		assert: node columnName class equals: PSQLASTIdentifier;
		assert: node columnName identifier equals: 'c';
		assert: node type class equals: PSQLASTIdentifier;
		assert: node type identifier equals: 'VARYING CHAR'
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testColumnsAndAliasesSelected [
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

{ #category : #tests-expression }
PSQLASTBuilderTest >> testCompositeValueWith [
	| node |
	node := builder expression parse: '(1, id*3, table.attribute)'.
	self
		assert: node class equals: PSQLASTCompositeValue;
		assert: node items size equals: 3;
		assert: node items first class equals: PSQLASTNumericConstant;
		assert: node items second class equals: PSQLASTBinaryOperator;
		assert: node items third class equals: PSQLASTAttributeAccess.
		
	node := builder expression parse: '((-1::INT8) << 63, 0)::"link_strength"'.
	self
		assert: node class equals: PSQLASTBinaryOperator;
		assert: node left class equals: PSQLASTCompositeValue;
		assert: node left items size equals: 2;
		assert: node operator equals: '::';
		assert: node right class equals: PSQLASTIdentifier.
]

{ #category : #tests-expression }
PSQLASTBuilderTest >> testConditionalExpression [
	| node |
	node := builder expression parse: 'CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END'.
	self
		assert: node class equals: PSQLASTConditionalExpression;
		assert: node conditionsToExpressions size equals: 1;
		assert: node conditionsToExpressions first head class equals: PSQLASTParenthesedExpression;
		assert: node conditionsToExpressions first tail class equals: PSQLASTAttributeAccess;
		assert: node elseExpression class equals: PSQLASTAttributeAccess
]

{ #category : #'tests-delete command' }
PSQLASTBuilderTest >> testDeleteCommand [
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

{ #category : #tests-expression }
PSQLASTBuilderTest >> testExpressionParserTermFor [
	| node |
	node := builder expression parse: '''a String'''.
	self
		assert: node class equals: PSQLASTStringConstant.
		
	node := builder expression parse: '''a String''::text varying'.
	self
		assert: node class equals: PSQLASTBinaryOperator;
		assert: node left class equals: PSQLASTStringConstant;
		assert: node operator equals: '::';
		assert: node right class equals: PSQLASTIdentifier.
		
	node := builder expression parse: 'fct()'.
	self
		assert: node class equals: PSQLASTFunctionCall;
		assert: node argumentsList isEmpty;
		assert: node argumentsDictionary isEmpty
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testFetchClause [
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
PSQLASTBuilderTest >> testForClause [
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

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromClause [
	| node |
	node := builder fromClause parse: 'FROM affectation,support,personne'.
	
	self
		assert: node class equals: PSQLASTFromClause;
		assert: node items class equals: Array;
		assert: node items size equals: 3.
		
	node items do: [ :item |
		self assert: item class equals: PSQLASTFromClauseItemType1 ]
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems [
	| node |
	node :=  builder fromItems parse: '(((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle)))'.
	
	self
		assert: node class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem leftFromItem class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem leftFromItem leftFromItem class equals: PSQLASTFromClauseItemType1
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems1 [
	| node |
	node := builder fromItems1 parse: 'ONLY table * AS alias (c1, c2,C3)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType1;
		assert: node hasOnly;
		assert: node areDescendantTablesIncluded;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node hasColumnAliases;
		assert: node columnAliases class equals: Array;
		assert: node columnAliases size equals: 3.
		
	node := builder fromItems1 parse: 'table'.
	self
		assert: node class equals: PSQLASTFromClauseItemType1;
		deny: node hasOnly;
		deny: node areDescendantTablesIncluded;
		assert: node tableName class equals: PSQLASTIdentifier;
		deny: node hasAlias;
		deny: node hasColumnAliases
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems2 [
	| node |
	node := builder fromItems2 parse: '(SELECT * FROM foo) AS t (c1,c2,c3)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType2;
		deny: node hasLateral;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node hasColumnAliases;
		assert: node columnAliases class equals: Array;
		assert: node columnAliases size equals: 3;
		assert: node valuesOrSelect class equals: PSQLASTSelectQuery
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems3 [
	| node |
	node := builder fromItems3 parse: 'queryName queryAlias (c1,c2,c3)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType3;
		assert: node withQueryName class equals: PSQLASTIdentifier;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node hasColumnAliases;
		assert: node columnAliases class equals: Array;
		assert: node columnAliases size equals: 3
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems4 [
	| node |
	node := builder fromItems4 parse: 'LATERAL fct() AS t (c1 integer, c2 char)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType4;
		assert: node hasLateral;
		assert: node functionCall class equals: PSQLASTFunctionCall;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node columnDefinitions class equals: Array;
		assert: node columnDefinitions size equals: 2.
		
	node columnDefinitions do: [ :columnDefinition |
		self assert: columnDefinition class equals: PSQLASTColumnDefinition ]
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems5 [
	| node |
	node := builder fromItems5 parse: 'LATERAL fct() AS (c1 integer, c2 char)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType5;
		assert: node hasLateral;
		assert: node functionCall class equals: PSQLASTFunctionCall;
		assert: node columnDefinitions class equals: Array;
		assert: node columnDefinitions size equals: 2.
		
	node columnDefinitions do: [ :columnDefinition |
		self assert: columnDefinition class equals: PSQLASTColumnDefinition ]
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems6 [
	| node |
	node := builder fromItems6 parse: 'JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"'.
	self
		assert: node class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem isNil; "This is normal at this step"
		assert: node joinType equals: 'JOIN';
		assert: node rightFromItem class equals: PSQLASTFromClauseItemType1;
		assert: node hasJoinCondition;
		assert: node joinCondition class equals: PSQLASTBinaryOperator;
		deny: node hasNatural;
		deny: node hasUsingList.
		
	node := builder fromItems6 parse: 'NATURAL INNER JOIN test USING (foo)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem isNil; "This is normal at this step"
		assert: node joinType equals: 'INNER JOIN';
		assert: node rightFromItem class equals: PSQLASTFromClauseItemType1;
		deny: node hasJoinCondition;
		assert: node hasNatural;
		assert: node hasUsingList;
		assert: node usingList class equals: Array;
		assert: node usingList size equals: 1
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems7 [
	| node |
	node := builder fromItems7 parse: 'LATERAL fct() WITH ORDINALITY AS t (c1, c2)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType7;
		assert: node hasLateral;
		assert: node functionCall class equals: PSQLASTFunctionCall;
		assert: node hasWithOrdinality;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node hasColumnAliases;
		assert: node columnAliases class equals: Array;
		assert: node columnAliases size equals: 2.
		
	node columnAliases do: [ :columnAlias |
		self assert: columnAlias class equals: PSQLASTIdentifier ]
]

{ #category : #tests-expression }
PSQLASTBuilderTest >> testFunctionCallParserWith [
	| node |
	node := builder expression parse: 'fct(1, id, arg := ''argument'', 41 + 1)'.
	self
		assert: node class equals: PSQLASTFunctionCall;
		assert: node functionIdentifier class equals: PSQLASTIdentifier;
		assert: node functionIdentifier identifier equals: 'fct';
		assert: node argumentsList size equals: 3;
		assert: node argumentsList first class equals: PSQLASTNumericConstant;
		assert: node argumentsList second class equals: PSQLASTIdentifier;
		assert: node argumentsList third class equals: PSQLASTBinaryOperator;
		assert: node argumentsDictionary size equals: 1;
		assert: node argumentsDictionary associations first head class equals: PSQLASTIdentifier;
		assert: node argumentsDictionary associations first tail class equals: PSQLASTStringConstant
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testGroupByClause [
	| node |
	node := builder groupByClause parse: 'GROUP BY column'.
	
	self
		assert: node class equals: PSQLASTGroupByClause;
		assert: node expressions size equals: 1;
		assert: node expressions first class equals: PSQLASTIdentifier
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testHavingClause [
	| node |
	node := builder  havingClause parse: 'HAVING column'.
	
	self
		assert: node class equals: PSQLASTHavingClause;
		assert: node expressions size equals: 1;
		assert: node expressions first class equals: PSQLASTIdentifier
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testIdentifier [
	| node |
	node := builder identifier parse: 'id'.
	
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: 'id'
]

{ #category : #tests }
PSQLASTBuilderTest >> testIdentifierWithOptionalFieldAccess [
	| node |
	node := builder identifierWithOptionalFieldAccess parse: 'id'.
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: 'id'.
		
	node := builder identifierWithOptionalFieldAccess parse: 'id.attribute'.
	self
		assert: node class equals: PSQLASTAttributeAccess;
		assert: node accessed identifier equals: 'id';
		assert: node attributeIdentifier identifier equals: 'attribute'.
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testIntoClause [
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
PSQLASTBuilderTest >> testLimitClause [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testNumericConstant [
	| node |
	node := builder numericConstant parse: '1.21'.
	
	self
		assert: node class equals: PSQLASTNumericConstant;
		assert: node content equals: '1.21'
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testOffsetClause [
	| node |
	node := builder offsetClause parse: 'OFFSET 42'.
	
	self
		assert: node class equals: PSQLASTOffsetClause;
		assert: node offset class equals: PSQLASTNumericConstant.
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testOrderByClause [
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

{ #category : #tests-expression }
PSQLASTBuilderTest >> testParenthesedExpressionParserWith [
	| node |
	node := builder expression parse: '(id+1)'.
	self
		assert: node class equals: PSQLASTParenthesedExpression;
		assert: node expression class equals: PSQLASTBinaryOperator
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPositionalParameter [
	| node |
	node := builder positionalParameter parse: '$1'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTPositionalParameter;
		assert: node index equals: 1
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testReturningClause [
	| node |
	node := builder returningClause parse: 'RETURNING *,id'.
	self
		assert: node class equals: PSQLASTReturningClause;
		assert: node returnedList size equals: 2
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testSelectCommand [
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
PSQLASTBuilderTest >> testSelectIntoCommandAlternative [
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
PSQLASTBuilderTest >> testSelectIntoCommandClassic [
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

{ #category : #tests-shared }
PSQLASTBuilderTest >> testSetClause [
	| node |
	node := builder setClause parse: 'SET column = 1+1, (column1, column2, column3) = (SELECT c1,c2,c3 FROM foo), (column1, column2, column3) = (SELECT c1,c2,c3 FROM foo)'.
	self
		assert: node class equals: PSQLASTSetClause;
		assert: node items class equals: Array;
		assert: node items size equals: 3
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testSetItem1 [
	| node |
	node := builder setItem1 parse: 'column = 1+1'.
	self
		assert: node class equals: PSQLASTSetClauseItemType1;
		assert: node left class equals: PSQLASTIdentifier;
		assert: node right class equals: PSQLASTBinaryOperator
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testSetItem2 [
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

{ #category : #tests-shared }
PSQLASTBuilderTest >> testSetItem3 [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testSimpleStringConstant [
	| node |
	node := builder simpleStringConstant parse: '''test'''.
	
	self
		assert: node class equals: PSQLASTStringConstant;
		assert: node content equals: 'test'
]

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testUnionIntersectExceptClause [
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

{ #category : #tests-shared }
PSQLASTBuilderTest >> testUpdateDeleteWhereClause [
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

{ #category : #'tests-select command' }
PSQLASTBuilderTest >> testWhereClause [
	| node |
	node := builder whereClause parse: 'WHERE t.id = 42'.
	
	self
		assert: node class equals: PSQLASTSelectWhereClause;
		assert: node condition class equals: PSQLASTBinaryOperator
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testWithClause [
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

{ #category : #tests-shared }
PSQLASTBuilderTest >> testWithQuery [
	| node |
	node := builder withQuery parse: 'table AS (SELECT * FROM foo)'.
	self
		assert: node class equals: Association;
		assert: node head class equals: PSQLASTTableAlias;
		assert: node head identifier identifier equals: 'table';
		assert: node head columnAliases size equals: 0.
		
	node := builder withQuery parse: 'table(id,bar) AS (SELECT * FROM foo)'.
	self
		assert: node class equals: Association;
		assert: node head class equals: PSQLASTTableAlias;
		assert: node head identifier identifier equals: 'table';
		assert: node head columnAliases size equals: 2;
		assert: (node head columnAliases allSatisfy: [ :item | item class = PSQLASTIdentifier ])
]
