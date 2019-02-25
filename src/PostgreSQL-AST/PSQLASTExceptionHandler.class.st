"
I represent an exception node
"
Class {
	#name : #PSQLASTExceptionHandler,
	#superclass : #PSQLASTNode,
	#instVars : [
		'declarations',
		'statements',
		'exceptionCases'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTExceptionHandler >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTExceptionHandler: self
]

{ #category : #accessing }
PSQLASTExceptionHandler >> declarations [
	^ declarations
]

{ #category : #accessing }
PSQLASTExceptionHandler >> declarations: anObject [
	declarations := anObject
]

{ #category : #accessing }
PSQLASTExceptionHandler >> exceptionCases [
	^ exceptionCases
]

{ #category : #accessing }
PSQLASTExceptionHandler >> exceptionCases: anObject [
	exceptionCases := anObject
]

{ #category : #testing }
PSQLASTExceptionHandler >> isExceptionHandler [
	^ true
]

{ #category : #accessing }
PSQLASTExceptionHandler >> statements [
	^ statements
]

{ #category : #accessing }
PSQLASTExceptionHandler >> statements: anObject [
	statements := anObject
]
