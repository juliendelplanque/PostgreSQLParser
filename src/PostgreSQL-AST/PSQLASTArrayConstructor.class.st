"
I represent the construction of an Array.
"
Class {
	#name : #PSQLASTArrayConstructor,
	#superclass : #PSQLASTNode,
	#instVars : [
		'items'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTArrayConstructor >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTArrayConstructor: self
]

{ #category : #accessing }
PSQLASTArrayConstructor >> items [
	^ items
]

{ #category : #accessing }
PSQLASTArrayConstructor >> items: anObject [
	items := anObject
]
