"
I represent the HAVING clause of a SELECT query.
"
Class {
	#name : #PSQLASTHavingClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'expressions'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #accessing }
PSQLASTHavingClause >> expressions [
	^ expressions
]

{ #category : #accessing }
PSQLASTHavingClause >> expressions: anObject [
	expressions := anObject
]
