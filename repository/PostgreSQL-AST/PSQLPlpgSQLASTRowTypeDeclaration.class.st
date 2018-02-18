"
I represent the declaration of a row variable.
"
Class {
	#name : #PSQLPlpgSQLASTRowTypeDeclaration,
	#superclass : #PSQLPlpgSQLASTDeclaration,
	#instVars : [
		'tableIdentifier'
	],
	#category : #PostgreSQL-AST-PlpgSQL
}

{ #category : #visiting }
PSQLPlpgSQLASTRowTypeDeclaration >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLPlpgSQLASTRowTypeDeclaration: self
]

{ #category : #accessing }
PSQLPlpgSQLASTRowTypeDeclaration >> tableIdentifier [
	^ tableIdentifier
]

{ #category : #accessing }
PSQLPlpgSQLASTRowTypeDeclaration >> tableIdentifier: anObject [
	tableIdentifier := anObject
]
