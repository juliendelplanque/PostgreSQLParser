Class {
	#name : #PSQLPlpgSQLASTCursorOpenForExecute,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#instVars : [
		'executeStatement',
		'scroll'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorOpenForExecute >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorOpenForExecute: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpenForExecute >> executeStatement [
	^ executeStatement
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpenForExecute >> executeStatement: anObject [
	executeStatement := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpenForExecute >> scroll [
	^ scroll
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorOpenForExecute >> scroll: anObject [
	scroll := anObject
]
