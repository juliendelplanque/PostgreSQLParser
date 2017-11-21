"
I am the AST node representing a 'CREATE FUNCTION' statement.
"
Class {
	#name : #PSQLASTLQCreateFunction,
	#superclass : #PSQLASTNode,
	#instVars : [
		'identifier',
		'body'
	],
	#category : #PostgreSQL-LibpgQuery-AST-Extension
}

{ #category : #accessing }
PSQLASTLQCreateFunction >> body [
	^ body
]

{ #category : #accessing }
PSQLASTLQCreateFunction >> body: anObject [
	body := anObject
]

{ #category : #accessing }
PSQLASTLQCreateFunction >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLASTLQCreateFunction >> identifier: anObject [
	identifier := anObject
]

{ #category : #printing }
PSQLASTLQCreateFunction >> innerPrintOn: aStream [
	aStream << self identifier identifier
]
