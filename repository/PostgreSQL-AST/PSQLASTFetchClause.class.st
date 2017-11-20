"
I represent a FETCH clause AST node in a SELECT query.
"
Class {
	#name : #PSQLASTFetchClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'isFirst',
		'count'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTFetchClause >> count [
	^ count
]

{ #category : #accessing }
PSQLASTFetchClause >> count: anObject [
	count := anObject
]

{ #category : #testing }
PSQLASTFetchClause >> hasCount [
	^ self count isNotNil
]

{ #category : #accessing }
PSQLASTFetchClause >> isFirst [
	^ isFirst
]

{ #category : #accessing }
PSQLASTFetchClause >> isFirst: anObject [
	isFirst := anObject
]

{ #category : #testing }
PSQLASTFetchClause >> isNext [
	^ self isFirst not
]
