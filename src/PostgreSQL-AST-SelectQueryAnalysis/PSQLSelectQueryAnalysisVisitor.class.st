Class {
	#name : #PSQLSelectQueryAnalysisVisitor,
	#superclass : #PSQLASTVisitor,
	#instVars : [
		'conditions',
		'isInWhereClause'
	],
	#category : #'PostgreSQL-AST-SelectQueryAnalysis'
}

{ #category : #accessing }
PSQLSelectQueryAnalysisVisitor >> conditions [
	^ conditions
]

{ #category : #context }
PSQLSelectQueryAnalysisVisitor >> enterWhereClause [
	self isInWhereClause: true
]

{ #category : #initialization }
PSQLSelectQueryAnalysisVisitor >> initialize [
	super initialize.
	conditions := OrderedCollection new.
	self isInWhereClause: false
]

{ #category : #accessing }
PSQLSelectQueryAnalysisVisitor >> isInWhereClause [
	^ isInWhereClause
]

{ #category : #accessing }
PSQLSelectQueryAnalysisVisitor >> isInWhereClause: anObject [
	isInWhereClause := anObject
]

{ #category : #context }
PSQLSelectQueryAnalysisVisitor >> leaveWhereClause [
	self isInWhereClause: false
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQASTNull: aPSQLASTNull [ 
	^ aPSQLASTNull
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTAggregateFunctionCall: aPSQLASTAggregateFunctionCall [ 
	^ aPSQLASTAggregateFunctionCall expressions collect: [ :exp |
		exp acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTAlternativeSelectIntoQuery: aPSQLASTAlternativeSelectIntoQuery [ 
	self flag: #TODO. "Maybe to enhance?"
	self enterWhereClause.
	aPSQLASTAlternativeSelectIntoQuery whereClause ifNotNil: [ :whereClause | whereClause acceptVisitor: self ].
	self leaveWhereClause
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTAttributeAccess: aPSQLASTAttributeAccess [ 
	self flag: #TODO. "Not sure if nothing needs to be done yet."
	^ aPSQLASTAttributeAccess
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTBinaryOperator: aPSQLASTBinaryOperator [
	self flag: #TODO. "Naive approach."
	(self isInWhereClause and: [ aPSQLASTBinaryOperator operator = '='
		and: [ aPSQLASTBinaryOperator left isConstant
					or: [ aPSQLASTBinaryOperator right isConstant ] ] ])
		ifTrue: [ conditions add: aPSQLASTBinaryOperator ].
		
	(aPSQLASTBinaryOperator left isArray or: [ aPSQLASTBinaryOperator right isArray ])
		ifTrue: [ Warning signal: 'Array!'. ^ self ].
	aPSQLASTBinaryOperator left acceptVisitor: self.
	
	aPSQLASTBinaryOperator right acceptVisitor: self.
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTCompositeValue: aPSQLASTCompositeValue [ 
	aPSQLASTCompositeValue items do: [ :i |
		i acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTConditionalExpression: aPSQLASTConditionalExpression [ 
	aPSQLASTConditionalExpression conditionsToExpressions do: [ :assoc |
		assoc key acceptVisitor: self.
		assoc value acceptVisitor: self ].
	
	aPSQLASTConditionalExpression elseExpression ifNotNil: [ :e | e acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTDeleteQuery: aPSQLASTDeleteQuery [ 
	self flag: #TODO. "Maybe to enhance?"
	^ aPSQLASTDeleteQuery whereClause acceptVisitor: self
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTExceptionCase: aPSQLASTExceptionCase [ 
	aPSQLASTExceptionCase exception acceptVisitor: self.
	
	aPSQLASTExceptionCase statements do: [ :s |
		s acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTExceptionHandler: aPSQLASTExceptionHandler [ 
	aPSQLASTExceptionHandler declarations ifNotNil: [ :declarations |
		declarations do: [ :d | d acceptVisitor: self ] ].
	
	aPSQLASTExceptionHandler exceptionCases do: [ :c |
		c acceptVisitor: self ].
	
	aPSQLASTExceptionHandler statements do: [ :s |
		s acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTExtractFunctionCall: aPSQLASTExtractFunctionCall [ 
	^ aPSQLASTExtractFunctionCall
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTFunctionCall: aPSQLASTFunctionCall [ 
	^ aPSQLASTFunctionCall argumentsList collect: [ :arg |
		arg acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTIdentifier: aPSQLASTIdentifier [
	self flag: #TODO. "Not sure if nothing needs to be done yet."
	^ aPSQLASTIdentifier
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTInsertQuery: aPSQLASTInsertQuery [ 
	^ aPSQLASTInsertQuery
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTNumericConstant: aPSQLASTNumericConstant [ 
	^ aPSQLASTNumericConstant
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTParenthesedExpression: aPSQLASTParenthesedExpression [ 
	^ aPSQLASTParenthesedExpression expression acceptVisitor: self
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTPostfixOperator: aPSQLASTPostfixOperator [ 
	^ aPSQLASTPostfixOperator expression acceptVisitor: self
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTPrefixOperator: aPSQLASTPrefixOperator [ 
	^ aPSQLASTPrefixOperator expression acceptVisitor: self
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTSelectIntoQuery: aPSQLASTSelectIntoQuery [ 
	aPSQLASTSelectIntoQuery whereClause ifNotNil: [ :whereClause |
		whereClause acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTSelectQuery: aPSQLASTSelectQuery [
	^ aPSQLASTSelectQuery whereClause ifNotNil: [ :whereClause | whereClause acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTSelectWhereClause: aPSQLASTSelectWhereClause [ 
	self enterWhereClause.
	aPSQLASTSelectWhereClause condition acceptVisitor: self.
	self leaveWhereClause
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTStringConstant: aPSQLASTStringConstant [ 
	^ aPSQLASTStringConstant
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTSubscript: aPSQLASTSubscript [ 
	^ aPSQLASTSubscript
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTUpdateDeleteWhereClause: aPSQLASTUpdateDeleteWhereClause [ 
	self enterWhereClause.
	aPSQLASTUpdateDeleteWhereClause condition acceptVisitor: self.
	self leaveWhereClause
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTUpdateQuery: aPSQLASTUpdateQuery [ 
	self flag: #TODO. "Naive approach maybe to enhance?"
	^ aPSQLASTUpdateQuery whereClause ifNotNil: [ :whereClause | whereClause acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTWhenExpression: aPSQLASTWhenExpression [ 
	aPSQLASTWhenExpression expression acceptVisitor: self
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTAssignment: aPSQLPlpgSQLASTAssignment [ 
	^ aPSQLPlpgSQLASTAssignment toAssign acceptVisitor: self
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTBlock: aPSQLPlpgSQLASTBlock [ 
	aPSQLPlpgSQLASTBlock declarations ifNotNil: [ :decs |
		decs do: [ :d | d acceptVisitor: self ] ].
	
	aPSQLPlpgSQLASTBlock statements do: [ :d | d acceptVisitor: self ].
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTClassicDeclaration: aPSQLPlpgSQLASTClassicDeclaration [
	^ aPSQLPlpgSQLASTClassicDeclaration
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTCopyTypeDeclaration: aPSQLPlpgSQLASTCopyTypeDeclaration [ 
	^ aPSQLPlpgSQLASTCopyTypeDeclaration
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTCursorClose: aPSQLPlpgSQLASTCursorClose [ 
	^ aPSQLPlpgSQLASTCursorClose
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTCursorDeclaration: aPSQLPlpgSQLASTCursorDeclaration [ 
	aPSQLPlpgSQLASTCursorDeclaration selectQuery acceptVisitor: self
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTCursorFetch: aPSQLPlpgSQLASTCursorFetch [ 
	^ aPSQLPlpgSQLASTCursorFetch
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTCursorOpen: aPSQLPlpgSQLASTCursorOpen [ 
	^ aPSQLPlpgSQLASTCursorOpen
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTForLoop: aPSQLPlpgSQLASTForLoop [ 
	aPSQLPlpgSQLASTForLoop statements do: [ :s |
		s acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTIf: aPSQLPlpgSQLASTIf [ 
	aPSQLPlpgSQLASTIf conditionToStatements do: [ :assoc |
		assoc key acceptVisitor: self.
		assoc value do: [ :s | s acceptVisitor: self ] ].
	
	aPSQLPlpgSQLASTIf elseStatements ifNotNil: [ 
		aPSQLPlpgSQLASTIf elseStatements
			do: [ :s | s acceptVisitor: self ] ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTLoop: aPSQLPlpgSQLASTLoop [ 
	aPSQLPlpgSQLASTLoop statements do: [ :s |
		s acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTPerform: aPSQLPlpgSQLASTPerform [
	self flag: #TODO. "Check in case there is a WHERE clause?"
	^ aPSQLPlpgSQLASTPerform
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTQueryResultsLoop: aPSQLPlpgSQLASTQueryResultsLoop [ 
	aPSQLPlpgSQLASTQueryResultsLoop query acceptVisitor: self.
	
	aPSQLPlpgSQLASTQueryResultsLoop statements do: [ :s |
		s acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTRaiseStatement: aPSQLPlpgSQLASTRaiseStatement [ 
	^ aPSQLPlpgSQLASTRaiseStatement
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTReturnStatement: aPSQLPlpgSQLASTReturnStatement [ 
	aPSQLPlpgSQLASTReturnStatement query ifNotNil: [ :q |
		q acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTRowTypeDeclaration: aPSQLPlpgSQLASTRowTypeDeclaration [ 
	^ aPSQLPlpgSQLASTRowTypeDeclaration
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTSimpleCase: aPSQLPlpgSQLASTSimpleCase [ 
	aPSQLPlpgSQLASTSimpleCase conditionToStatements do: [ :assoc |
		assoc key acceptVisitor: self.
		assoc value do: [ :s | s acceptVisitor: self ] ].
	
	aPSQLPlpgSQLASTSimpleCase elseStatements ifNotNil: [ :statements |
		statements do: [ :s | s acceptVisitor: self ] ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLPlpgSQLASTWhileLoop: aPSQLPlpgSQLASTWhileLoop [
	aPSQLPlpgSQLASTWhileLoop condition acceptVisitor: self.
	
	aPSQLPlpgSQLASTWhileLoop statements do: [ :s |
		s acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQPlpgSQLASTExit: aPSQLPlpgSQLASTExit [ 
	^ aPSQLPlpgSQLASTExit
]
