"
I am the DISTINCT clause of a SELECT query.
"
Class {
	#name : #PSQLASTDistinctClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'expressions'
	],
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #visiting }
PSQLASTDistinctClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTDistinctClause: self
]

{ #category : #accessing }
PSQLASTDistinctClause >> expressions [
	^ expressions
]

{ #category : #accessing }
PSQLASTDistinctClause >> expressions: anObject [
	expressions := anObject
]

{ #category : #testing }
PSQLASTDistinctClause >> hasExpressions [
	^ expressions isNotNil
]

{ #category : #testing }
PSQLASTDistinctClause >> isDistinctClause [
	^ true
]
