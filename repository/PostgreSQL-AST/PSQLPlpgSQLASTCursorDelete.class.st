"
I represent a DELETE FROM cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorDelete,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'tableIdentifier',
		'cursorIdentifier'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #accessing }
PSQLPlpgSQLASTCursorDelete >> cursorIdentifier [
	^ cursorIdentifier
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDelete >> cursorIdentifier: anObject [
	cursorIdentifier := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDelete >> tableIdentifier [
	^ tableIdentifier
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDelete >> tableIdentifier: anObject [
	tableIdentifier := anObject
]
