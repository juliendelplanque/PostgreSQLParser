Class {
	#name : #PSQLASTCaseToExpression,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'case',
		'expression'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #'instance creation' }
PSQLASTCaseToExpression class >> case: aPSQLASTNode expression: anotherPSQLASTNode [
	^ self new
		case: aPSQLASTNode;
		expression: anotherPSQLASTNode;
		yourself
]

{ #category : #visiting }
PSQLASTCaseToExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTCaseToExpression: self
]

{ #category : #accessing }
PSQLASTCaseToExpression >> case [
	^ case
]

{ #category : #accessing }
PSQLASTCaseToExpression >> case: anObject [
	case := anObject
]

{ #category : #accessing }
PSQLASTCaseToExpression >> expression [
	^ expression
]

{ #category : #accessing }
PSQLASTCaseToExpression >> expression: anObject [
	expression := anObject
]

{ #category : #testing }
PSQLASTCaseToExpression >> isCaseToExpression [
	^ true
]
