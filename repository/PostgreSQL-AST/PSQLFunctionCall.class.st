"
I represent the call of a function. I hold positional arguments in #argumentsList and keyed arguments in argumentsDictionary.
"
Class {
	#name : #PSQLFunctionCall,
	#superclass : #PSQLExpressionASTNode,
	#instVars : [
		'functionIdentifier',
		'argumentsList',
		'argumentsDictionary'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLFunctionCall >> argumentsDictionary [
	^ argumentsDictionary
]

{ #category : #accessing }
PSQLFunctionCall >> argumentsDictionary: anObject [
	argumentsDictionary := anObject
]

{ #category : #accessing }
PSQLFunctionCall >> argumentsList [
	^ argumentsList
]

{ #category : #accessing }
PSQLFunctionCall >> argumentsList: anObject [
	argumentsList := anObject
]

{ #category : #accessing }
PSQLFunctionCall >> functionIdentifier [
	^ functionIdentifier
]

{ #category : #accessing }
PSQLFunctionCall >> functionIdentifier: anObject [
	functionIdentifier := anObject
]
