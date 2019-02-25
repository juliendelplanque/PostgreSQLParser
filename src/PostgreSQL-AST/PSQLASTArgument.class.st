"
I represent the node for an argument passed to a function or a cursor
"
Class {
	#name : #PSQLASTArgument,
	#superclass : #PSQLASTNode,
	#instVars : [
		'parameterName',
		'parameterValue'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTArgument >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTArgument: self
]

{ #category : #testing }
PSQLASTArgument >> isArgument [
	^ true
]

{ #category : #accessing }
PSQLASTArgument >> parameterName [
	^ parameterName
]

{ #category : #accessing }
PSQLASTArgument >> parameterName: anObject [
	parameterName := anObject
]

{ #category : #accessing }
PSQLASTArgument >> parameterValue [
	^ parameterValue
]

{ #category : #accessing }
PSQLASTArgument >> parameterValue: anObject [
	parameterValue := anObject
]
