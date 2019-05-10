"
I am the INTO clause of a SELECT INTO query.
"
Class {
	#name : #PSQLASTIntoClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'type',
		'hasTable',
		'newTable'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTIntoClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTIntoClause: self
]

{ #category : #accessing }
PSQLASTIntoClause >> hasTable [
	^ hasTable
]

{ #category : #accessing }
PSQLASTIntoClause >> hasTable: anObject [
	hasTable := anObject
]

{ #category : #testing }
PSQLASTIntoClause >> isIntoClause [
	^ true
]

{ #category : #testing }
PSQLASTIntoClause >> isTemp [
	^ self type = 'TEMP'
]

{ #category : #testing }
PSQLASTIntoClause >> isTemporary [
	^ self type = 'TEMPORARY'
]

{ #category : #testing }
PSQLASTIntoClause >> isUnlogged [
	^ self type = 'UNLOGGED'
]

{ #category : #accessing }
PSQLASTIntoClause >> newTable [
	^ newTable
]

{ #category : #accessing }
PSQLASTIntoClause >> newTable: anObject [
	newTable := anObject
]

{ #category : #private }
PSQLASTIntoClause >> type [
	^ type
]

{ #category : #private }
PSQLASTIntoClause >> type: anObject [
	type := anObject
]
