"
I represent an expression between parentheses.
"
Class {
	#name : #PSQLParenthesedExpression,
	#superclass : #PSQLExpressionASTNode,
	#instVars : [
		'expression'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLParenthesedExpression >> expression [
	^ expression
]

{ #category : #accessing }
PSQLParenthesedExpression >> expression: anObject [
	expression := anObject
]
