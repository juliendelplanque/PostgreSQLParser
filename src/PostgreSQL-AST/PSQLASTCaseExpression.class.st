"
I model a CASE expression in PostgreSQL source code.

e.g.

CASE x
	WHEN 1 THEN 'foo'
	WHEN 2 THEN 'bar'
	ELSE 'lol'
END
"
Class {
	#name : #PSQLASTCaseExpression,
	#superclass : #PSQLASTExpressionASTNode,
	#instVars : [
		'caseToExpressions',
		'elseExpression'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTCaseExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTCaseExpression: self
]

{ #category : #accessing }
PSQLASTCaseExpression >> caseToExpressions [
	^ caseToExpressions
]

{ #category : #accessing }
PSQLASTCaseExpression >> caseToExpressions: anObject [
	caseToExpressions := anObject
]

{ #category : #accessing }
PSQLASTCaseExpression >> elseExpression [
	^ elseExpression
]

{ #category : #accessing }
PSQLASTCaseExpression >> elseExpression: anObject [
	elseExpression := anObject
]

{ #category : #testing }
PSQLASTCaseExpression >> isCaseExpression [
	^ true
]
