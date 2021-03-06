"
I represent a OPEN cursor for query statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorOpenForQuery,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#instVars : [
		'selectQuery',
		'scroll'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorOpenForQuery >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorOpenForQuery: self
]

{ #category : #testing }
PSQLPlpgSQLASTCursorOpenForQuery >> isCursorOpenForQuery [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpenForQuery >> scroll [
	^ scroll
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpenForQuery >> scroll: anObject [
	scroll := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpenForQuery >> selectQuery [
	^ selectQuery
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpenForQuery >> selectQuery: anObject [
	selectQuery := anObject
]
