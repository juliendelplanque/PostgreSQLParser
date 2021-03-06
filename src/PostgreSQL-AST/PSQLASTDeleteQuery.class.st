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
		'tableName'
	],
	#category : #'PostgreSQL-AST-SQL-CRUD'
}

{ #category : #visiting }
PSQLASTDeleteQuery >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTDeleteQuery: self
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

{ #category : #testing }
PSQLASTDeleteQuery >> isDeleteQuery [
	^ true
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
