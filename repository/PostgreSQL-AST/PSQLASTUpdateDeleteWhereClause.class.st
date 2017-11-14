"
I represent the WHERE clause for an UPDATE/DELETE query.
"
Class {
	#name : #PSQLASTUpdateDeleteWhereClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'currentOfCursor',
		'condition'
	],
	#category : #PostgreSQL-AST-Nodes
}

{ #category : #accessing }
PSQLASTUpdateDeleteWhereClause >> condition [
	^ condition
]

{ #category : #accessing }
PSQLASTUpdateDeleteWhereClause >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
PSQLASTUpdateDeleteWhereClause >> currentOfCursor [
	^ currentOfCursor
]

{ #category : #accessing }
PSQLASTUpdateDeleteWhereClause >> currentOfCursor: anObject [
	currentOfCursor := anObject
]

{ #category : #testing }
PSQLASTUpdateDeleteWhereClause >> hasCondition [
	^ self condition isNotNil
]

{ #category : #testing }
PSQLASTUpdateDeleteWhereClause >> hasCursor [
	^ self currentOfCursor isNotNil
]
