"
I am the node for cursor parameter
"
Class {
	#name : #PSQLPlpgSQLASTCursorParameter,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'parameterName',
		'type'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visit }
PSQLPlpgSQLASTCursorParameter >> acceptVisitor: aPSQLASTVisitor [ 
	^ aPSQLASTVisitor visitPSQLASTCursorParameter: self
]

{ #category : #testing }
PSQLPlpgSQLASTCursorParameter >> isCursorParameter [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorParameter >> parameterName [
	^ parameterName
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorParameter >> parameterName: anObject [
	parameterName := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorParameter >> type [
	^ type
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorParameter >> type: anObject [
	type := anObject
]
