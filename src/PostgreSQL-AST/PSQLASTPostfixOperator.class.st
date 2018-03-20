"
I represent a postfix operator.
"
Class {
	#name : #PSQLASTPostfixOperator,
	#superclass : #PSQLASTOperator,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTPostfixOperator >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTPostfixOperator: self
]
