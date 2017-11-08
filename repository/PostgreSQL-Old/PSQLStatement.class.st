Class {
	#name : #PSQLStatement,
	#superclass : #Object,
	#instVars : [
		'tokens'
	],
	#category : 'PostgreSQL-Old'
}

{ #category : #'instance creation' }
PSQLStatement class >> tokens: tokens [
	^ self new
			tokens: tokens;
			yourself
]

{ #category : #gt-inspector-extension }
PSQLStatement >> gtDisplayTokensOn: composite [
	<gtInspectorPresentationOrder: 0>  
	^ (composite list)
		title: 'Tokens';
		display: [ :aCollection | self tokensWithoutWhitespaces ];
		yourself
]

{ #category : #printing }
PSQLStatement >> printOn: aStream [
	super printOn: aStream.
	aStream << $(.
	self tokensWithoutWhitespaces do: [ :token |
		aStream << token contents ] separatedBy: [ aStream space ].
	aStream << $)
]

{ #category : #accessing }
PSQLStatement >> tokens [
	^ tokens
]

{ #category : #accessing }
PSQLStatement >> tokens: anObject [
	tokens := anObject
]

{ #category : #accessing }
PSQLStatement >> tokensWithoutWhitespaces [
	^ self tokens reject: #isWhiteSpace
]
