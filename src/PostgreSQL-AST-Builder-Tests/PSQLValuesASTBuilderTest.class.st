Class {
	#name : #PSQLValuesASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #PostgreSQL-AST-Builder-Tests
}

{ #category : #running }
PSQLValuesASTBuilderTest >> setUp [
	builder := PSQLValuesASTBuilder new
]

{ #category : #'tests-values command' }
PSQLValuesASTBuilderTest >> testValuesCommand [
	| node |
	node := builder valuesCommand parse: 'VALUES (1, DEFAULT, var+1)'.
	self
		assert: node class equals: Array;
		assert: node size equals: 1;
		assert: node first class equals: Array;
		assert: node first size equals: 3;
		assert: node first first class equals: PSQLASTNumericConstant;
		assert: node first second class equals: PSQLASTDefaultValue;
		assert: node first third class equals: PSQLASTBinaryOperator.
		
	node := builder valuesCommand parse: 'VALUES (1, 2, 3), (4,5,6), (7,8,9)'.
	self
		assert: node class equals: Array;
		assert: node size equals: 3.
	node do: [ :row |
		self
			assert: row class equals: Array;
			assert: row size equals: 3 ]
]
