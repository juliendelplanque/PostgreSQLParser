"
I am a superclass for set operation clause in a SELECT query (e.g. UNION, INTERSECT,...).
"
Class {
	#name : #PSQLASTSetOperatorClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'isDistinct',
		'selectQuery'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #initialization }
PSQLASTSetOperatorClause >> initialize [
	super initialize.
	self isDistinct: true
]

{ #category : #testing }
PSQLASTSetOperatorClause >> isAll [
	^ self isDistinct not
]

{ #category : #accessing }
PSQLASTSetOperatorClause >> isDistinct [
	^ isDistinct
]

{ #category : #accessing }
PSQLASTSetOperatorClause >> isDistinct: anObject [
	isDistinct := anObject
]

{ #category : #accessing }
PSQLASTSetOperatorClause >> selectQuery [
	^ selectQuery
]

{ #category : #accessing }
PSQLASTSetOperatorClause >> selectQuery: anObject [
	selectQuery := anObject
]
