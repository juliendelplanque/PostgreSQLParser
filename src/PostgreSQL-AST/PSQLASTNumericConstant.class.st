"
I hold a numeric constant in #content.
"
Class {
	#name : #PSQLASTNumericConstant,
	#superclass : #PSQLASTConstant,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTNumericConstant >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTNumericConstant: self
]

{ #category : #testing }
PSQLASTNumericConstant >> isNumericConstant [
	^ true
]
