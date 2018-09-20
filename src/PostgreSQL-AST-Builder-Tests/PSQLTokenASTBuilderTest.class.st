Class {
	#name : #PSQLTokenASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'PostgreSQL-AST-Builder-Tests'
}

{ #category : #initialization }
PSQLTokenASTBuilderTest >> setUp [
	builder := PSQLTokenASTBuilder new
]

{ #category : #'tests-accessing' }
PSQLTokenASTBuilderTest >> testIdentifier [
	| node |
	node := builder identifier parse: 'id'.
	
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: 'id'
]

{ #category : #'tests-accessing' }
PSQLTokenASTBuilderTest >> testIdentifierWithOptionalFieldAccess [
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

{ #category : #'tests-accessing' }
PSQLTokenASTBuilderTest >> testNumericConstant [
	| node |
	node := builder numericConstant parse: '1.21'.
	
	self
		assert: node class equals: PSQLASTNumericConstant;
		assert: node content equals: '1.21'
]

{ #category : #'tests-accessing' }
PSQLTokenASTBuilderTest >> testPositionalParameter [
	| node |
	node := builder positionalParameter parse: '$1'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTPositionalParameter;
		assert: node index equals: 1
]

{ #category : #'tests-accessing' }
PSQLTokenASTBuilderTest >> testSimpleStringConstant [
	| node |
	node := builder simpleStringConstant parse: '''test'''.
	
	self
		assert: node class equals: PSQLASTStringConstant;
		assert: node content equals: 'test'
]
