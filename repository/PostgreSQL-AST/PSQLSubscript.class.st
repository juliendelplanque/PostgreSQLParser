"
I represent a subscript i.e. something like ""var[i]"".
"
Class {
	#name : #PSQLSubscript,
	#superclass : #PSQLExpressionASTNode,
	#instVars : [
		'target',
		'subscriptExpression'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLSubscript >> subscriptExpression [
	^ subscriptExpression
]

{ #category : #accessing }
PSQLSubscript >> subscriptExpression: anObject [
	subscriptExpression := anObject
]

{ #category : #accessing }
PSQLSubscript >> target [
	^ target
]

{ #category : #accessing }
PSQLSubscript >> target: anObject [
	target := anObject
]
