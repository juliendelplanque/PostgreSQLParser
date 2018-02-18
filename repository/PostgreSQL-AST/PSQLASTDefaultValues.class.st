"
I represent the DEFAULT VALUES command in insert command.
"
Class {
	#name : #PSQLASTDefaultValues,
	#superclass : #PSQLASTNode,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTDefaultValues >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTDefaultValues: self
]
