"
I represent a CLOSE cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCloseCursor,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'cursorIdentifier'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #accessing }
PSQLPlpgSQLASTCloseCursor >> cursorIdentifier [
	^ cursorIdentifier
]

{ #category : #accessing }
PSQLPlpgSQLASTCloseCursor >> cursorIdentifier: anObject [
	cursorIdentifier := anObject
]
