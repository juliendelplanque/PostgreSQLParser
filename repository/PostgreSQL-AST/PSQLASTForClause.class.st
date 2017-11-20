"
I represent a FOR clause AST node in a SELECT query.
"
Class {
	#name : #PSQLASTForClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'isUpdate',
		'ofTables',
		'isNoWait'
	],
	#category : #PostgreSQL-AST
}

{ #category : #testing }
PSQLASTForClause >> hasOfTables [
	^ self ofTables isNotNil
]

{ #category : #accessing }
PSQLASTForClause >> isNoWait [
	^ isNoWait
]

{ #category : #accessing }
PSQLASTForClause >> isNoWait: anObject [
	isNoWait := anObject
]

{ #category : #testing }
PSQLASTForClause >> isShare [
	^ self isUpdate not
]

{ #category : #accessing }
PSQLASTForClause >> isUpdate [
	^ isUpdate
]

{ #category : #accessing }
PSQLASTForClause >> isUpdate: anObject [
	isUpdate := anObject
]

{ #category : #accessing }
PSQLASTForClause >> ofTables [
	^ ofTables
]

{ #category : #accessing }
PSQLASTForClause >> ofTables: anObject [
	ofTables := anObject
]
