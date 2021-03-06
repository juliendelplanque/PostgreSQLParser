"
I represent an abstract operator. The operator is stored in #operator as a String.
"
Class {
	#name : #PSQLASTOperator,
	#superclass : #PSQLASTNode,
	#instVars : [
		'operator',
		'expression'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #accessing }
PSQLASTOperator >> expression [
	^ expression
]

{ #category : #accessing }
PSQLASTOperator >> expression: anObject [
	expression := anObject
]

{ #category : #testing }
PSQLASTOperator >> isOperator [
	^ true
]

{ #category : #accessing }
PSQLASTOperator >> operator [
	^ operator
]

{ #category : #accessing }
PSQLASTOperator >> operator: anObject [
	operator := anObject
]
