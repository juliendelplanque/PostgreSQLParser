"
I am the declaration of a cursor variable.

#scroll is false if NO SCROLL was used else it is true.
"
Class {
	#name : #PSQLPlpgSQLASTCursorDeclaration,
	#superclass : #PSQLPlpgSQLASTDeclaration,
	#instVars : [
		'scroll',
		'arguments',
		'selectQuery'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorDeclaration >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorDeclaration: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDeclaration >> arguments [
	^ arguments
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDeclaration >> arguments: anObject [
	arguments := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTCursorDeclaration >> isCursorDeclaration [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDeclaration >> scroll [
	^ scroll
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDeclaration >> scroll: anObject [
	scroll := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDeclaration >> selectQuery [
	^ selectQuery
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorDeclaration >> selectQuery: anObject [
	selectQuery := anObject
]
