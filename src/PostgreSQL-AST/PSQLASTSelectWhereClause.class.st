"
I represent the WHERE clause for a SELCECT query.
"
Class {
	#name : #PSQLASTSelectWhereClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'condition'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTSelectWhereClause >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTSelectWhereClause: self
]

{ #category : #accessing }
PSQLASTSelectWhereClause >> condition [
	^ condition
]

{ #category : #accessing }
PSQLASTSelectWhereClause >> condition: anObject [
	condition := anObject
]

{ #category : #testing }
PSQLASTSelectWhereClause >> hasCondition [
	^ self condition isNotNil
]
