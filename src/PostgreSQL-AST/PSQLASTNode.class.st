"
I am an abstract node of the AST. I define the common behaviour and state of all AST nodes.
"
Class {
	#name : #PSQLASTNode,
	#superclass : #Object,
	#traits : 'TQIterable',
	#classTraits : 'TQIterable classTrait',
	#instVars : [
		'startPosition',
		'endPosition',
		'parent',
		'sourceCode'
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

{ #category : #'accessing - reflective' }
PSQLASTNode >> children [
	| children |
	children := OrderedCollection streamContents: [ :stream | 
			self instanceVariableNamesToChildrenDo: [ :instVarName :nodeOrCollection |
				stream nextPutAll: nodeOrCollection asOrderedCollection ] ].
	(children allSatisfy: [ :node | node startPosition isNotNil and: [ node endPosition isNotNil ] ])
		ifFalse: [ 
			Warning signal: 'All positions of children are not set. Returning unordered children.'.
			^ children ].

	^ children sort: [ :nodeA :nodeB |
		nodeA startPosition < nodeB startPosition
			and: [ nodeA endPosition < nodeB endPosition ] ]
]

{ #category : #enumerating }
PSQLASTNode >> childrenDo: aBlock [
	self children do: aBlock
]

{ #category : #accessor }
PSQLASTNode >> childrenSelector [
	^ #children
]

{ #category : #accessing }
PSQLASTNode >> classNameWithoutPrefix [
	^ self className allButFirst: 7
]

{ #category : #accessing }
PSQLASTNode >> endPosition [
	^ endPosition
]

{ #category : #accessing }
PSQLASTNode >> endPosition: anObject [
	endPosition := anObject
]

{ #category : #testing }
PSQLASTNode >> hasParent [
	^ self parent isNotNil
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
PSQLASTNode >> isNumericConstant [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isPSQLASTNode [
	^ true
]

{ #category : #testing }
PSQLASTNode >> isRoot [
	^ self hasParent not
]

{ #category : #testing }
PSQLASTNode >> isStringConstant [
	^ false
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
		<< $[.
	self startPosition
		ifNotNil: [ aStream << self startPosition ]
		ifNil: [ aStream << $? ].
	aStream << $:.
	self endPosition
		ifNotNil: [ aStream << self endPosition ]
		ifNil: [ aStream << $? ].
	aStream
		<< $];
		<< $(.
	self innerPrintOn: aStream.
	aStream
		<< $)
]

{ #category : #accessing }
PSQLASTNode >> root [
	^ self allParents last
]

{ #category : #'parent management' }
PSQLASTNode >> setChildrenParent [
	self childrenDo: [ :child |
		child parent: self.
		child setChildrenParent ]
]

{ #category : #accessing }
PSQLASTNode >> sourceCode [
	sourceCode
		ifNotNil: [ ^ sourceCode ].
	
	"If I hold no source code but I have a parent, I ask my parent because the top parent will hold the source code."
	self hasParent
		ifTrue: [ ^ self parent sourceCode ].
	
	"If I have no parent, I am at the top of the AST. Since I have no source code, I return nil."
	^ nil
]

{ #category : #accessing }
PSQLASTNode >> sourceCode: anObject [
	sourceCode := anObject
]

{ #category : #accessing }
PSQLASTNode >> startPosition [
	^ startPosition
]

{ #category : #accessing }
PSQLASTNode >> startPosition: anObject [
	startPosition := anObject
]
