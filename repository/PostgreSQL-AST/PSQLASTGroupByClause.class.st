"
I represent the GROUP BY clause of a SELECT query.
"
Class {
	#name : #PSQLASTGroupByClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'expressions'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTGroupByClause >> expressions [
	^ expressions
]

{ #category : #accessing }
PSQLASTGroupByClause >> expressions: anObject [
	expressions := anObject
]
