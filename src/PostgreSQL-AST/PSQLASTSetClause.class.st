"
I represent a SET clause.
"
Class {
	#name : #PSQLASTSetClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'items'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTSetClause >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTSetClause: self
]

{ #category : #accessing }
PSQLASTSetClause >> items [
	^ items
]

{ #category : #accessing }
PSQLASTSetClause >> items: anObject [
	items := anObject
]
