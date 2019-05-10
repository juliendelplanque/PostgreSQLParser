"
I am an error signalled when the parsing of some SQL code made from PostgreSQLParser facade failed.

I hold the related #petitFailure.
"
Class {
	#name : #PSQLParseError,
	#superclass : #Error,
	#instVars : [
		'petitFailure',
		'inputString'
	],
	#category : #'PostgreSQL-Facade'
}

{ #category : #signalling }
PSQLParseError class >> signalPetitFailure: aPPFailure inputString: aString [
	self new
		petitFailure: aPPFailure;
		inputString: aString;
		signal
]

{ #category : #accessing }
PSQLParseError >> inputString [
	^ inputString
]

{ #category : #accessing }
PSQLParseError >> inputString: anObject [
	inputString := anObject
]

{ #category : #accessing }
PSQLParseError >> petitFailure [
	^ petitFailure
]

{ #category : #accessing }
PSQLParseError >> petitFailure: anObject [
	petitFailure := anObject
]
