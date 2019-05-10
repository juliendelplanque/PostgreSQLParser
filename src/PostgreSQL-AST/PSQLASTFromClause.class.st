"
I represent a FROM clause AST node.
"
Class {
	#name : #PSQLASTFromClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'items'
	],
	#category : #'PostgreSQL-AST-SQL-Clauses'
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
