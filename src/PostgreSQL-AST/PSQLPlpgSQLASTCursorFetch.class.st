"
I represent a FETCH cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorFetch,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#instVars : [
		'direction',
		'isFrom',
		'targets'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorFetch >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorFetch: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetch >> direction [
	^ direction
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetch >> direction: anObject [
	direction := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTCursorFetch >> hasDirection [
	^ self direction isNotNil
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetch >> isFrom [
	^ isFrom
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetch >> isFrom: anObject [
	isFrom := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTCursorFetch >> isIn [
	^ self isFrom not
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetch >> targets [
	^ targets
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetch >> targets: anObject [
	targets := anObject
]
