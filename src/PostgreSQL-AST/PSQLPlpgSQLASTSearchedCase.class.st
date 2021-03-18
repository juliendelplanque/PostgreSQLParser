"
I am the node representing a searched case condition.
"
Class {
	#name : #PSQLPlpgSQLASTSearchedCase,
	#superclass : #PSQLPlpgSQLASTConditional,
	#instVars : [
		'searchedExpression'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTSearchedCase >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTSearchedCase: self
]

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> conditionToStatements [
	"self shouldNotImplement"
	self flag: #TODO.
	super conditionToStatements 
]

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> conditionToStatements: anObject [
	self shouldNotImplement
]

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> conditionsToStatements [
	^ super conditionToStatements
]

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> conditionsToStatements: anObject [
	super conditionToStatements: anObject
]

{ #category : #testing }
PSQLPlpgSQLASTSearchedCase >> isSearchedCase [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> searchedExpression [
	^ searchedExpression
]

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> searchedExpression: anObject [
	searchedExpression := anObject
]
