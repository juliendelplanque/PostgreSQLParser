"
I represent a subscript i.e. something like ""var[i]"".
"
Class {
	#name : #PSQLASTSubscript,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'target',
		'subscriptExpression'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTSubscript >> subscriptExpression [
	^ subscriptExpression
]

{ #category : #accessing }
PSQLASTSubscript >> subscriptExpression: anObject [
	subscriptExpression := anObject
]

{ #category : #accessing }
PSQLASTSubscript >> target [
	^ target
]

{ #category : #accessing }
PSQLASTSubscript >> target: anObject [
	target := anObject
]
