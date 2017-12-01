"
I represent the instantiation of a composite value. My #items list holds expressions or constants.
"
Class {
	#name : #PSQLASTCompositeValue,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'items'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #accessing }
PSQLASTCompositeValue >> items [
	^ items
]

{ #category : #accessing }
PSQLASTCompositeValue >> items: anObject [
	items := anObject
]
