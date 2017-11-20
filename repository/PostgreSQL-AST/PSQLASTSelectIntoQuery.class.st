"
I represent a SELECT INTO query.
"
Class {
	#name : #PSQLASTSelectIntoQuery,
	#superclass : #PSQLASTSelectQuery,
	#instVars : [
		'intoClause'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTSelectIntoQuery >> intoClause [
	^ intoClause
]

{ #category : #accessing }
PSQLASTSelectIntoQuery >> intoClause: anObject [
	intoClause := anObject
]
