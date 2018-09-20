"
A PSQLFromClauseASTBuilderTest is a test class for testing the behavior of PSQLFromClauseASTBuilder
"
Class {
	#name : #PSQLFromClauseASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'PostgreSQL-AST-Builder-Tests'
}

{ #category : #initialization }
PSQLFromClauseASTBuilderTest >> setUp [
	builder := PSQLFromClauseASTBuilder new
]

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testColumnDefinition [
		| node |
	node := builder columnDefinition parse: 'c VARYING CHAR'.
	self
		assert: node class equals: PSQLASTColumnDefinition;
		assert: node columnName class equals: PSQLASTIdentifier;
		assert: node columnName identifier equals: 'c';
		assert: node type class equals: PSQLASTIdentifier;
		assert: node type identifier equals: 'VARYING CHAR'
]

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromClause [
	| node |
	node := builder fromClause parse: 'FROM affectation,support,personne'.
	
	self
		assert: node class equals: PSQLASTFromClause;
		assert: node items class equals: Array;
		assert: node items size equals: 3.
		
	node items do: [ :item |
		self assert: item class equals: PSQLASTFromClauseItemType1 ]
]

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromItems [
	| node |
	node :=  builder fromItems parse: '(((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle)))'.
	
	self
		assert: node class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem leftFromItem class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem leftFromItem leftFromItem class equals: PSQLASTFromClauseItemType1
]

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromItems1 [
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

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromItems2 [
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

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromItems3 [
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

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromItems4 [
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

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromItems5 [
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

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromItems6 [
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

{ #category : #'tests-shared' }
PSQLFromClauseASTBuilderTest >> testFromItems7 [
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
