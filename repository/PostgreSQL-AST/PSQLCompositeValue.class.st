"
I represent the instantiation of a composite value. My #items list holds expressions or constants.
"
Class {
	#name : #PSQLCompositeValue,
	#superclass : #PSQLExpressionASTNode,
	#instVars : [
		'items'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLCompositeValue >> items [
	^ items
]

{ #category : #accessing }
PSQLCompositeValue >> items: anObject [
	items := anObject
]
