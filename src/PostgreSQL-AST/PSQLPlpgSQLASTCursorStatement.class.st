"
I am an abstract statement related to cursors.

I define the fact that my subclasses hold a cursor identifier.
"
Class {
	#name : #PSQLPlpgSQLASTCursorStatement,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'cursorIdentifier'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorStatement >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorStatement: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorStatement >> cursorIdentifier [
	^ cursorIdentifier
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorStatement >> cursorIdentifier: anObject [
	cursorIdentifier := anObject
]
