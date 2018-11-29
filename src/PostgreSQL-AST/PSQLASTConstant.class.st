"
I represent a constant.
"
Class {
	#name : #PSQLASTConstant,
	#superclass : #PSQLASTNode,
	#instVars : [
		'content'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #'instance creation' }
PSQLASTConstant class >> content: aString [
	^ self new
		content: aString;
		yourself
]

{ #category : #accessing }
PSQLASTConstant >> content [
	^ content
]

{ #category : #accessing }
PSQLASTConstant >> content: anObject [
	content := anObject
]

{ #category : #printing }
PSQLASTConstant >> innerPrintOn: aStream [
	aStream
		<< self content
]

{ #category : #testing }
PSQLASTConstant >> isConstant [
	^ true
]
