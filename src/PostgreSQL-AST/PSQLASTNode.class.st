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
PSQLASTNode >> isAggregateFunctionCall [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isAliasDeclaration [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isAliasDefinition [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isAllClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isAlternativeSelectIntoQuery [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isArgument [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isArrayConstructor [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isArrayLoop [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isAssignment [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isAttributeAccess [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isBinaryOperator [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isBlock [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isBlockLabel [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCRUDQuery [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCaseExpression [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCaseToExpression [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCasesToStatements [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCastExpression [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isClassicDeclaration [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isColumnDefinition [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCompositeValue [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isConditionToExpression [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isConditionToStatements [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isConditional [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isConditionalExpression [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isConflictAction [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isConstant [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isContinue [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCopyTypeDeclaration [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorClose [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorDeclaration [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorDelete [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorFetch [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorFetchDirection [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorMove [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorMoveDirection [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorOpen [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorOpenForExecute [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorOpenForQuery [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorParameter [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorStatement [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isCursorUpdate [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isDeclaration [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isDefaultValue [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isDefaultValues [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isDeleteQuery [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isDistinctClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isExceptClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isExceptionCase [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isExceptionHandler [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isExit [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isExpressionASTNode [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isExtractFunctionCall [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFetchClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isForClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isForLoop [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClauseItem [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClauseItemType1 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClauseItemType2 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClauseItemType3 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClauseItemType4 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClauseItemType5 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClauseItemType6 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFromClauseItemType7 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isFunctionCall [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isGroupByClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isHavingClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isIdentifier [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isIf [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isInsertQuery [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isIntersectClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isIntoClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isLimitClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isLoop [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isNode [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isNull [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isNumericConstant [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isOffsetClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isOnConflictClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isOperator [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isOrderByClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isOrderByClauseItem [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isPSQLASTNode [
	^ true
]

{ #category : #testing }
PSQLASTNode >> isParenthesedExpression [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isPerform [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isPositionalParameter [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isPostfixOperator [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isPrefixOperator [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isQueryResultsLoop [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isRaiseStatement [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isRecordDeclaration [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isReturnStatement [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isReturningClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isRoot [
	^ self hasParent not
]

{ #category : #testing }
PSQLASTNode >> isRowTypeDeclaration [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSearchedCase [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSelectIntoQuery [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSelectQuery [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSelectWhereClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSetClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSetClauseItem [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSetClauseItemType1 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSetClauseItemType2 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSetClauseItemType3 [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSetOperatorClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSimpleCase [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isStringConstant [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isSubscript [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isTableAlias [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isType [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isUnionClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isUpdateDeleteWhereClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isUpdateQuery [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isUsingClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isValuesClause [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isValuesCommand [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isWhenExpression [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isWhileLoop [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isWildCard [
	^ false
]

{ #category : #testing }
PSQLASTNode >> isWithClause [
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
