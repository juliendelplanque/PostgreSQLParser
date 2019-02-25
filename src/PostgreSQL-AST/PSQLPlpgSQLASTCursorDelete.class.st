"
I represent a DELETE FROM cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorDelete,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#instVars : [
		'tableIdentifier'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorDelete >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorDelete: self
]

{ #category : #testing }
PSQLPlpgSQLASTCursorDelete >> isCursorDelete [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDelete >> tableIdentifier [
	^ tableIdentifier
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDelete >> tableIdentifier: anObject [
	tableIdentifier := anObject
]
