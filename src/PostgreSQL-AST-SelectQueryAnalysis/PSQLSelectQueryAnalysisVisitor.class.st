Class {
	#name : #PSQLSelectQueryAnalysisVisitor,
	#superclass : #PSQLASTVisitor,
	#instVars : [
		'conditions'
	],
	#category : #'PostgreSQL-AST-SelectQueryAnalysis'
}

{ #category : #accessing }
PSQLSelectQueryAnalysisVisitor >> conditions [
	^ conditions
]

{ #category : #initialization }
PSQLSelectQueryAnalysisVisitor >> initialize [
	super initialize.
	conditions := OrderedCollection new
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTAggregateFunctionCall: aPSQLASTAggregateFunctionCall [ 
	^ aPSQLASTAggregateFunctionCall expressions collect: [ :exp |
		exp acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTAttributeAccess: aPSQLASTAttributeAccess [ 
	self flag: #TODO. "Not sure if nothing needs to be done yet."
	^ aPSQLASTAttributeAccess
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTBinaryOperator: aPSQLASTBinaryOperator [
	self flag: #TODO. "Naive approach."
	(aPSQLASTBinaryOperator operator = '='
		and: [ aPSQLASTBinaryOperator left isConstant
					or: [ aPSQLASTBinaryOperator right isConstant ] ])
		ifTrue: [ conditions add: aPSQLASTBinaryOperator ].
		
	aPSQLASTBinaryOperator left acceptVisitor: self.
	
	aPSQLASTBinaryOperator right acceptVisitor: self.
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
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTSelectQuery: aPSQLASTSelectQuery [
	^ aPSQLASTSelectQuery whereClause ifNotNil: [ :whereClause | whereClause acceptVisitor: self ]
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTSelectWhereClause: aPSQLASTSelectWhereClause [ 
	^ aPSQLASTSelectWhereClause condition acceptVisitor: self
]

{ #category : #visiting }
PSQLSelectQueryAnalysisVisitor >> visitPSQLASTStringConstant: aPSQLASTStringConstant [ 
	^ aPSQLASTStringConstant
]
