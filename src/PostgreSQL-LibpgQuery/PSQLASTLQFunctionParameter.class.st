"
I am the AST node representing a parameter of a function.
"
Class {
	#name : #PSQLASTLQFunctionParameter,
	#superclass : #PSQLASTNode,
	#instVars : [
		'identifier',
		'typeIdentifier'
	],
	#category : #'PostgreSQL-LibpgQuery-AST-Extension'
}

{ #category : #accessing }
PSQLASTLQFunctionParameter >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLASTLQFunctionParameter >> identifier: anObject [
	identifier := anObject
]

{ #category : #printing }
PSQLASTLQFunctionParameter >> innerPrintOn: aStream [
	aStream
		<< self identifier identifier;
		<< ':';
		<< self typeIdentifier identifier
]

{ #category : #accessing }
PSQLASTLQFunctionParameter >> typeIdentifier [
	^ typeIdentifier
]

{ #category : #accessing }
PSQLASTLQFunctionParameter >> typeIdentifier: anObject [
	typeIdentifier := anObject
]
