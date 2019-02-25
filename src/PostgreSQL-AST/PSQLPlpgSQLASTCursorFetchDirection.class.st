"
I am a direction used in a FETCH cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorFetchDirection,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'name',
		'count'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorFetchDirection >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorFetchDirection: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetchDirection >> count [
	^ count
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetchDirection >> count: anObject [
	count := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTCursorFetchDirection >> hasCount [
	^ self count isNotNil
]

{ #category : #testing }
PSQLPlpgSQLASTCursorFetchDirection >> isCursorFetchDirection [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetchDirection >> name [
	^ name
]

{ #category : #accessing }
PSQLPlpgSQLASTCursorFetchDirection >> name: anObject [
	name := anObject
]
