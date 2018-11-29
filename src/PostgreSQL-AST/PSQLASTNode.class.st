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

{ #category : #printing }
PSQLASTNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $(.
	self innerPrintOn: aStream.
	aStream
		<< $)
]

{ #category : #accessing }
PSQLASTNode >> startPosition [
	^ startPosition
]

{ #category : #accessing }
PSQLASTNode >> startPosition: anObject [
	startPosition := anObject
]
