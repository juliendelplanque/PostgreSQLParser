"
I model a condition which, if evaluates to true, leads to the expression to be evaluated.
"
Class {
	#name : #PSQLASTConditionToExpression,
	#superclass : #PSQLASTNode,
	#instVars : [
		'condition',
		'expression'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #'instance creation' }
PSQLASTConditionToExpression class >> condition: aPSQLASTNode expression: aPSQLASTExpression [
	^ self new
		condition: aPSQLASTNode;
		expression: aPSQLASTExpression;
		yourself
]

{ #category : #visiting }
PSQLASTConditionToExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTConditionToExpression: self
]

{ #category : #accessing }
PSQLASTConditionToExpression >> condition [
	^ condition
]

{ #category : #accessing }
PSQLASTConditionToExpression >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
PSQLASTConditionToExpression >> expression [
	^ expression
]

{ #category : #accessing }
PSQLASTConditionToExpression >> expression: anObject [
	expression := anObject
]

{ #category : #testing }
PSQLASTConditionToExpression >> isConditionToExpression [
	^ true
]
