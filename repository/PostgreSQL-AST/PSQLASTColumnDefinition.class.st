"
I represent the definition of a column.
"
Class {
	#name : #PSQLASTColumnDefinition,
	#superclass : #PSQLASTNode,
	#instVars : [
		'columnName',
		'type'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #accessing }
PSQLASTColumnDefinition >> columnName [
	^ columnName
]

{ #category : #accessing }
PSQLASTColumnDefinition >> columnName: anObject [
	columnName := anObject
]

{ #category : #accessing }
PSQLASTColumnDefinition >> type [
	^ type
]

{ #category : #accessing }
PSQLASTColumnDefinition >> type: anObject [
	type := anObject
]
