Class {
	#name : #PSQLASTArrayConstructor,
	#superclass : #PSQLASTNode,
	#instVars : [
		'items'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTArrayConstructor >> items [
	^ items
]

{ #category : #accessing }
PSQLASTArrayConstructor >> items: anObject [
	items := anObject
]
