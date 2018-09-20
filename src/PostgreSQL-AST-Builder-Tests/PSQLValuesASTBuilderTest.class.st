Class {
	#name : #PSQLValuesASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'PostgreSQL-AST-Builder-Tests'
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
		assert: node class equals: PSQLASTValuesCommand;
		assert: node values size equals: 3;
		assert: node values first class equals: PSQLASTNumericConstant;
		assert: node values second class equals: PSQLASTDefaultValue;
		assert: node values third class equals: PSQLASTBinaryOperator.
	node := builder valuesCommand parse: 'VALUES (1, 2, 3), (4,5,6), (7,8,9)'.
	self
		assert: node class equals: PSQLASTValuesCommand;
		assert: node values size equals: 9
]
