"
I represent a DELETE query.
"
Class {
	#name : #PSQLASTDeleteQuery,
	#superclass : #PSQLASTCRUDQuery,
	#instVars : [
		'usingList',
		'whereClause',
		'returningClause',
		'isOnlySpecified',
		'areDescendantTablesIncluded',
		'tableName',
		'alias'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #accessing }
PSQLASTDeleteQuery >> alias [
	^ alias
]

{ #category : #accessing }
PSQLASTDeleteQuery >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLASTDeleteQuery >> areDescendantTablesIncluded [
	^ areDescendantTablesIncluded
]

{ #category : #accessing }
PSQLASTDeleteQuery >> areDescendantTablesIncluded: anObject [
	areDescendantTablesIncluded := anObject
]

{ #category : #testing }
PSQLASTDeleteQuery >> hasAlias [
	^ self alias isNotNil
]

{ #category : #testing }
PSQLASTDeleteQuery >> hasReturningClause [
	^ self returningClause isNotNil
]

{ #category : #testing }
PSQLASTDeleteQuery >> hasUsingList [
	^ self usingList isNotNil
]

{ #category : #testing }
PSQLASTDeleteQuery >> hasWhereClause [
	^ self whereClause isNotNil
]

{ #category : #initialization }
PSQLASTDeleteQuery >> initialize [
	super initialize.
	self
		isOnlySpecified: false;
		areDescendantTablesIncluded: false
]

{ #category : #accessing }
PSQLASTDeleteQuery >> isOnlySpecified [
	^ isOnlySpecified
]

{ #category : #accessing }
PSQLASTDeleteQuery >> isOnlySpecified: anObject [
	isOnlySpecified := anObject
]

{ #category : #accessing }
PSQLASTDeleteQuery >> returningClause [
	^ returningClause
]

{ #category : #accessing }
PSQLASTDeleteQuery >> returningClause: anObject [
	returningClause := anObject
]

{ #category : #accessing }
PSQLASTDeleteQuery >> tableName [
	^ tableName
]

{ #category : #accessing }
PSQLASTDeleteQuery >> tableName: anObject [
	tableName := anObject
]

{ #category : #accessing }
PSQLASTDeleteQuery >> usingList [
	^ usingList
]

{ #category : #accessing }
PSQLASTDeleteQuery >> usingList: anObject [
	usingList := anObject
]

{ #category : #accessing }
PSQLASTDeleteQuery >> whereClause [
	^ whereClause
]

{ #category : #accessing }
PSQLASTDeleteQuery >> whereClause: anObject [
	whereClause := anObject
]
