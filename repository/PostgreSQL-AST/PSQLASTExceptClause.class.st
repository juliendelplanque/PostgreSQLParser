"
I am the EXCEPT clause of a SELECT query.
"
Class {
	#name : #PSQLASTExceptClause,
	#superclass : #PSQLASTSetOperatorClause,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTExceptClause >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTExceptClause: self
]
