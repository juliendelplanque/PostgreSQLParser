"
I represent the declaration of a variable by copying a type.
"
Class {
	#name : #PSQLPlpgSQLASTCopyTypeDeclaration,
	#superclass : #PSQLPlpgSQLASTDeclaration,
	#instVars : [
		'accessToCopyType'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCopyTypeDeclaration >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCopyTypeDeclaration: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCopyTypeDeclaration >> accessToCopyType [
	^ accessToCopyType
]

{ #category : #accessing }
PSQLPlpgSQLASTCopyTypeDeclaration >> accessToCopyType: anObject [
	accessToCopyType := anObject
]
