"
I represent the WHERE clause for a SELCECT query.
"
Class {
	#name : #PSQLASTSelectWhereClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'condition'
	],
	#category : #PostgreSQL-AST
}

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
