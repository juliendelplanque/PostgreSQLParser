"
I represent a DELETE FROM cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorDelete,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#instVars : [
		'tableIdentifier'
	],
	#category : #PostgreSQL-AST-PlpgSQL
}

{ #category : #accessing }
PSQLPlpgSQLASTCursorDelete >> tableIdentifier [
	^ tableIdentifier
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDelete >> tableIdentifier: anObject [
	tableIdentifier := anObject
]
