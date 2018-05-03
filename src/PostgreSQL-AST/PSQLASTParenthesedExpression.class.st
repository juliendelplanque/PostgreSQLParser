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
