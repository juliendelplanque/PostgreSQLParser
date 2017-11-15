"
I am an abstract node for an item of the SET clause.
"
Class {
	#name : #PSQLASTSetClauseItem,
	#superclass : #PSQLASTNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #PostgreSQL-AST-Nodes
}

{ #category : #accessing }
PSQLASTSetClauseItem >> left [
	^ left
]

{ #category : #accessing }
PSQLASTSetClauseItem >> left: anObject [
	left := anObject
]

{ #category : #accessing }
PSQLASTSetClauseItem >> right [
	^ right
]

{ #category : #accessing }
PSQLASTSetClauseItem >> right: anObject [
	right := anObject
]
