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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testNumericConstant [
	| node |
	node := builder numericConstant parse: '1.21'.
	
	self
		assert: node class equals: PSQLASTNumericConstant;
		assert: node content equals: '1.21'
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testSimpleStringConstant [
	| node |
	node := builder simpleStringConstant parse: '''test'''.
	
	self
		assert: node class equals: PSQLASTStringConstant;
		assert: node content equals: 'test'
]
