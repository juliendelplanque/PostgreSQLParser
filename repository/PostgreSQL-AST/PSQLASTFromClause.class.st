"
I represent a FROM clause AST node.
"
Class {
	#name : #PSQLASTFromClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'items'
	],
	#category : #PostgreSQL-AST-Nodes
}

{ #category : #accessing }
PSQLASTFromClause >> items [
	^ items
]

{ #category : #accessing }
PSQLASTFromClause >> items: anObject [
	items := anObject
]
