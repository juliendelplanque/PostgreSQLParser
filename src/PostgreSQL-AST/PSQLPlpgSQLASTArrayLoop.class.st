"
I am a FOR loop on an array expression.
"
Class {
	#name : #PSQLPlpgSQLASTArrayLoop,
	#superclass : #PSQLPlpgSQLASTLoop,
	#instVars : [
		'target',
		'sliceNumber',
		'arrayExpression'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTArrayLoop >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTArrayLoop: self
]

{ #category : #accessing }
PSQLPlpgSQLASTArrayLoop >> arrayExpression [
	^ arrayExpression
]

{ #category : #accessing }
PSQLPlpgSQLASTArrayLoop >> arrayExpression: anObject [
	arrayExpression := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTArrayLoop >> isArrayLoop [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTArrayLoop >> sliceNumber [
	^ sliceNumber
]

{ #category : #accessing }
PSQLPlpgSQLASTArrayLoop >> sliceNumber: anObject [
	sliceNumber := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTArrayLoop >> target [
	^ target
]

{ #category : #accessing }
PSQLPlpgSQLASTArrayLoop >> target: anObject [
	target := anObject
]
