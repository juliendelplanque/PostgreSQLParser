"
I represent the OFFSET clause of a SELECT query.
"
Class {
	#name : #PSQLASTOffsetClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'offset'
	],
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #visiting }
PSQLASTOffsetClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTOffsetClause: self
]

{ #category : #testing }
PSQLASTOffsetClause >> isOffsetClause [
	^ true
]

{ #category : #accessing }
PSQLASTOffsetClause >> offset [
	^ offset
]

{ #category : #accessing }
PSQLASTOffsetClause >> offset: anObject [
	offset := anObject
]
