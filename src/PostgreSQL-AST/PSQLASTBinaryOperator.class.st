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

{ #category : #printing }
PSQLASTBinaryOperator >> innerPrintOn: aStream [
	self left innerPrintOn: aStream.
	aStream
		<< Character space;
		<< self operator;
		<< Character space.
	self right innerPrintOn: aStream
]

{ #category : #testing }
PSQLASTBinaryOperator >> isBinaryOperator [
	^ true
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
