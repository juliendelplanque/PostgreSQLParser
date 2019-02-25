"
I represent a null token in the AST (useful to treat cases with polymorphism)
"
Class {
	#name : #PSQLASTNull,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTNull >> acceptVisitor: aPSQLASTReflectiveVisitor [
	^ aPSQLASTReflectiveVisitor visitPSQASTNull: self
]

{ #category : #testing }
PSQLASTNull >> isNull [
	^ true
]
