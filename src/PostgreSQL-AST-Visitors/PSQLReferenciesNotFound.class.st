"
I am an error that occurs when the solver do not find the reference
"
Class {
	#name : #PSQLReferenciesNotFound,
	#superclass : #Error,
	#instVars : [
		'identifier'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #exceptioninstantiator }
PSQLReferenciesNotFound class >> signal: anIdentifier [
	^ self new
		identifier: anIdentifier;
		signal
]

{ #category : #accessing }
PSQLReferenciesNotFound >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLReferenciesNotFound >> identifier: anObject [
	identifier := anObject
]
