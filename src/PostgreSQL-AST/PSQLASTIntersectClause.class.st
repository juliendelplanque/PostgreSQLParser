"
I am the INTERSECT clause of a SELECT query.
"
Class {
	#name : #PSQLASTIntersectClause,
	#superclass : #PSQLASTSetOperatorClause,
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #visiting }
PSQLASTIntersectClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTIntersectClause: self
]

{ #category : #testing }
PSQLASTIntersectClause >> isIntersectClause [
	^ true
]
