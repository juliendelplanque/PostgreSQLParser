"
I represent a conditional expression< I store the conditional expressions as an ordered list of associations in #conditionsToExpressions and store the else expression in #elseExpression,
"
Class {
	#name : #PSQLASTConditionalExpression,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'conditionsToExpressions',
		'elseExpression'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTConditionalExpression >> conditionsToExpressions [
	^ conditionsToExpressions
]

{ #category : #accessing }
PSQLASTConditionalExpression >> conditionsToExpressions: anObject [
	conditionsToExpressions := anObject
]

{ #category : #accessing }
PSQLASTConditionalExpression >> elseExpression [
	^ elseExpression
]

{ #category : #accessing }
PSQLASTConditionalExpression >> elseExpression: anObject [
	elseExpression := anObject
]
