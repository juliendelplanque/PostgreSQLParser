"
I am the DISTINCT clause of a SELECT query.
"
Class {
	#name : #PSQLASTDistinctClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'expressions'
	],
	#category : #PostgreSQL-AST-Nodes
}

{ #category : #accessing }
PSQLASTDistinctClause >> expressions [
	^ expressions
]

{ #category : #accessing }
PSQLASTDistinctClause >> expressions: anObject [
	expressions := anObject
]
