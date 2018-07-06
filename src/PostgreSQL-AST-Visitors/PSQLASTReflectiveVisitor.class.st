Class {
	#name : #PSQLASTReflectiveVisitor,
	#superclass : #PSQLASTVisitor,
	#traits : 'PSQLSolverUserVisitor',
	#classTraits : 'PSQLSolverUserVisitor classTrait',
	#instVars : [
		'model',
		'function',
		'report'
	],
	#category : #'PostgreSQL-AST-Visitors'
}

{ #category : #'instance creation' }
PSQLASTReflectiveVisitor class >> model: aMooseModel function: aFunction [
	^ self new
		model: aMooseModel;
		function: aFunction;
		yourself
]

{ #category : #'instance creation' }
PSQLASTReflectiveVisitor class >> model: aMooseModel function: aFmxSQLStoredProcedure errorReport: aPSQParsingReport [
	^ (self model: aMooseModel function: aFmxSQLStoredProcedure)
		errorReport: aPSQParsingReport;
		yourself
]

{ #category : #children }
PSQLASTReflectiveVisitor >> childrenFor: aNode [
	^ aNode class instanceVariables
		flatCollect: [ :instanceVar | 
			(aNode perform: instanceVar)
				in: [ :varContent | 
					varContent isPSQLASTNode
						ifFalse: [ (varContent isString not and: [ varContent isCollection ])
								ifTrue: [ varContent ]
								ifFalse: [ {} ] ]
						ifTrue: [ varContent asCollection ] ] ]
]

{ #category : #convenient }
PSQLASTReflectiveVisitor >> createClause: aClauseClass from: aPSQLASTClauseNode [
	^ (self createEntity: aClauseClass from: aPSQLASTClauseNode)
		query: self currentEntity;
		yourself
]

{ #category : #'entity creation' }
PSQLASTReflectiveVisitor >> createEntity: anEntityClass [ 
	^ anEntityClass new
		mooseModel: self model;
		yourself
]

{ #category : #'entity creation' }
PSQLASTReflectiveVisitor >> createEntity: anEntityClass from: aPSQLASTNode [ 
	^ self createEntity: anEntityClass 
]

{ #category : #convenient }
PSQLASTReflectiveVisitor >> createQueryContainedByCurrentEntity: aClass from: anASTNode [
	| newQuery currentEntity |
	newQuery := self createEntity: aClass from: anASTNode.
	currentEntity := self currentEntity.
	self flag: #TODO.	"change test to isQueryContainer"
	(currentEntity class = FmxSQLStoredProcedure or: [ currentEntity class = FmxSQLCursor ])
		ifTrue:
			[ "If current entity is a storedProcedure we can directly set the entity as contained by it" newQuery container: currentEntity ]
		ifFalse: [ "Otherwise we need to create a reference to a DerivedTable"
			(self createEntity: FmxSQLDerivedTable)
				createReferenceEntityFrom: currentEntity;
				query: newQuery;
				yourself ].
	^ newQuery
]

{ #category : #'convenient linking' }
PSQLASTReflectiveVisitor >> createReferenceTo: anEntity [
	^ (anEntity value createReferenceEntityFrom: self currentEntity)
		mooseModel: self model;
		yourself
]

{ #category : #finding }
PSQLASTReflectiveVisitor >> findColumnNamed: aColumnName inTableOrView: aFmxSQLView [ 
	^ aFmxSQLView columns detect: [ :column | column name = aColumnName ]
]

{ #category : #finding }
PSQLASTReflectiveVisitor >> findTableNamed: anIdentifier [ 
	^ (self model allWithType: FmxSQLTable) detect: [ :table | table name = anIdentifier ]  .
]

{ #category : #finding }
PSQLASTReflectiveVisitor >> findTableOrViewNamed: aString [
	^ [ self findTableNamed: aString ]
		on: NotFound
		do: [ self findViewNamed: aString ]
]

{ #category : #finding }
PSQLASTReflectiveVisitor >> findTypeNamed: aName [
	^ [ self findTableOrViewNamed: aName ]
		on: NotFound
		do: [ (self model allWithType: FmxSQLType)
				detect: [ :aType | aType name = aName ]
				ifNone: [ (self createEntity: FmxSQLType) name: aName ] ]
]

{ #category : #finding }
PSQLASTReflectiveVisitor >> findViewNamed: anIdentifier [
	^ (self model allWithType: FmxSQLView) detect: [ :table | table name = anIdentifier ]
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> function [
	^ function
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> function: anObject [
	function := anObject.
	self currentEntity: function
]

{ #category : #'convenient linking' }
PSQLASTReflectiveVisitor >> linkReferencedEntities: aPSQIdentifierWithNode [
	self flag: #TODO.	"add position in source"
	aPSQIdentifierWithNode entity
		ifNotNil: [ self createReferenceTo: aPSQIdentifierWithNode entity ].
	aPSQIdentifierWithNode isLast
		ifFalse: [ self linkReferencedEntities: aPSQIdentifierWithNode next ]
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> model [
	^ model
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> model: anObject [
	model := anObject.
	self initialiseSolver.
	self
		pushEntitiesAsScope: (model allWithType: FmxSQLTable) , (model allWithType: FmxSQLView)
]

{ #category : #convenient }
PSQLASTReflectiveVisitor >> resolveAndLinkSilently: identifiers [ 
	self resolveSilently: identifiers.
	self linkReferencedEntities: identifiers.
	
]

{ #category : #testing }
PSQLASTReflectiveVisitor >> shouldRejectIdentifiers: aPSQIdentifierWithNode [
	^ #('true' 'false' 'array') includes: aPSQIdentifierWithNode identifier
]

{ #category : #'visiting - convenience' }
PSQLASTReflectiveVisitor >> visit: aNode [ 
	^ self visit: aNode thenDo: [:res | res ]
]

{ #category : #'visit convenient' }
PSQLASTReflectiveVisitor >> visit: nilOrNode thenDo: aBlockClosure [
	^ nilOrNode ifNotNil: [ ^ aBlockClosure value: (nilOrNode acceptVisitor: self) ]
]

{ #category : #'visiting - convenience' }
PSQLASTReflectiveVisitor >> visitAll: aCollection [
	^ self visitAll: aCollection thenDoForEach: [ :e |  ]
]

{ #category : #'visiting - convenience' }
PSQLASTReflectiveVisitor >> visitAll: aCollection thenDoForEach: aBlockClosure [
	aCollection ifNotNil: [ aCollection do: [ :aNode | self visit: aNode thenDo: aBlockClosure ] ]
]

{ #category : #'visiting - convenience' }
PSQLASTReflectiveVisitor >> visitCollectionOfCollection: aCollectionOfCollectionOfNodes thenDoForEach: aBlockClosure [
	aCollectionOfCollectionOfNodes do: [ :aCollectionOfNodes | self visitAll: aCollectionOfNodes thenDoForEach: aBlockClosure ]
]

{ #category : #'visiting - convenience' }
PSQLASTReflectiveVisitor >> visitExpression: anExpressionNode [
	self flag: #TODO. "Temporary. Quite sure to put that in the top of the context pile"
	^ self visit: anExpressionNode thenDo: [ :res | res ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQASTNull: aPSQLASTNull [ 
	^ aPSQLASTNull 
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAggregateFunctionCall: aPSQLASTAggregateFunctionCall [
	(self childrenFor: aPSQLASTAggregateFunctionCall) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAliasDefinition: aPSQLASTAliasDefinition [
	self
		defineAliasInCurrentScope: (self visit: aPSQLASTAliasDefinition alias)
		for: [ self visit: aPSQLASTAliasDefinition definition ].
	^ self solver topScope
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAllClause: aPSQLASTAllClause [
	(self childrenFor: aPSQLASTAllClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAlternativeSelectIntoQuery: aPSQLASTAlternativeSelectIntoQuery [
	(self childrenFor: aPSQLASTAlternativeSelectIntoQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTArgument: aPSQLASTArgument [
	self flag: #TODO.	"Maybe we can do more with the parameter name in the linking"
	^ self visit: aPSQLASTArgument parameterValue
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTArrayConstructor: aPSQLASTArrayConstructor [
	(self childrenFor: aPSQLASTArrayConstructor) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAttributeAccess: aPSQLASTAttributeAccess [
	| identifiers |
	identifiers := nil.
	self
		visit: aPSQLASTAttributeAccess attributeIdentifier
		thenDo:
			[ :identifier | identifiers := PSQIdentifierWithNode identifier: identifier node: aPSQLASTAttributeAccess attributeIdentifier next: identifiers ].
	self
		visit: aPSQLASTAttributeAccess accessed
		thenDo: [ :identifier | identifiers := PSQIdentifierWithNode identifier: identifier node: aPSQLASTAttributeAccess accessed next: identifiers ].

	"We check that the identifier should be ignored (for example true or false)"
	(self shouldRejectIdentifiers: identifiers)
		ifTrue: [ ^ nil ].
		
	[ self resolveAndLinkSilently: identifiers ]
		on: NotFound
		do: [ :anError | 
			"new and old are implicit declared variables in stored procedures"
			(identifiers identifier = 'new' or: [ identifiers identifier = 'old' ])
				ifTrue: [ FmxSQLLocalVariable new
						name: identifiers identifier;
						storedProcedure: self function;
						mooseModel: self model.
					self resolveAndLinkSilently: identifiers ]
				ifFalse: [ anError signal ] ].
	^ identifiers targetEntity
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTBinaryOperator: aPSQLASTBinaryOperator [
	(self childrenFor: aPSQLASTBinaryOperator) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTColumnDefinition: aPSQLASTColumnDefinition [
	(self childrenFor: aPSQLASTColumnDefinition) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTCompositeValue: aPSQLASTCompositeValue [
	(self childrenFor: aPSQLASTCompositeValue) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTConditionalExpression: aPSQLASTConditionalExpression [
	aPSQLASTConditionalExpression conditionsToExpressions
		do: [ :aConditionToExpresion | 
			self visitExpression: aConditionToExpresion key.
			self visitExpression: aConditionToExpresion value ].
	self visitExpression: aPSQLASTConditionalExpression elseExpression
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTConflictAction: aPSQLASTConflictAction [
	(self childrenFor: aPSQLASTConflictAction) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTCursorParameter: aPSQLASTCursorParameter [
	| parameter |
	parameter := self createEntity: FmxSQLCursorParameter from: aPSQLASTCursorParameter.
	parameter
		name: (self visit: aPSQLASTCursorParameter parameterName);
		type: (self findTypeNamed: (self visit: aPSQLASTCursorParameter type));
		cursor: self currentEntity.
	^ parameter
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDefaultValue: aPSQLASTDefaultValue [
	(self childrenFor: aPSQLASTDefaultValue) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDefaultValues: aPSQLASTDefaultValues [
	(self childrenFor: aPSQLASTDefaultValues) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDeleteQuery: aPSQLASTDeleteQuery [
	| scopeManager |
	scopeManager := self solver createScopeManager.
	self
		useCurrentEntity: (self createQueryContainedByCurrentEntity: FmxSQLDeleteQuery from: aPSQLASTDeleteQuery)
		during: [ "First we create the from clause of the query"
			self
				visit: aPSQLASTDeleteQuery tableName
				thenDo: [ :tableName | 
					self
						useCurrentEntity: (self createEntity: FmxSQLFromClause from: aPSQLASTDeleteQuery tableName)
						during: [ self createReferenceTo: (self findTableOrViewNamed: tableName) ] ].
			self visit: aPSQLASTDeleteQuery withClause.
			self
				visit: aPSQLASTDeleteQuery usingList
				thenDo: [ :usingScope | 
					usingScope isCurrentEntity: false.
					scopeManager pushScope: usingScope ].
			self visit: aPSQLASTDeleteQuery whereClause.
			self visit: aPSQLASTDeleteQuery returningClause.
			scopeManager clear ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDistinctClause: aPSQLASTDistinctClause [
	(self childrenFor: aPSQLASTDistinctClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTExceptClause: aPSQLASTExceptClause [
	Halt now.
	(self childrenFor: aPSQLASTExceptClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTExceptionCase: aPSQLASTExceptionCase [
	self visit: aPSQLASTExceptionCase exception.
	self visitAll: aPSQLASTExceptionCase statements
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTExceptionHandler: aPSQLASTExceptionHandler [
	self visitAll: aPSQLASTExceptionHandler declarations.
	self visitAll: aPSQLASTExceptionHandler statements.
	self visitAll: aPSQLASTExceptionHandler exceptionCases
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTExtractFunctionCall: aPSQLASTExtractFunctionCall [
	^ self visit: aPSQLASTExtractFunctionCall parameter
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFetchClause: aPSQLASTFetchClause [
	(self childrenFor: aPSQLASTFetchClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTForClause: aPSQLASTForClause [
	(self childrenFor: aPSQLASTForClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClause: aPSQLASTFromClause [
	| fromScope |
	self
		useCurrentEntity: (self createClause: FmxSQLFromClause from: aPSQLASTFromClause)
		during: [ self visitAll: aPSQLASTFromClause items.
			fromScope := self solver topScope ].
	^ fromScope
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType1: aPSQLASTFromClauseItemType1 [
	| table |
	table := self findTableOrViewNamed: (self visit: aPSQLASTFromClauseItemType1 tableName).
	self visit: aPSQLASTFromClauseItemType1 alias thenDo: [ :alias | self defineAliasInCurrentScope: alias for: table ].
	self visitAll: aPSQLASTFromClauseItemType1 columnAliases thenDoForEach: [ :columnAlias | Halt now	"Alias not managed now" ].
	^ (self createEntity: FmxSQLTableReference from: aPSQLASTFromClauseItemType1)
		table: table;
		clause: self currentEntity;
		yourself
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType2: aPSQLASTFromClauseItemType2 [
	self
		defineAliasInCurrentScope: (self visit: aPSQLASTFromClauseItemType2 alias)
		for: (self visit: aPSQLASTFromClauseItemType2 valuesOrSelect).
	self visitAll: aPSQLASTFromClauseItemType2 columnAliases thenDoForEach: [ :each | Halt now ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType3: aPSQLASTFromClauseItemType3 [
	(self childrenFor: aPSQLASTFromClauseItemType3) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType4: aPSQLASTFromClauseItemType4 [
	(self childrenFor: aPSQLASTFromClauseItemType4) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType5: aPSQLASTFromClauseItemType5 [
	(self childrenFor: aPSQLASTFromClauseItemType5) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType6: aPSQLASTFromClauseItemType6 [
	self visit: aPSQLASTFromClauseItemType6 leftFromItem.
	self visit: aPSQLASTFromClauseItemType6 rightFromItem.
	self visit: aPSQLASTFromClauseItemType6 joinCondition.
	self visit: aPSQLASTFromClauseItemType6 usingList
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType7: aPSQLASTFromClauseItemType7 [
	(self childrenFor: aPSQLASTFromClauseItemType7) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFunctionCall: aPSQLASTFunctionCall [
	(self childrenFor: aPSQLASTFunctionCall) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTGroupByClause: aPSQLASTGroupByClause [
	self
		useCurrentEntity: (self createClause: FmxSQLGroupByClause from: aPSQLASTGroupByClause)
		during: [ self visitAll: aPSQLASTGroupByClause expressions ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTHavingClause: aPSQLASTHavingClause [
	(self childrenFor: aPSQLASTHavingClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTIdentifier: aPSQLASTIdentifier [
	| identifier |
	identifier := aPSQLASTIdentifier identifier.
	^ (identifier first = $" and: identifier last = $")
		ifTrue: [ identifier withoutQuoting ]
		ifFalse: [ identifier asLowercase ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTInsertQuery: aPSQLASTInsertQuery [
	| insertQuery |
	insertQuery := self createQueryContainedByCurrentEntity: FmxSQLInsertQuery from: aPSQLASTInsertQuery.
	^ self
		useCurrentEntity: insertQuery
		during: [ self
				useCurrentEntity: (self createClause: FmxSQLIntoClause from: aPSQLASTInsertQuery tableName)
				during: [ self
						visit: aPSQLASTInsertQuery tableName
						thenDo: [ :visitResult | self createReferenceTo: (self findTableOrViewNamed: visitResult) ].
					"The into clause add the table scope but only for the columns visit"
					self visitAll: aPSQLASTInsertQuery columns ].
			self visit: aPSQLASTInsertQuery withClause thenDo: [ :visitResult | Halt now ].
			self visit: aPSQLASTInsertQuery returningClause thenDo: [ :visitResult | Halt now ].
			self visit: aPSQLASTInsertQuery onConflictClause thenDo: [ :visitResult | Halt now ].
			self visit: aPSQLASTInsertQuery valuesClause.
			self visit: aPSQLASTInsertQuery alias thenDo: [ :visitResult | Halt now ] ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTIntersectClause: aPSQLASTIntersectClause [
	Halt now.
	(self childrenFor: aPSQLASTIntersectClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTIntoClause: aPSQLASTIntoClause [
	(self childrenFor: aPSQLASTIntoClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTLimitClause: aPSQLASTLimitClause [
	self
		useCurrentEntity: (self createClause: FmxSQLLimitClause from: aPSQLASTLimitClause)
		during: [ self visit: aPSQLASTLimitClause limit ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTNumericConstant: aPSQLASTNumericConstant [
	(aPSQLASTNumericConstant content asNumber )
	"Do nothing, we ignore the content of the constant, just check that it is a number"
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOffsetClause: aPSQLASTOffsetClause [
	(self childrenFor: aPSQLASTOffsetClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOnConflictClause: aPSQLASTOnConflictClause [
	(self childrenFor: aPSQLASTOnConflictClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOrderByClause: aPSQLASTOrderByClause [
	self
		useCurrentEntity: (self createClause: FmxSQLOrderByClause from: aPSQLASTOrderByClause)
		during: [ self visitAll: aPSQLASTOrderByClause items ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOrderByClauseItem: aPSQLASTOrderByClauseItem [
	(self childrenFor: aPSQLASTOrderByClauseItem) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTParenthesedExpression: aPSQLASTParenthesedExpression [
	^ self visit: aPSQLASTParenthesedExpression expression
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTPostfixOperator: aPSQLASTPostfixOperator [
	(self childrenFor: aPSQLASTPostfixOperator) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTPrefixOperator: aPSQLASTPrefixOperator [
	(self childrenFor: aPSQLASTPrefixOperator) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTReturningClause: aPSQLASTReturningClause [
	(self childrenFor: aPSQLASTReturningClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSelectIntoQuery: aPSQLASTSelectIntoQuery [
	(self childrenFor: aPSQLASTSelectIntoQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSelectQuery: aPSQLASTSelectQuery [
	| selectQuery scopeManager selectClauseScope |
	scopeManager := self solver createScopeManager.
	selectQuery := self createQueryContainedByCurrentEntity: FmxSQLSelectQuery from: aPSQLASTSelectQuery.
	"first we look at the from clause to resolve references"
	self
		useCurrentEntity: selectQuery
		during: [ self
				visit: aPSQLASTSelectQuery fromClause
				thenDo: [ :fromScope | 
					"I have to precise that the from clause scope is not the current entity anymore"
					fromScope isCurrentEntity: false.
					scopeManager pushScope: fromScope ].
			self visit: aPSQLASTSelectQuery withClause thenDo: [ :visitResult | Halt now ].
			self visit: aPSQLASTSelectQuery allOrDistinctClause thenDo: [ :visitResult | Halt now ].
			self
				useCurrentEntity:
					((self createEntity: FmxSQLSelectClause)
						query: selectQuery;
						yourself)
				during: [ selectClauseScope := self solver topScope.
					self visitAll: aPSQLASTSelectQuery columnsAndAliasesSelected.
					selectClauseScope isCurrentEntity: false.
					scopeManager pushScope: selectClauseScope ].
			self visit: aPSQLASTSelectQuery whereClause.
			self visit: aPSQLASTSelectQuery groupByClause.
			self visit: aPSQLASTSelectQuery havingClause thenDo: [ :visitResult | Halt now ].
			self visit: aPSQLASTSelectQuery windowClause thenDo: [ :visitResult | Halt now ].
			self visit: aPSQLASTSelectQuery unionIntersectExceptClause.
			self visit: aPSQLASTSelectQuery orderByClause.
			self visit: aPSQLASTSelectQuery limitClause.
			self visit: aPSQLASTSelectQuery offsetClause thenDo: [ :visitResult | Halt now ].
			self visit: aPSQLASTSelectQuery fetchClause thenDo: [ :visitResult | Halt now ].
			self visit: aPSQLASTSelectQuery forClause thenDo: [ :visitResult | Halt now ].
			scopeManager clear ].
	"Here we return the select clause scope to be used if it is in a using clause"
	^ selectClauseScope
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSelectWhereClause: aPSQLASTSelectWhereClause [
	| whereClause |
	whereClause := self createEntity: FmxSQLWhereClause from: aPSQLASTSelectWhereClause.
	whereClause query: self currentEntity.
	self
		useCurrentEntity: whereClause
		during: [ self visit: aPSQLASTSelectWhereClause condition ].
	^ whereClause
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSetClause: aPSQLASTSetClause [
	(self childrenFor: aPSQLASTSetClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSetClauseItemType1: aPSQLASTSetClauseItemType1 [
	(self childrenFor: aPSQLASTSetClauseItemType1) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSetClauseItemType2: aPSQLASTSetClauseItemType2 [
	(self childrenFor: aPSQLASTSetClauseItemType2) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSetClauseItemType3: aPSQLASTSetClauseItemType3 [
	(self childrenFor: aPSQLASTSetClauseItemType3) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTStringConstant: aPSQLASTStringConstant [
	"Ignoring constants for now".
	^ aPSQLASTStringConstant 
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSubscript: aPSQLASTSubscript [
	self visit: aPSQLASTSubscript target.
	self visit: aPSQLASTSubscript subscriptExpression
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTTableAlias: aPSQLASTTableAlias [
	(self childrenFor: aPSQLASTTableAlias) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUnionClause: aPSQLASTUnionClause [
	self
		useCurrentEntity: (self createClause: FmxSQLUnionClause from: aPSQLASTUnionClause)
		during: [ self visit: aPSQLASTUnionClause selectQuery ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUpdateDeleteWhereClause: aPSQLASTUpdateDeleteWhereClause [
	| whereClause |
	whereClause := self createClause: FmxSQLWhereClause from: aPSQLASTUpdateDeleteWhereClause.
	self
		useCurrentEntity: whereClause
		during: [ self visit: aPSQLASTUpdateDeleteWhereClause condition.
			self visit: aPSQLASTUpdateDeleteWhereClause currentOfCursor ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUpdateQuery: aPSQLASTUpdateQuery [
	| scopeManager |
	scopeManager := self solver createScopeManager.
	self
		useCurrentEntity: (self createQueryContainedByCurrentEntity: FmxSQLUpdateQuery from: aPSQLASTUpdateQuery)
		during: [ self
				visit: aPSQLASTUpdateQuery fromClause
				thenDo: [ :fromScope | 
					"I have to precise that the from clause scope is not the current entity anymore"
					fromScope isCurrentEntity: false.
					scopeManager pushScope: fromScope ].
			self
				visit: aPSQLASTUpdateQuery tableName
				thenDo: [ :tableName | self currentEntity table: (self findTableOrViewNamed: tableName) ].
			self visit: aPSQLASTUpdateQuery setClause.
			self visit: aPSQLASTUpdateQuery whereClause.
			self visit: aPSQLASTUpdateQuery returningClause.
			#(#alias #areDescendantTablesIncluded #hasOnly).
			self flag: #TODO.	"manage thing in this table"
			scopeManager clear ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUsingClause: aPSQLASTUsingClause [
	| usingScope |
	self
		useCurrentEntity: (self createClause: FmxSQLUsingClause from: aPSQLASTUsingClause)
		during: [ usingScope := self solver topScope.
			self visitAll: aPSQLASTUsingClause list ].
	^ usingScope
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTValuesClause: aPSQLASTValuesClause [
	self
		useCurrentEntity: (self createClause: FmxSQLValuesClause from: aPSQLASTValuesClause)
		during: [ self visit: aPSQLASTValuesClause values ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTValuesCommand: aPSQLASTValuesCommand [
	self visitAll: aPSQLASTValuesCommand values
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTWhenExpression: aPSQLASTWhenExpression [ 
	^ self visit: aPSQLASTWhenExpression expression
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTWildCard: aPSQLASTWildCard [
	"Here we will create a reference on each accessible entities at the current scope"

	self topScopeReachableEntities
		do: [ :aReachableEntity | (aReachableEntity createReferenceEntityFrom: self currentEntity) mooseModel: self model ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTWithClause: aPSQLASTWithClause [
	(self childrenFor: aPSQLASTWithClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTAliasDeclaration: aPSQLPlpgSQLASTAliasDeclaration [
	(self childrenFor: aPSQLPlpgSQLASTAliasDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTArrayLoop: aPSQLPlpgSQLASTArrayLoop [
	(self childrenFor: aPSQLPlpgSQLASTArrayLoop) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTAssignment: aPSQLPlpgSQLASTAssignment [
	self visit: aPSQLPlpgSQLASTAssignment toAssign.
	self flag: #TODO.	"aPSQLPlpgSQLASTAssignment target can be an expression of any kind. The problem is when the expression is only an Identifier because it is not yet referenced."
	self
		visit: aPSQLPlpgSQLASTAssignment target
		thenDo: [ :res | 
			res isString
				ifTrue: [ self resolveAndLinkSilently: (PSQIdentifierWithNode identifier: res node: aPSQLPlpgSQLASTAssignment target) ] ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTBlock: aPSQLPlpgSQLASTBlock [
	self visit: aPSQLPlpgSQLASTBlock label thenDo: [ :res | Halt now ].
	self visitAll: aPSQLPlpgSQLASTBlock declarations.
	self visitAll: aPSQLPlpgSQLASTBlock statements
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTBlockLabel: aPSQLPlpgSQLASTBlockLabel [
	(self childrenFor: aPSQLPlpgSQLASTBlockLabel) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTClassicDeclaration: aPSQLPlpgSQLASTClassicDeclaration [
	| variable |
	variable := self createEntity: FmxSQLLocalVariable from: aPSQLPlpgSQLASTClassicDeclaration.
	variable storedProcedure: self function.
	self visit: aPSQLPlpgSQLASTClassicDeclaration defaultExpression thenDo: [ :e | Halt now ].
	self
		visit: aPSQLPlpgSQLASTClassicDeclaration identifier
		thenDo: [ :name | variable name: name ].
	self visit: aPSQLPlpgSQLASTClassicDeclaration type thenDo: [ :type | variable type: type ].
	^ variable
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTContinue: aPSQLPlpgSQLASTContinue [
	(self childrenFor: aPSQLPlpgSQLASTContinue) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCopyTypeDeclaration: aPSQLPlpgSQLASTCopyTypeDeclaration [
	| variable |
	variable := self createEntity: FmxSQLLocalVariable from: aPSQLPlpgSQLASTCopyTypeDeclaration identifier.
	variable storedProcedure: self function.
	self visit: aPSQLPlpgSQLASTCopyTypeDeclaration accessToCopyType thenDo: [ :accessed | variable type: accessed type ].
	self visit: aPSQLPlpgSQLASTCopyTypeDeclaration identifier thenDo: [ :name | variable name: name ].
	^ variable
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorClose: aPSQLPlpgSQLASTCursorClose [
	(self childrenFor: aPSQLPlpgSQLASTCursorClose) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorDeclaration: aPSQLPlpgSQLASTCursorDeclaration [
	| localVariable cursor |
	localVariable := self createEntity: FmxSQLLocalVariable.
	self
		visit: aPSQLPlpgSQLASTCursorDeclaration identifier
		thenDo: [ :variableName | localVariable name: variableName ].
	localVariable type: (self findTypeNamed: 'refcursor').
	localVariable storedProcedure: self currentEntity.
	cursor := self createEntity: FmxSQLCursor from: aPSQLPlpgSQLASTCursorDeclaration.
	self createReferenceTo: cursor.
	self
		useCurrentEntity: cursor
		during: [ self
				visitAll: aPSQLPlpgSQLASTCursorDeclaration arguments.
			self visit: aPSQLPlpgSQLASTCursorDeclaration selectQuery ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorDelete: aPSQLPlpgSQLASTCursorDelete [
	(self childrenFor: aPSQLPlpgSQLASTCursorDelete) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorFetch: aPSQLPlpgSQLASTCursorFetch [
	self visit: aPSQLPlpgSQLASTCursorFetch cursorIdentifier.
	self visitAll: aPSQLPlpgSQLASTCursorFetch targets
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorFetchDirection: aPSQLPlpgSQLASTCursorFetchDirection [
	(self childrenFor: aPSQLPlpgSQLASTCursorFetchDirection) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorMove: aPSQLPlpgSQLASTCursorMove [
	(self childrenFor: aPSQLPlpgSQLASTCursorMove) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorMoveDirection: aPSQLPlpgSQLASTCursorMoveDirection [
	(self childrenFor: aPSQLPlpgSQLASTCursorMoveDirection) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorOpen: aPSQLPlpgSQLASTCursorOpen [
	self visit: aPSQLPlpgSQLASTCursorOpen cursorIdentifier.
	self visitAll: aPSQLPlpgSQLASTCursorOpen arguments
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorOpenForQuery: aPSQLPlpgSQLASTCursorOpenForQuery [
	| cursor |
	self
		visit: aPSQLPlpgSQLASTCursorOpenForQuery cursorIdentifier
		thenDo: [ :cursVar | 
			self
				resolveAndLinkSilently:
					(PSQIdentifierWithNode
						identifier: cursVar
						node: aPSQLPlpgSQLASTCursorOpenForQuery cursorIdentifier) ].
	cursor := self createEntity: FmxSQLCursor from: aPSQLPlpgSQLASTCursorOpenForQuery.
	self createReferenceTo: cursor.
	self
		useCurrentEntity: cursor
		during: [ self visit: aPSQLPlpgSQLASTCursorOpenForQuery selectQuery ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorStatement: aPSQLPlpgSQLASTCursorStatement [
	(self childrenFor: aPSQLPlpgSQLASTCursorStatement) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTForLoop: aPSQLPlpgSQLASTForLoop [
	(self childrenFor: aPSQLPlpgSQLASTForLoop) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTIf: aPSQLPlpgSQLASTIf [
	(self childrenFor: aPSQLPlpgSQLASTIf) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTLoop: aPSQLPlpgSQLASTLoop [
	self visitAll: aPSQLPlpgSQLASTLoop statements
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTPerform: aPSQLPlpgSQLASTPerform [ 
	self flag: #TODO.
	"Ignored for now"
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTPositionalParameter: aPSQLPlpgSQLASTPositionalParameter [
	(self childrenFor: aPSQLPlpgSQLASTPositionalParameter) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTQueryResultsLoop: aPSQLPlpgSQLASTQueryResultsLoop [
	(self childrenFor: aPSQLPlpgSQLASTQueryResultsLoop) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTRaiseStatement: aPSQLPlpgSQLASTRaiseStatement [
	(self childrenFor: aPSQLPlpgSQLASTRaiseStatement) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTRecordDeclaration: aPSQLPlpgSQLASTRecordDeclaration [
	(self childrenFor: aPSQLPlpgSQLASTRecordDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTReturnStatement: aPSQLPlpgSQLASTReturnStatement [
	(self childrenFor: aPSQLPlpgSQLASTReturnStatement) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTRowTypeDeclaration: aPSQLPlpgSQLASTRowTypeDeclaration [
	^ FmxSQLLocalVariable new
		name: (aPSQLPlpgSQLASTRowTypeDeclaration identifier acceptVisitor: self);
		type: (self findTableOrViewNamed: (aPSQLPlpgSQLASTRowTypeDeclaration tableIdentifier acceptVisitor: self));
		storedProcedure: function;
		mooseModel: model;
		yourself
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTSearchedCase: aPSQLPlpgSQLASTSearchedCase [
	(self childrenFor: aPSQLPlpgSQLASTSearchedCase) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTSimpleCase: aPSQLPlpgSQLASTSimpleCase [
	(self childrenFor: aPSQLPlpgSQLASTSimpleCase) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTType: aPSQLPlpgSQLASTType [
	self flag: #TODO.	"consider size and dimensions"
	^ self visit: aPSQLPlpgSQLASTType identifier thenDo: [ :typeName | self findTypeNamed: typeName ]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTWhileLoop: aPSQLPlpgSQLASTWhileLoop [
	(self childrenFor: aPSQLPlpgSQLASTWhileLoop) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLCursorUpdate: aPSQLPlpgSQLCursorUpdate [
	(self childrenFor: aPSQLPlpgSQLCursorUpdate) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQPlpgSQLASTExit: aPSQLPlpgSQLASTExit [
	^ self visit: aPSQLPlpgSQLASTExit booleanExpression thenDo: [ :res |  ]
]
