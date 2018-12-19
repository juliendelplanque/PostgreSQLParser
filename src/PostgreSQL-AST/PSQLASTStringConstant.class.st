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

{ #category : #printing }
PSQLASTStringConstant >> innerPrintOn: aStream [
	aStream << $'.
	super innerPrintOn: aStream.
	aStream << $'.
]

{ #category : #testing }
PSQLASTStringConstant >> isStringConstant [
	^ true
]
