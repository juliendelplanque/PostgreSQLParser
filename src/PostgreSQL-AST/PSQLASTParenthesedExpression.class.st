"
I represent an expression between parentheses.
"
Class {
	#name : #PSQLASTParenthesedExpression,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'expression'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTParenthesedExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTParenthesedExpression: self
]

{ #category : #accessing }
PSQLASTParenthesedExpression >> expression [
	^ expression
]

{ #category : #accessing }
PSQLASTParenthesedExpression >> expression: anObject [
	expression := anObject
]

{ #category : #printing }
PSQLASTParenthesedExpression >> innerPrintOn: aStream [
	aStream
		<< $(.
	self expression innerPrintOn: aStream.
	aStream
		<< $).
]
