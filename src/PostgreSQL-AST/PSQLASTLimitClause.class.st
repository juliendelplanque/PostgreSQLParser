"
I represent the LIMIT clause of a SELECT query.
"
Class {
	#name : #PSQLASTLimitClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'limit'
	],
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #visiting }
PSQLASTLimitClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTLimitClause: self
]

{ #category : #testing }
PSQLASTLimitClause >> isLimitClause [
	^ true
]

{ #category : #accessing }
PSQLASTLimitClause >> limit [
	^ limit
]

{ #category : #accessing }
PSQLASTLimitClause >> limit: anObject [
	limit := anObject
]
