"
I represent a when expression
"
Class {
	#name : #PSQLASTWhenExpression,
	#superclass : #PSQLASTNode,
	#instVars : [
		'expression'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTWhenExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTWhenExpression: self
]

{ #category : #accessing }
PSQLASTWhenExpression >> expression [
	^ expression
]

{ #category : #accessing }
PSQLASTWhenExpression >> expression: anObject [
	expression := anObject
]
