"
I represent a MOVE cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorMove,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#instVars : [
		'direction',
		'isFrom'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorMove >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorMove: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorMove >> direction [
	^ direction
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorMove >> direction: anObject [
	direction := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTCursorMove >> hasDirection [
	^ self direction isNotNil
]

{ #category : #testing }
PSQLPlpgSQLASTCursorMove >> isCursorMove [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorMove >> isFrom [
	^ isFrom
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorMove >> isFrom: anObject [
	isFrom := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTCursorMove >> isIn [
	^ self isFrom not
]
