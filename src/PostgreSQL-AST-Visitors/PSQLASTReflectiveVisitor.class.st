Class {
	#name : #PSQLASTReflectiveVisitor,
	#superclass : #PSQLASTVisitor,
	#instVars : [
		'model',
		'function',
		'solver'
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
	solver pushScope: function
]

{ #category : #'convenient linking' }
PSQLASTReflectiveVisitor >> linkReferencedEntities: aPSQIdentifierWithNode [
	self flag: #TODO.	"add position in source"
	(aPSQIdentifierWithNode entity createReferenceEntityTo: self function) mooseModel: self model.
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
	solver := PSQLReferenciesSolver
		defaultScopeEntities: (model allWithType: FmxSQLTable) , (model allWithType: FmxSQLView)
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> solver [
	^ solver
]

{ #category : #'visiting - convenience' }
PSQLASTReflectiveVisitor >> visit: aNode [ 
	^ aNode acceptVisitor: self
]

{ #category : #'visit convenient' }
PSQLASTReflectiveVisitor >> visit: nilOrNode thenDo: aBlockClosure [
	^ nilOrNode ifNotNil: [ aBlockClosure value: (nilOrNode acceptVisitor: self) ]
]

{ #category : #'visiting convenience' }
PSQLASTReflectiveVisitor >> visitAll: aCollection thenDoForEach: aBlockClosure [
	aCollection ifNotNil: [ aCollection do: [ :aNode | self visit: aNode thenDo: aBlockClosure ] ]
]

{ #category : #'visiting convenient' }
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
PSQLASTReflectiveVisitor >> visitPSQLASTAllClause: aPSQLASTAllClause [
	(self childrenFor: aPSQLASTAllClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAlternativeSelectIntoQuery: aPSQLASTAlternativeSelectIntoQuery [
	(self childrenFor: aPSQLASTAlternativeSelectIntoQuery) do: [:aChild | aChild acceptVisitor: self]
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
		thenDo: [ :identifier | 
			identifiers := PSQIdentifierWithNode
				identifier: identifier
				node: aPSQLASTAttributeAccess attributeIdentifier
				next: identifiers ].
	self
		visit: aPSQLASTAttributeAccess accessed
		thenDo: [ :identifier | 
			identifiers := PSQIdentifierWithNode
				identifier: identifier
				node: aPSQLASTAttributeAccess accessed
				next: identifiers ].
	solver resolve: identifiers.
	self linkReferencedEntities: identifiers.
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
PSQLASTReflectiveVisitor >> visitPSQLASTDefaultValue: aPSQLASTDefaultValue [
	(self childrenFor: aPSQLASTDefaultValue) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDefaultValues: aPSQLASTDefaultValues [
	(self childrenFor: aPSQLASTDefaultValues) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDeleteQuery: aPSQLASTDeleteQuery [
	(self childrenFor: aPSQLASTDeleteQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDistinctClause: aPSQLASTDistinctClause [
	(self childrenFor: aPSQLASTDistinctClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTExceptClause: aPSQLASTExceptClause [
	(self childrenFor: aPSQLASTExceptClause) do: [:aChild | aChild acceptVisitor: self]
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
	| fromClause |
	fromClause := self createEntity: FmxSQLFromClause from: aPSQLASTFromClause.
	self visitAll: aPSQLASTFromClause items thenDoForEach: [ :ref | ref clause: fromClause ].
	^ fromClause
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType1: aPSQLASTFromClauseItemType1 [
	| table |
	table := self findTableOrViewNamed: (self visit: aPSQLASTFromClauseItemType1 tableName).
	self
		visit: aPSQLASTFromClauseItemType1 alias
		thenDo: [ :alias | Halt now	"Alias not managed now" ].
	self
		visit: aPSQLASTFromClauseItemType1 columnAliases
		thenDo: [ :columnAlias | Halt now	"Alias not managed now" ].
	^ (self createEntity: FmxSQLTableReference from: aPSQLASTFromClauseItemType1)
		table: table;
		yourself
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType2: aPSQLASTFromClauseItemType2 [
	(self childrenFor: aPSQLASTFromClauseItemType2) do: [:aChild | aChild acceptVisitor: self]
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
	(self childrenFor: aPSQLASTFromClauseItemType6) do: [:aChild | aChild acceptVisitor: self]
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
	(self childrenFor: aPSQLASTGroupByClause) do: [:aChild | aChild acceptVisitor: self]
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
	insertQuery := self createEntity: FmxSQLInsertQuery from: aPSQLASTInsertQuery.
	self visit: aPSQLASTInsertQuery withClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTInsertQuery returningClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTInsertQuery onConflictClause thenDo: [ :visitResult | Halt now ].
	self
		visit: aPSQLASTInsertQuery valuesClause
		thenDo: [ :fmxValuesClause | Halt now. fmxValuesClause resolveAsPartOfTheQuery: insertQuery ].
	self visit: aPSQLASTInsertQuery tableName thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTInsertQuery alias thenDo: [ :visitResult | Halt now ].
	self visitAll: aPSQLASTInsertQuery columns thenDoForEach: [ :visitResult | Halt now ].
	^ insertQuery
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTIntersectClause: aPSQLASTIntersectClause [
	(self childrenFor: aPSQLASTIntersectClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTIntoClause: aPSQLASTIntoClause [
	(self childrenFor: aPSQLASTIntoClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTLimitClause: aPSQLASTLimitClause [
	(self childrenFor: aPSQLASTLimitClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTNumericConstant: aPSQLASTNumericConstant [
	(self childrenFor: aPSQLASTNumericConstant) do: [:aChild | aChild acceptVisitor: self]
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
	(self childrenFor: aPSQLASTOrderByClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOrderByClauseItem: aPSQLASTOrderByClauseItem [
	(self childrenFor: aPSQLASTOrderByClauseItem) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTParenthesedExpression: aPSQLASTParenthesedExpression [
	(self childrenFor: aPSQLASTParenthesedExpression) do: [:aChild | aChild acceptVisitor: self]
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
	| selectQuery |
	selectQuery := self createEntity: FmxSQLSelectQuery from: aPSQLASTSelectQuery.
	"first we look at the from clause to resolve references"
	self visit: aPSQLASTSelectQuery fromClause thenDo: [ :fromClause | fromClause query: selectQuery ].
	self visit: aPSQLASTSelectQuery withClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery allOrDistinctClause thenDo: [ :visitResult | Halt now ].
	self visitAll: aPSQLASTSelectQuery columnsAndAliasesSelected thenDoForEach: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery whereClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery groupByClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery havingClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery windowClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery unionIntersectExceptClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery orderByClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery limitClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery offsetClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery fetchClause thenDo: [ :visitResult | Halt now ].
	self visit: aPSQLASTSelectQuery forClause thenDo: [ :visitResult | Halt now ].
	selectQuery mooseModel: model.
	^ selectQuery
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSelectWhereClause: aPSQLASTSelectWhereClause [
	(self childrenFor: aPSQLASTSelectWhereClause) do: [:aChild | aChild acceptVisitor: self]
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
	(self childrenFor: aPSQLASTSubscript) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTTableAlias: aPSQLASTTableAlias [
	(self childrenFor: aPSQLASTTableAlias) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUnionClause: aPSQLASTUnionClause [
	(self childrenFor: aPSQLASTUnionClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUpdateDeleteWhereClause: aPSQLASTUpdateDeleteWhereClause [
	(self childrenFor: aPSQLASTUpdateDeleteWhereClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUpdateQuery: aPSQLASTUpdateQuery [
	(self childrenFor: aPSQLASTUpdateQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTValuesClause: aPSQLASTValuesClause [
	| valuesClause |
	valuesClause := self createEntity: FmxSQLValuesClause from: aPSQLASTValuesClause.
	self visit: aPSQLASTValuesClause values thenDo: [ :res | Halt now ].
	^ valuesClause
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTWhenExpression: aPSQLASTWhenExpression [ 
	^ self visit: aPSQLASTWhenExpression expression
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTWildCard: aPSQLASTWildCard [
	(self childrenFor: aPSQLASTWildCard) do: [:aChild | aChild acceptVisitor: self]
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
	(self childrenFor: aPSQLPlpgSQLASTAssignment) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTBlock: aPSQLPlpgSQLASTBlock [
	self visit: aPSQLPlpgSQLASTBlock label thenDo: [ :res | Halt now ].
	self
		visitAll: aPSQLPlpgSQLASTBlock declarations
		thenDoForEach: [ :res | "nothing to do" ].
	self
		visitAll: aPSQLPlpgSQLASTBlock statements
		thenDoForEach: [ :res | "nothing to do" ]
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
	(self childrenFor: aPSQLPlpgSQLASTCursorDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorDelete: aPSQLPlpgSQLASTCursorDelete [
	(self childrenFor: aPSQLPlpgSQLASTCursorDelete) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorFetch: aPSQLPlpgSQLASTCursorFetch [
	(self childrenFor: aPSQLPlpgSQLASTCursorFetch) do: [:aChild | aChild acceptVisitor: self]
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
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorOpenForQuery: aPSQLPlpgSQLASTCursorOpenForQuery [
	(self childrenFor: aPSQLPlpgSQLASTCursorOpenForQuery) do: [:aChild | aChild acceptVisitor: self]
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
	(self childrenFor: aPSQLPlpgSQLASTLoop) do: [:aChild | aChild acceptVisitor: self]
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
