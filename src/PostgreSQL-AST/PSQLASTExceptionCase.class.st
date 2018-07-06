"
I am an exception case in an Exception handler
"
Class {
	#name : #PSQLASTExceptionCase,
	#superclass : #PSQLASTNode,
	#instVars : [
		'exception',
		'statements'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTExceptionCase >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTExceptionCase: self
]

{ #category : #accessing }
PSQLASTExceptionCase >> exception [
	^ exception
]

{ #category : #accessing }
PSQLASTExceptionCase >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
PSQLASTExceptionCase >> statements [
	^ statements
]

{ #category : #accessing }
PSQLASTExceptionCase >> statements: anObject [
	statements := anObject
]
