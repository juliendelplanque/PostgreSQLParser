"
I represent an OPEN cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorOpen,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#instVars : [
		'arguments'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorOpen >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorOpen: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpen >> arguments [
	^ arguments
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpen >> arguments: anObject [
	arguments := anObject
]
