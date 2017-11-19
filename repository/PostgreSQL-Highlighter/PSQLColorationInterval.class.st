Class {
	#name : #PSQLColorationInterval,
	#superclass : #Object,
	#instVars : [
		'interval',
		'rule'
	],
	#category : #PostgreSQL-Highlighter
}

{ #category : #accessing }
PSQLColorationInterval >> begin [
	^ interval first
]

{ #category : #accessing }
PSQLColorationInterval >> end [
	^ interval last
]

{ #category : #accessing }
PSQLColorationInterval >> interval [
	^ interval
]

{ #category : #accessing }
PSQLColorationInterval >> interval: anObject [
	interval := anObject
]

{ #category : #printing }
PSQLColorationInterval >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $(.
	self interval printOn: aStream.
	aStream 
		<< ', '.
	self rule printOn: aStream.
	aStream
		<< $)
]

{ #category : #accessing }
PSQLColorationInterval >> rule [
	^ rule
]

{ #category : #accessing }
PSQLColorationInterval >> rule: anObject [
	rule := anObject
]
