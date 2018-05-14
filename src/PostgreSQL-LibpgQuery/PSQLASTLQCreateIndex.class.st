"
I am the AST node representing a 'CREATE INDEX' statement.
"
Class {
	#name : #PSQLASTLQCreateIndex,
	#superclass : #PSQLASTNode,
	#instVars : [
		'identifier',
		'table',
		'indexParameters'
	],
	#category : #'PostgreSQL-LibpgQuery-AST-Extension'
}

{ #category : #accessing }
PSQLASTLQCreateIndex >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLASTLQCreateIndex >> identifier: anObject [
	identifier := anObject
]

{ #category : #accessing }
PSQLASTLQCreateIndex >> indexParameters [
	^ indexParameters
]

{ #category : #accessing }
PSQLASTLQCreateIndex >> indexParameters: anObject [
	indexParameters := anObject
]

{ #category : #accessing }
PSQLASTLQCreateIndex >> table [
	^ table
]

{ #category : #accessing }
PSQLASTLQCreateIndex >> table: anObject [
	table := anObject
]
