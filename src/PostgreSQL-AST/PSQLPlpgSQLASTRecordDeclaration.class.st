"
I am the declaration of a record variable.
"
Class {
	#name : #PSQLPlpgSQLASTRecordDeclaration,
	#superclass : #PSQLPlpgSQLASTDeclaration,
	#category : #PostgreSQL-AST-PlpgSQL
}

{ #category : #visiting }
PSQLPlpgSQLASTRecordDeclaration >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLPlpgSQLASTRecordDeclaration: self
]
