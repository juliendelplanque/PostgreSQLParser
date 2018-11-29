Class {
	#name : #PSQLASTNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'sampleNode'
	],
	#category : #'PostgreSQL-AST-Tests'
}

{ #category : #running }
PSQLASTNodeTest >> setUp [
	super setUp.
	sampleNode := PSQLASTBinaryOperator new
						left: (PSQLASTBinaryOperator new
									left: (PSQLASTIdentifier identifier: 'foo');
									right: (PSQLASTNumericConstant content: '1');
									operator: '*';
									yourself);
						right: (PSQLASTNumericConstant content: '2');
						operator: '+';
						yourself
]

{ #category : #tests }
PSQLASTNodeTest >> testBreadthFirstGenerator [
	| gen |
	gen := sampleNode breadthFirstGenerator.
	self assert: gen next equals: sampleNode.
	self assert: gen next equals: sampleNode left.
	self assert: gen next equals: sampleNode right.
	self assert: gen next equals: sampleNode left left.
	self assert: gen next equals: sampleNode left right.
	self assert: gen atEnd
]

{ #category : #tests }
PSQLASTNodeTest >> testChildren [
	self
		assertCollection: sampleNode children
		equals: { sampleNode left. sampleNode right } asOrderedCollection
]

{ #category : #tests }
PSQLASTNodeTest >> testDepthFirstGenerator [
	| gen |
	gen := sampleNode depthFirstGenerator.
	self assert: gen next equals: sampleNode.
	self assert: gen next equals: sampleNode left.
	self assert: gen next equals: sampleNode left left.
	self assert: gen next equals: sampleNode left right.
	self assert: gen next equals: sampleNode right.
	self assert: gen atEnd
]

{ #category : #tests }
PSQLASTNodeTest >> testInstanceVariableNamesToChildren [
	self
		assertCollection: sampleNode instanceVariableNamesToChildren
		equals: { 
			#expression -> sampleNode left.
			#right -> sampleNode right } asOrderedCollection
]
