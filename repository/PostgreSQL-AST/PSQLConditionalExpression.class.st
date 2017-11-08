"
I represent a conditional expression< I store the conditional expressions as an ordered list of associations in #conditionsToExpressions and store the else expression in #elseExpression,
"
Class {
	#name : #PSQLConditionalExpression,
	#superclass : #PSQLExpressionASTNode,
	#instVars : [
		'conditionsToExpressions',
		'elseExpression'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLConditionalExpression >> conditionsToExpressions [
	^ conditionsToExpressions
]

{ #category : #accessing }
PSQLConditionalExpression >> conditionsToExpressions: anObject [
	conditionsToExpressions := anObject
]

{ #category : #accessing }
PSQLConditionalExpression >> elseExpression [
	^ elseExpression
]

{ #category : #accessing }
PSQLConditionalExpression >> elseExpression: anObject [
	elseExpression := anObject
]
