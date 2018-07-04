"
I am an error that occurs when the solver start to find the reference but then failed to follow the next identifier
"
Class {
	#name : #PSQLReferenciesInconsistencies,
	#superclass : #Error,
	#instVars : [
		'identifier'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #exceptioninstantiator }
PSQLReferenciesInconsistencies class >> signal: anIdentifier [
	^ self new
		identifier: anIdentifier;
		signal
]

{ #category : #accessing }
PSQLReferenciesInconsistencies >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLReferenciesInconsistencies >> identifier: anObject [
	identifier := anObject
]
