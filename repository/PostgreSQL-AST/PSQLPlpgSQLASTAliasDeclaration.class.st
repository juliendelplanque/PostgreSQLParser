"
I represent the declaration of an an alias for a variable or a parameter.
The variable or parameter is stored in #aliased.
"
Class {
	#name : #PSQLPlpgSQLASTAliasDeclaration,
	#superclass : #PSQLPlpgSQLASTDeclaration,
	#instVars : [
		'aliased'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLPlpgSQLASTAliasDeclaration >> aliased [
	^ aliased
]

{ #category : #accessing }
PSQLPlpgSQLASTAliasDeclaration >> aliased: anObject [
	aliased := anObject
]
