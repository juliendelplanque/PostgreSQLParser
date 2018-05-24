Class {
	#name : #PSQLASTValuesClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'values'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTValuesClause >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTValuesClause: self
]

{ #category : #accessing }
PSQLASTValuesClause >> values [
	^ values
]

{ #category : #accessing }
PSQLASTValuesClause >> values: anObject [
	values := anObject
]
