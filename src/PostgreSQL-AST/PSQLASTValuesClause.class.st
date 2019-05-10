Class {
	#name : #PSQLASTValuesClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'values'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTValuesClause >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTValuesClause: self
]

{ #category : #testing }
PSQLASTValuesClause >> isValuesClause [
	^ true
]

{ #category : #accessing }
PSQLASTValuesClause >> values [
	^ values
]

{ #category : #accessing }
PSQLASTValuesClause >> values: anObject [
	values := anObject
]
