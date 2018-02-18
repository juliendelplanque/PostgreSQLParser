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
		'alias',
		'columns'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTInsertQuery >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTInsertQuery: self
]

{ #category : #accessing }
PSQLASTInsertQuery >> alias [
	^ alias
]

{ #category : #accessing }
PSQLASTInsertQuery >> alias: anObject [
	alias := anObject
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
PSQLASTInsertQuery >> hasAlias [
	^ self alias isNotNil
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
