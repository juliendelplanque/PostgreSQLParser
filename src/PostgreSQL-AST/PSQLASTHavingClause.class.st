"
I represent the HAVING clause of a SELECT query.
"
Class {
	#name : #PSQLASTHavingClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'expressions'
	],
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #visiting }
PSQLASTHavingClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTHavingClause: self
]

{ #category : #accessing }
PSQLASTHavingClause >> expressions [
	^ expressions
]

{ #category : #accessing }
PSQLASTHavingClause >> expressions: anObject [
	expressions := anObject
]

{ #category : #testing }
PSQLASTHavingClause >> isHavingClause [
	^ true
]
