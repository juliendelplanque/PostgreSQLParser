Class {
	#name : #PSQParsingReport,
	#superclass : #Object,
	#instVars : [
		'errors'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #adding }
PSQParsingReport >> addError: anError [
	^ self errors add: anError
]

{ #category : #accessing }
PSQParsingReport >> errors [
	^ errors
]

{ #category : #accessing }
PSQParsingReport >> errors: anObject [
	errors := anObject
]

{ #category : #accessing }
PSQParsingReport >> initialize [
	super initialize.
	self errors: OrderedCollection new.
]
