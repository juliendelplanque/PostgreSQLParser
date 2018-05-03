"
I hold a numeric constant in #content.
"
Class {
	#name : #PSQLASTStringConstant,
	#superclass : #PSQLASTConstant,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTStringConstant >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTStringConstant: self
]
