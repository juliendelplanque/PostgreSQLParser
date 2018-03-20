"
I represent a prefix operator.
"
Class {
	#name : #PSQLASTPrefixOperator,
	#superclass : #PSQLASTOperator,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTPrefixOperator >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTPrefixOperator: self
]
