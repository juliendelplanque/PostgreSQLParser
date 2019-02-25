"
I am the declaration of a record variable.
"
Class {
	#name : #PSQLPlpgSQLASTRecordDeclaration,
	#superclass : #PSQLPlpgSQLASTDeclaration,
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTRecordDeclaration >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTRecordDeclaration: self
]

{ #category : #testing }
PSQLPlpgSQLASTRecordDeclaration >> isRecordDeclaration [
	^ true
]
