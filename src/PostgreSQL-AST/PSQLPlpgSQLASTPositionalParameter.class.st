"
I am a positional parameter. I hold the index of the parameter.
"
Class {
	#name : #PSQLPlpgSQLASTPositionalParameter,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'index'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTPositionalParameter >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTPositionalParameter: self
]

{ #category : #accessing }
PSQLPlpgSQLASTPositionalParameter >> index [
	^ index
]

{ #category : #accessing }
PSQLPlpgSQLASTPositionalParameter >> index: anObject [
	index := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTPositionalParameter >> isPositionalParameter [
	^ true
]
