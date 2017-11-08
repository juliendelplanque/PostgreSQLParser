"
I represent an attribute access like 'identifier.attributeIdentifier'.
"
Class {
	#name : #PSQLASTAttributeAccess,
	#superclass : #PSQLASTNode,
	#instVars : [
		'accessed',
		'attributeIdentifier'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLASTAttributeAccess >> accessed [
	^ accessed
]

{ #category : #accessing }
PSQLASTAttributeAccess >> accessed: anObject [
	accessed := anObject
]

{ #category : #accessing }
PSQLASTAttributeAccess >> attributeIdentifier [
	^ attributeIdentifier
]

{ #category : #accessing }
PSQLASTAttributeAccess >> attributeIdentifier: anObject [
	attributeIdentifier := anObject
]
