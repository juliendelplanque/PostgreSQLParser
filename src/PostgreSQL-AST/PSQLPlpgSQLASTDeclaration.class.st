"
I represent an abstract declaration, my subclasses implement concrete declarations.
"
Class {
	#name : #PSQLPlpgSQLASTDeclaration,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'identifier'
	],
	#category : #PostgreSQL-AST-PlpgSQL
}

{ #category : #accessing }
PSQLPlpgSQLASTDeclaration >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLPlpgSQLASTDeclaration >> identifier: anObject [
	identifier := anObject
]
