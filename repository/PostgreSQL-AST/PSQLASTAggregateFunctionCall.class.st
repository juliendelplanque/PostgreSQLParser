"
I am an aggregate function call in an expression.
"
Class {
	#name : #PSQLASTAggregateFunctionCall,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'functionIdentifier',
		'isAll',
		'isDistinct',
		'expressions',
		'orderByClause'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTAggregateFunctionCall >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTAggregateFunctionCall: self
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> expressions [
	^ expressions
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> expressions: anObject [
	expressions := anObject
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> functionIdentifier [
	^ functionIdentifier
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> functionIdentifier: anObject [
	functionIdentifier := anObject
]

{ #category : #testing }
PSQLASTAggregateFunctionCall >> hasOrderByClause [
	^ self orderByClause isNotNil
]

{ #category : #initialization }
PSQLASTAggregateFunctionCall >> initialize [
	super initialize.
	self
		isAll: false;
		isDistinct: false
]

{ #category : #printing }
PSQLASTAggregateFunctionCall >> innerPrintOn: aStream [
	aStream << self functionIdentifier identifier
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> isAll [
	^ isAll
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> isAll: anObject [
	isAll := anObject
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> isDistinct [
	^ isDistinct
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> isDistinct: anObject [
	isDistinct := anObject
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> orderByClause [
	^ orderByClause
]

{ #category : #accessing }
PSQLASTAggregateFunctionCall >> orderByClause: anObject [
	orderByClause := anObject
]
