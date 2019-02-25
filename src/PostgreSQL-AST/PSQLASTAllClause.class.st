"
I am the ALL clause in a SELECT query.
"
Class {
	#name : #PSQLASTAllClause,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTAllClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTAllClause: self
]

{ #category : #testing }
PSQLASTAllClause >> isAllClause [
	^ true
]
