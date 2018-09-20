"
I am the node for cursor parameter
"
Class {
	#name : #PSQLASTCursorParameter,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'parameterName',
		'type'
	],
	#category : #'PostgreSQL-AST'
}

{ #category : #visit }
PSQLASTCursorParameter >> acceptVisitor: aPSQLASTVisitor [ 
	^ aPSQLASTVisitor visitPSQLASTCursorParameter: self
]

{ #category : #accessing }
PSQLASTCursorParameter >> parameterName [
	^ parameterName
]

{ #category : #accessing }
PSQLASTCursorParameter >> parameterName: anObject [
	parameterName := anObject
]

{ #category : #accessing }
PSQLASTCursorParameter >> type [
	^ type
]

{ #category : #accessing }
PSQLASTCursorParameter >> type: anObject [
	type := anObject
]
