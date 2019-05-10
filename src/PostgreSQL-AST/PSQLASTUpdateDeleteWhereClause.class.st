"
I represent the WHERE clause for an UPDATE/DELETE query.
"
Class {
	#name : #PSQLASTUpdateDeleteWhereClause,
	#superclass : #PSQLASTSelectWhereClause,
	#instVars : [
		'currentOfCursor'
	],
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #visiting }
PSQLASTUpdateDeleteWhereClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTUpdateDeleteWhereClause: self
]

{ #category : #accessing }
PSQLASTUpdateDeleteWhereClause >> currentOfCursor [
	^ currentOfCursor
]

{ #category : #accessing }
PSQLASTUpdateDeleteWhereClause >> currentOfCursor: anObject [
	currentOfCursor := anObject
]

{ #category : #testing }
PSQLASTUpdateDeleteWhereClause >> hasCursor [
	^ self currentOfCursor isNotNil
]

{ #category : #testing }
PSQLASTUpdateDeleteWhereClause >> isUpdateDeleteWhereClause [
	^ true
]
