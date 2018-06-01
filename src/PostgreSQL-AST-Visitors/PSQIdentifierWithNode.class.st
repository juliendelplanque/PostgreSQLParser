Class {
	#name : #PSQIdentifierWithNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'node',
		'entity',
		'next'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #'instance creation' }
PSQIdentifierWithNode class >> identifier: aStringIdentifier node: aPSQLASTIdentifier [
	^ self new
		identifier: aStringIdentifier;
		node: aPSQLASTIdentifier;
		yourself
]

{ #category : #'instance creation' }
PSQIdentifierWithNode class >> identifier: aStringIdentifier node: aPSQLASTIdentifier next: aNextPSQIdentifierWithNode [
	^ self new
		identifier: aStringIdentifier;
		node: aPSQLASTIdentifier;
		next: aNextPSQIdentifierWithNode;
		yourself
]

{ #category : #accessing }
PSQIdentifierWithNode >> entity [
	^ entity
]

{ #category : #accessing }
PSQIdentifierWithNode >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
PSQIdentifierWithNode >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQIdentifierWithNode >> identifier: anObject [
	identifier := anObject
]

{ #category : #testing }
PSQIdentifierWithNode >> isLast [
	^ self next isNil
]

{ #category : #accessing }
PSQIdentifierWithNode >> next [
	^ next
]

{ #category : #accessing }
PSQIdentifierWithNode >> next: anObject [
	next := anObject
]

{ #category : #accessing }
PSQIdentifierWithNode >> node [
	^ node
]

{ #category : #accessing }
PSQIdentifierWithNode >> node: anObject [
	node := anObject
]

{ #category : #accessing }
PSQIdentifierWithNode >> targetEntity [
	^ self isLast
		ifFalse: [ self next targetEntity ]
		ifTrue: [ self entity ]
]
