Class {
	#name : #PSQLASTCastExpression,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'expressionToCast',
		'typeToCastToIdentifier'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTCastExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTCastExpression: self
]

{ #category : #accessing }
PSQLASTCastExpression >> expressionToCast [
	^ expressionToCast
]

{ #category : #accessing }
PSQLASTCastExpression >> expressionToCast: anObject [
	expressionToCast := anObject
]

{ #category : #testing }
PSQLASTCastExpression >> isCastExpression [
	^ true
]

{ #category : #accessing }
PSQLASTCastExpression >> typeToCastToIdentifier [
	^ typeToCastToIdentifier
]

{ #category : #accessing }
PSQLASTCastExpression >> typeToCastToIdentifier: anObject [
	typeToCastToIdentifier := anObject
]
