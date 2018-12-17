"
I am an abstract node of the AST. I define the common behaviour and state of all AST nodes.
"
Class {
	#name : #PSQLASTNode,
	#superclass : #Object,
	#instVars : [
		'startPosition',
		'endPosition',
		'parent'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #accessing }
PSQLASTNode class >> abstractSubClassNames [
	^ #(#PSQLASTCRUDQuery #PSQLASTConstant #PSQLASTExpressionASTNode #PSQLASTFromClauseItem #PSQLASTOperator #PSQLASTSetClauseItem #PSQLASTSetOperatorClause #PSQLPlpgSQLASTNode #PSQLPlpgSQLASTConditional #PSQLPlpgSQLASTDeclaration #PSQLPlpgSQLASTLoop #PSQLASTNode)
]

{ #category : #testing }
PSQLASTNode class >> isAbstract [
	^ self name = #PSQLASTNode or: [ self abstractSubClassNames includes: self name ]
]

{ #category : #accessing }
PSQLASTNode class >> withAllConcreteSubclasses [
	^ self withAllSubclasses reject: #isAbstract
]

{ #category : #enumerating }
PSQLASTNode >> allParents [
	^ self allParentsGenerator upToEnd
]

{ #category : #enumerating }
PSQLASTNode >> allParentsDo: aBlock [
	"Iterates on all the parents. Starting from current node parent finishing by the top node of the AST."
	| generator |
	generator := self allParentsGenerator.
	[ generator atEnd ] whileFalse: [ 
		aBlock value: generator next ]
]

{ #category : #generators }
PSQLASTNode >> allParentsGenerator [
	^ Generator on: [ :generator |
		| currentParent |
		currentParent := self.
		[ (currentParent := currentParent parent) isNotNil ]
			whileTrue: [ generator yield: currentParent ] ]
]

{ #category : #testing }
PSQLASTNode >> anyParentSatisfy: aBlock [
	self allParentsDo: [ :p |
		(aBlock value: p)
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #enumerating }
PSQLASTNode >> breadthFirstDetect: aBlock [
	^ self breadthFirstDetect: aBlock ifFound: [ :found | ^ found ]
]

{ #category : #enumerating }
PSQLASTNode >> breadthFirstDetect: aBlock ifFound: ifFoundBlock [
	^ self breadthFirstDetect: aBlock ifFound: ifFoundBlock ifNone: [ NotFound signalFor: aBlock ]
]

{ #category : #enumerating }
PSQLASTNode >> breadthFirstDetect: aBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	"Search for the first node for which aBlock returns true.
	 If found, evaluate ifFoundBlock with the found node as arg.
	 If not found, evaluate ifNoneBlock without arg.
	 Walks the tree breadth-first."
	self breadthFirstDo: [ :child |
		(aBlock value: child)
			ifTrue: [ ^ ifFoundBlock value: child ] ].
		
	ifNoneBlock value
]

{ #category : #enumerating }
PSQLASTNode >> breadthFirstDetect: aBlock ifNone: ifNoneBlock [
	^ self breadthFirstDetect: aBlock ifFound: [ :found | ^ found ] ifNone: ifNoneBlock
]

{ #category : #enumerating }
PSQLASTNode >> breadthFirstDo: aBlock [
	"Executes aBlock on myself and recursively on all the hierarchy of nodes forming the AST.
	 I do breadth-first walk."
	| generator |
	generator := self breadthFirstGenerator.
	[ generator atEnd ] whileFalse: [ 
		aBlock value: generator next ]
]

{ #category : #generators }
PSQLASTNode >> breadthFirstGenerator [
	"Returns a Generator that walks the tree breadth-first."
	^ Generator on: [ :generator |
		|visitStack|
		visitStack := LinkedList new.
		visitStack addFirst: self.
		[ visitStack isNotEmpty  ] whileTrue: [
			|currentNode|
			currentNode := visitStack removeLast.
			generator yield: currentNode.
			currentNode childrenDo: [ :child |
				visitStack addFirst: child ] ] ]
]

{ #category : #enumerating }
PSQLASTNode >> breadthFirstSelect: aBlock [
	"Select nodes of the AST for which aBlock returns true.
	 Returns these nodes in an OrderedCollection."
	| selected |
	selected := OrderedCollection new.
	self breadthFirstDo: [ :child |
		(aBlock value: child)
			ifTrue: [ selected add: child ] ].
	^ selected
]

{ #category : #'accessing - reflective' }
PSQLASTNode >> children [
	^ OrderedCollection streamContents: [ :stream | 
			self instanceVariableNamesToChildrenDo: [ :instVarName :nodeOrCollection |
				stream nextPutAll: nodeOrCollection asOrderedCollection ] ]
]

{ #category : #enumerating }
PSQLASTNode >> childrenDo: aBlock [
	self children do: aBlock
]

{ #category : #enumerating }
PSQLASTNode >> depthFirstDetect: aBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	"Search for the first node for which aBlock returns true.
	 If found, evaluate ifFoundBlock with the found node as arg.
	 If not found, evaluate ifNoneBlock without arg.
	 Walks the tree depth-first."
	self depthFirstDo: [ :child |
		(aBlock value: child)
			ifTrue: [ ^ ifFoundBlock value: child ] ].
		
	ifNoneBlock value
]

{ #category : #enumerating }
PSQLASTNode >> depthFirstDo: aBlock [
	"Executes aBlock on myself and recursively on all the hierarchy of nodes forming the AST.
	 I do depth-first walk."
	| generator |
	generator := self depthFirstGenerator.
	[ generator atEnd ] whileFalse: [ 
		aBlock value: generator next ]
]

{ #category : #generators }
PSQLASTNode >> depthFirstGenerator [
	"Returns a Generator that walks the tree depth-first."
	^ Generator on: [ :generator |
		|visitStack|
		visitStack := Stack new.
		visitStack push: self.
		[ visitStack isNotEmpty  ] whileTrue: [
			|currentNode|
			currentNode := visitStack pop.
			generator yield: currentNode.
			currentNode children reverseDo: [ :child |
				visitStack push: child ] ] ]
]

{ #category : #accessing }
PSQLASTNode >> endPosition [
	^ endPosition
]

{ #category : #accessing }
PSQLASTNode >> endPosition: anObject [
	endPosition := anObject
]

{ #category : #printing }
PSQLASTNode >> innerPrintOn: aStream [
	"To override if needed."
]

{ #category : #'accessing - reflective' }
PSQLASTNode >> instanceVariableNamesToChildren [
	^ OrderedCollection streamContents: [ :stream | 
			self instanceVariableNamesToChildrenDo: [ :instVarName :nodeOrCollection |
				stream nextPut: instVarName -> nodeOrCollection  ] ]
]

{ #category : #'accessing - reflective' }
PSQLASTNode >> instanceVariableNamesToChildrenDo: aBlock [
	"Evaluates aBlock with, as arguments, the name of the inst. var and the AST node it holds (or the collection of AST nodes depending on what is contained in the inst. var.)."
	^ (self class allInstVarNames \ { #parent }) sorted
		do: [ :instanceVar | 
			(self perform: instanceVar)
				in: [ :varContent | 
					varContent isPSQLASTNode
						ifFalse: [ (varContent isString not and: [ varContent isCollection ])
								ifTrue: [ aBlock value: instanceVar value: varContent ] ]
						ifTrue: [ aBlock value: instanceVar value: varContent ] ] ]
]

{ #category : #testing }
PSQLASTNode >> isConstant [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isPSQLASTNode [
	^ true
]

{ #category : #accessing }
PSQLASTNode >> parent [
	^ parent
]

{ #category : #accessing }
PSQLASTNode >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
PSQLASTNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $(.
	self innerPrintOn: aStream.
	aStream
		<< $)
]

{ #category : #'parent management' }
PSQLASTNode >> setChildrenParent [
	self childrenDo: [ :child |
		child parent: self.
		child setChildrenParent ]
]

{ #category : #accessing }
PSQLASTNode >> startPosition [
	^ startPosition
]

{ #category : #accessing }
PSQLASTNode >> startPosition: anObject [
	startPosition := anObject
]
