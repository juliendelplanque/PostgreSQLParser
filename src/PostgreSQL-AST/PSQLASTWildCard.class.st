"
I represent the wildcard operator '*'.
"
Class {
	#name : #PSQLASTWildCard,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTWildCard >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTWildCard: self
]

{ #category : #printing }
PSQLASTWildCard >> innerPrintOn: aStream [
	aStream << $*
]

{ #category : #testing }
PSQLASTWildCard >> isWildCard [
	^ true
]
