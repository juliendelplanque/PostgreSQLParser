"
I am a ORDER BY clause node from a SELECT query.
"
Class {
	#name : #PSQLASTOrderByClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'items'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTOrderByClause >> items [
	^ items
]

{ #category : #accessing }
PSQLASTOrderByClause >> items: anObject [
	items := anObject
]
