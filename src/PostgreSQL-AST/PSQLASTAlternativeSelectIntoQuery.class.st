"
I represent the alternative way to write a SELECT INTO query (e.g. ""SELECT INTO newTable * ..."").
"
Class {
	#name : #PSQLASTAlternativeSelectIntoQuery,
	#superclass : #PSQLASTSelectIntoQuery,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTAlternativeSelectIntoQuery >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTAlternativeSelectIntoQuery: self
]

{ #category : #testing }
PSQLASTAlternativeSelectIntoQuery >> isAlternativeSelectIntoQuery [
	^ true
]
