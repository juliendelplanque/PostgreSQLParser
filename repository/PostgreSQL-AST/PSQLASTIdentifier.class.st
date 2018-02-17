"
I am an identifier.
"
Class {
	#name : #PSQLASTIdentifier,
	#superclass : #PSQLASTNode,
	#instVars : [
		'identifier'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #'instance creation' }
PSQLASTIdentifier class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #accessing }
PSQLASTIdentifier >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLASTIdentifier >> identifier: anObject [
	identifier := anObject
]

{ #category : #printing }
PSQLASTIdentifier >> innerPrintOn: aStream [
	aStream << self identifier
]
