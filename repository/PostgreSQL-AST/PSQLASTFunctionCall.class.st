"
I represent the call of a function. I hold positional arguments in #argumentsList and keyed arguments in argumentsDictionary.
"
Class {
	#name : #PSQLASTFunctionCall,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'functionIdentifier',
		'argumentsList',
		'argumentsDictionary'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #accessing }
PSQLASTFunctionCall >> argumentsDictionary [
	^ argumentsDictionary
]

{ #category : #accessing }
PSQLASTFunctionCall >> argumentsDictionary: anObject [
	argumentsDictionary := anObject
]

{ #category : #accessing }
PSQLASTFunctionCall >> argumentsList [
	^ argumentsList
]

{ #category : #accessing }
PSQLASTFunctionCall >> argumentsList: anObject [
	argumentsList := anObject
]

{ #category : #accessing }
PSQLASTFunctionCall >> functionIdentifier [
	^ functionIdentifier
]

{ #category : #accessing }
PSQLASTFunctionCall >> functionIdentifier: anObject [
	functionIdentifier := anObject
]

{ #category : #printing }
PSQLASTFunctionCall >> innerPrintOn: aStream [
	aStream << self functionIdentifier identifier
]
