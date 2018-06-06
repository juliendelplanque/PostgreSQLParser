Class {
	#name : #PSQLASTAliasDefinition,
	#superclass : #PSQLASTNode,
	#instVars : [
		'definition',
		'alias'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTAliasDefinition >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTAliasDefinition: self
]

{ #category : #accessing }
PSQLASTAliasDefinition >> alias [
	^ alias
]

{ #category : #accessing }
PSQLASTAliasDefinition >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLASTAliasDefinition >> definition [
	^ definition
]

{ #category : #accessing }
PSQLASTAliasDefinition >> definition: anObject [
	definition := anObject
]
