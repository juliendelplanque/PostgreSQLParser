"
I am an error signalled when the parsing of some SQL code made from PostgreSQLParser facade failed.

I hold the related #petitFailure.
"
Class {
	#name : #PSQLParseError,
	#superclass : #Error,
	#instVars : [
		'petitFailure'
	],
	#category : #'PostgreSQL-Facade'
}

{ #category : #signalling }
PSQLParseError class >> signalPetitFailure: aPPFailure [
	self new
		petitFailure: aPPFailure;
		signal
]

{ #category : #accessing }
PSQLParseError >> petitFailure [
	^ petitFailure
]

{ #category : #accessing }
PSQLParseError >> petitFailure: anObject [
	petitFailure := anObject
]
