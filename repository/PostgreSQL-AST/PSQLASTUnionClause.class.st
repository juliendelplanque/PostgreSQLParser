"
I am the UNION clause of a SELECT query.
"
Class {
	#name : #PSQLASTUnionClause,
	#superclass : #PSQLASTSetOperatorClause,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTUnionClause >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTUnionClause: self
]
