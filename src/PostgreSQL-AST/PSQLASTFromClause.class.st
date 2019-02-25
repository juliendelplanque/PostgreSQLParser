"
I represent a FROM clause AST node.
"
Class {
	#name : #PSQLASTFromClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'items'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTFromClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTFromClause: self
]

{ #category : #testing }
PSQLASTFromClause >> isFromClause [
	^ true
]

{ #category : #accessing }
PSQLASTFromClause >> items [
	^ items
]

{ #category : #accessing }
PSQLASTFromClause >> items: anObject [
	items := anObject
]
