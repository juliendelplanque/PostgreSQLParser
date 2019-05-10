"
I represent a SET clause.
"
Class {
	#name : #PSQLASTSetClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'items'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTSetClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTSetClause: self
]

{ #category : #testing }
PSQLASTSetClause >> isSetClause [
	^ true
]

{ #category : #accessing }
PSQLASTSetClause >> items [
	^ items
]

{ #category : #accessing }
PSQLASTSetClause >> items: anObject [
	items := anObject
]
