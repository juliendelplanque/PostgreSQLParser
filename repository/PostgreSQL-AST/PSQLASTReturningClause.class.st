"
I am a RETURNING clause node.
"
Class {
	#name : #PSQLASTReturningClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'returnedList'
	],
	#category : #PostgreSQL-AST-Nodes
}

{ #category : #accessing }
PSQLASTReturningClause >> returnedList [
	^ returnedList
]

{ #category : #accessing }
PSQLASTReturningClause >> returnedList: anObject [
	returnedList := anObject
]
