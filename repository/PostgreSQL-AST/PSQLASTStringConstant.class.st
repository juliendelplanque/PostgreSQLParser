"
I hold a numeric constant in #content.
"
Class {
	#name : #PSQLASTStringConstant,
	#superclass : #PSQLASTConstant,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTStringConstant >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTStringConstant: self
]
