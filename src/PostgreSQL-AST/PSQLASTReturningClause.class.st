"
I am a RETURNING clause node.
"
Class {
	#name : #PSQLASTReturningClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'returnedList'
	],
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #visiting }
PSQLASTReturningClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTReturningClause: self
]

{ #category : #testing }
PSQLASTReturningClause >> isReturningClause [
	^ true
]

{ #category : #accessing }
PSQLASTReturningClause >> returnedList [
	^ returnedList
]

{ #category : #accessing }
PSQLASTReturningClause >> returnedList: anObject [
	returnedList := anObject
]
