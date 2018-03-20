"
I represent a SELECT query.
"
Class {
	#name : #PSQLASTSelectQuery,
	#superclass : #PSQLASTCRUDQuery,
	#instVars : [
		'allOrDistinctClause',
		'columnsAndAliasesSelected',
		'fromClause',
		'whereClause',
		'groupByClause',
		'havingClause',
		'windowClause',
		'unionIntersectExceptClause',
		'orderByClause',
		'limitClause',
		'offsetClause',
		'fetchClause',
		'forClause'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTSelectQuery >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTSelectQuery: self
]

{ #category : #accessing }
PSQLASTSelectQuery >> allOrDistinctClause [
	^ allOrDistinctClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> allOrDistinctClause: anObject [
	allOrDistinctClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> columnsAndAliasesSelected [
	^ columnsAndAliasesSelected
]

{ #category : #accessing }
PSQLASTSelectQuery >> columnsAndAliasesSelected: anObject [
	columnsAndAliasesSelected := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> fetchClause [
	^ fetchClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> fetchClause: anObject [
	fetchClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> forClause [
	^ forClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> forClause: anObject [
	forClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> fromClause [
	^ fromClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> fromClause: anObject [
	fromClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> groupByClause [
	^ groupByClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> groupByClause: anObject [
	groupByClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> havingClause [
	^ havingClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> havingClause: anObject [
	havingClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> limitClause [
	^ limitClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> limitClause: anObject [
	limitClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> offsetClause [
	^ offsetClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> offsetClause: anObject [
	offsetClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> orderByClause [
	^ orderByClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> orderByClause: anObject [
	orderByClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> unionIntersectExceptClause [
	^ unionIntersectExceptClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> unionIntersectExceptClause: anObject [
	unionIntersectExceptClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> whereClause [
	^ whereClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> whereClause: anObject [
	whereClause := anObject
]

{ #category : #accessing }
PSQLASTSelectQuery >> windowClause [
	^ windowClause
]

{ #category : #accessing }
PSQLASTSelectQuery >> windowClause: anObject [
	windowClause := anObject
]
