"
I represent a CLOSE cursor statement.
"
Class {
	#name : #PSQLPlpgSQLCloseCursor,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'cursorIdentifier'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #accessing }
PSQLPlpgSQLCloseCursor >> cursorIdentifier [
	^ cursorIdentifier
]

{ #category : #accessing }
PSQLPlpgSQLCloseCursor >> cursorIdentifier: anObject [
	cursorIdentifier := anObject
]
