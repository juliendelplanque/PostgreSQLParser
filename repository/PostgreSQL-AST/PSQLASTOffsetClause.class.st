"
I represent the OFFSET clause of a SELECT query.
"
Class {
	#name : #PSQLASTOffsetClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'offset'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTOffsetClause >> offset [
	^ offset
]

{ #category : #accessing }
PSQLASTOffsetClause >> offset: anObject [
	offset := anObject
]
