"
I represent an INSERT query.
"
Class {
	#name : #PSQLASTInsertQuery,
	#superclass : #PSQLASTCRUDQuery,
	#instVars : [
		'returningClause',
		'onConflictClause',
		'valuesClause',
		'tableName',
		'columns'
	],
	#category : #'PostgreSQL-AST-SQL-CRUD'
}

{ #category : #visiting }
PSQLASTInsertQuery >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTInsertQuery: self
]

{ #category : #accessing }
PSQLASTInsertQuery >> columns [
	^ columns
]

{ #category : #accessing }
PSQLASTInsertQuery >> columns: anObject [
	columns := anObject
]

{ #category : #testing }
PSQLASTInsertQuery >> hasColumns [
	^ self columns isNotNil
]

{ #category : #testing }
PSQLASTInsertQuery >> hasOnConflictClause [
	^ self onConflictClause isNotNil
]

{ #category : #testing }
PSQLASTInsertQuery >> hasReturningClause [
	^ self returningClause isNotNil
]

{ #category : #testing }
PSQLASTInsertQuery >> isInsertQuery [
	^ true
]

{ #category : #accessing }
PSQLASTInsertQuery >> onConflictClause [
	^ onConflictClause
]

{ #category : #accessing }
PSQLASTInsertQuery >> onConflictClause: anObject [
	onConflictClause := anObject
]

{ #category : #accessing }
PSQLASTInsertQuery >> returningClause [
	^ returningClause
]

{ #category : #accessing }
PSQLASTInsertQuery >> returningClause: anObject [
	returningClause := anObject
]

{ #category : #accessing }
PSQLASTInsertQuery >> tableName [
	^ tableName
]

{ #category : #accessing }
PSQLASTInsertQuery >> tableName: anObject [
	tableName := anObject
]

{ #category : #accessing }
PSQLASTInsertQuery >> valuesClause [
	^ valuesClause
]

{ #category : #accessing }
PSQLASTInsertQuery >> valuesClause: anObject [
	valuesClause := anObject
]
