"
I am an abstract PostgreSQL token.
"
Class {
	#name : #PSQLToken,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : 'PostgreSQL-Old'
}

{ #category : #comparing }
PSQLToken >> = anObject [
	^ self class = anObject class and: [ self contents = anObject contents ]
]

{ #category : #accessing }
PSQLToken >> contents [
	^ contents
]

{ #category : #accessing }
PSQLToken >> contents: anObject [
	contents := anObject
]

{ #category : #comparing }
PSQLToken >> hash [
	^ self contents hash
]

{ #category : #testing }
PSQLToken >> isComment [
	^ false
]

{ #category : #testing }
PSQLToken >> isSemicolon [
	^ false
]

{ #category : #testing }
PSQLToken >> isWhiteSpace [
	^ false
]

{ #category : #printing }
PSQLToken >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $(;
		<< self contents;
		<< $)
]
