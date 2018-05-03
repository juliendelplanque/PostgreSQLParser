"
I represent a binary operator.
"
Class {
	#name : #PSQLASTBinaryOperator,
	#superclass : #PSQLASTOperator,
	#instVars : [
		'right'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTBinaryOperator >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTBinaryOperator: self
]

{ #category : #accessing }
PSQLASTBinaryOperator >> left [
	^ self expression
]

{ #category : #accessing }
PSQLASTBinaryOperator >> left: anObject [
	self expression: anObject
]

{ #category : #accessing }
PSQLASTBinaryOperator >> right [
	^ right
]

{ #category : #accessing }
PSQLASTBinaryOperator >> right: anObject [
	right := anObject
]
