"
I am an item in an ORDER BY clause from a SELECT query.
"
Class {
	#name : #PSQLASTOrderByClauseItem,
	#superclass : #PSQLASTNode,
	#instVars : [
		'expression',
		'isAsc',
		'isNullsFirst'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTOrderByClauseItem >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTOrderByClauseItem: self
]

{ #category : #accessing }
PSQLASTOrderByClauseItem >> expression [
	^ expression
]

{ #category : #accessing }
PSQLASTOrderByClauseItem >> expression: anObject [
	expression := anObject
]

{ #category : #testing }
PSQLASTOrderByClauseItem >> hasIsAscOrIsDesc [
	^ self isAsc isNotNil
]

{ #category : #testing }
PSQLASTOrderByClauseItem >> hasNullsFirstOrNullsLast [
	^ self isNullsFirst isNotNil
]

{ #category : #accessing }
PSQLASTOrderByClauseItem >> isAsc [
	^ isAsc
]

{ #category : #accessing }
PSQLASTOrderByClauseItem >> isAsc: anObject [
	isAsc := anObject
]

{ #category : #testing }
PSQLASTOrderByClauseItem >> isDesc [
	^ self isAsc not
]

{ #category : #accessing }
PSQLASTOrderByClauseItem >> isNullsFirst [
	^ isNullsFirst
]

{ #category : #accessing }
PSQLASTOrderByClauseItem >> isNullsFirst: anObject [
	isNullsFirst := anObject
]

{ #category : #testing }
PSQLASTOrderByClauseItem >> isNullsLast [
	^ self isNullsFirst not
]
