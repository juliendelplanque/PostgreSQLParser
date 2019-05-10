"
I represent the WHERE clause for a SELCECT query.
"
Class {
	#name : #PSQLASTSelectWhereClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'condition'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTSelectWhereClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTSelectWhereClause: self
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

{ #category : #testing }
PSQLASTSelectWhereClause >> isSelectWhereClause [
	^ true
]
