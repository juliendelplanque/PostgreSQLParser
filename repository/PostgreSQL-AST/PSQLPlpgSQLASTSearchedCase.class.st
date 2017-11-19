"
I am the node representing a searched case condition.
"
Class {
	#name : #PSQLPlpgSQLASTSearchedCase,
	#superclass : #PSQLPlpgSQLASTConditional,
	#instVars : [
		'searchedExpression'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> conditionToStatements [
	self shouldNotImplement
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

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> searchedExpression [
	^ searchedExpression
]

{ #category : #accessing }
PSQLPlpgSQLASTSearchedCase >> searchedExpression: anObject [
	searchedExpression := anObject
]
