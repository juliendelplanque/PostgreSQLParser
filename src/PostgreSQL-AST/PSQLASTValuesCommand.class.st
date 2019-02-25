Class {
	#name : #PSQLASTValuesCommand,
	#superclass : #PSQLASTNode,
	#instVars : [
		'values'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTValuesCommand >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTValuesCommand: self
]

{ #category : #testing }
PSQLASTValuesCommand >> isValuesCommand [
	^ true
]

{ #category : #accessing }
PSQLASTValuesCommand >> values [
	^ values
]

{ #category : #accessing }
PSQLASTValuesCommand >> values: anObject [
	values := anObject
]
