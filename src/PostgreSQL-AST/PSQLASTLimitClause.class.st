"
I represent the LIMIT clause of a SELECT query.
"
Class {
	#name : #PSQLASTLimitClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'limit'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTLimitClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTLimitClause: self
]

{ #category : #accessing }
PSQLASTLimitClause >> limit [
	^ limit
]

{ #category : #accessing }
PSQLASTLimitClause >> limit: anObject [
	limit := anObject
]
