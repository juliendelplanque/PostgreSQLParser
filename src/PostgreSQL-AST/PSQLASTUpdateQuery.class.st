"
I represent an UPDATE query.
"
Class {
	#name : #PSQLASTUpdateQuery,
	#superclass : #PSQLASTCRUDQuery,
	#instVars : [
		'tableName',
		'alias',
		'setClause',
		'fromClause',
		'whereClause',
		'returningClause',
		'areDescendantTablesIncluded',
		'hasOnly'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTUpdateQuery >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTUpdateQuery: self
]

{ #category : #accessing }
PSQLASTUpdateQuery >> alias [
	^ alias
]

{ #category : #accessing }
PSQLASTUpdateQuery >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLASTUpdateQuery >> areDescendantTablesIncluded [
	^ areDescendantTablesIncluded
]

{ #category : #accessing }
PSQLASTUpdateQuery >> areDescendantTablesIncluded: anObject [
	areDescendantTablesIncluded := anObject
]

{ #category : #accessing }
PSQLASTUpdateQuery >> fromClause [
	^ fromClause
]

{ #category : #accessing }
PSQLASTUpdateQuery >> fromClause: anObject [
	fromClause := anObject
]

{ #category : #testing }
PSQLASTUpdateQuery >> hasAlias [
	^ self alias isNotNil
]

{ #category : #testing }
PSQLASTUpdateQuery >> hasFromClause [
	^ self fromClause isNotNil
]

{ #category : #accessing }
PSQLASTUpdateQuery >> hasOnly [
	^ hasOnly
]

{ #category : #accessing }
PSQLASTUpdateQuery >> hasOnly: anObject [
	hasOnly := anObject
]

{ #category : #testing }
PSQLASTUpdateQuery >> hasReturningClause [
	^ self returningClause isNotNil
]

{ #category : #testing }
PSQLASTUpdateQuery >> hasWhereClause [
	^ self whereClause isNotNil
]

{ #category : #accessing }
PSQLASTUpdateQuery >> returningClause [
	^ returningClause
]

{ #category : #accessing }
PSQLASTUpdateQuery >> returningClause: anObject [
	returningClause := anObject
]

{ #category : #accessing }
PSQLASTUpdateQuery >> setClause [
	^ setClause
]

{ #category : #accessing }
PSQLASTUpdateQuery >> setClause: anObject [
	setClause := anObject
]

{ #category : #accessing }
PSQLASTUpdateQuery >> tableName [
	^ tableName
]

{ #category : #accessing }
PSQLASTUpdateQuery >> tableName: anObject [
	tableName := anObject
]

{ #category : #accessing }
PSQLASTUpdateQuery >> whereClause [
	^ whereClause
]

{ #category : #accessing }
PSQLASTUpdateQuery >> whereClause: anObject [
	whereClause := anObject
]
