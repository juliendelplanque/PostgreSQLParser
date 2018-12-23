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
									left: ((PSQLASTIdentifier identifier: 'foo')
												startPosition: 1;
												endPosition: 3;
												yourself);
									right: ((PSQLASTNumericConstant content: '1')
													startPosition: 7;
													endPosition: 7;
													yourself);
									operator: '*';
									startPosition: 1;
									endPosition: 7;
									yourself);
						right: ((PSQLASTNumericConstant content: '2')
									startPosition: 11;
									endPosition: 11;
									yourself);
						operator: '+';
						startPosition: 1;
						endPosition: 11;
						yourself.
						
	sampleNode setChildrenParent
]

{ #category : #tests }
PSQLASTNodeTest >> testAllParents [
	self assertCollection: sampleNode left left allParents equals: { sampleNode left . sampleNode } asOrderedCollection.
	
	self assertCollection: sampleNode left allParents equals: { sampleNode } asOrderedCollection.
	
	self assertCollection: sampleNode allParents equals: OrderedCollection new
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
