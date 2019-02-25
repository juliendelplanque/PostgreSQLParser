"
I am a RETURNING clause node.
"
Class {
	#name : #PSQLASTReturningClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'returnedList'
	],
	#category : #'PostgreSQL-AST-SQL'
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
