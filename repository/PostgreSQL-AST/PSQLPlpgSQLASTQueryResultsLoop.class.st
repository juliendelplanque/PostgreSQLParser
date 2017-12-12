"
I am a loop iterating on the results of a query.
"
Class {
	#name : #PSQLPlpgSQLASTQueryResultsLoop,
	#superclass : #PSQLPlpgSQLASTLoop,
	#instVars : [
		'target',
		'query'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #accessing }
PSQLPlpgSQLASTQueryResultsLoop >> query [
	^ query
]

{ #category : #accessing }
PSQLPlpgSQLASTQueryResultsLoop >> query: anObject [
	query := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTQueryResultsLoop >> target [
	^ target
]

{ #category : #accessing }
PSQLPlpgSQLASTQueryResultsLoop >> target: anObject [
	target := anObject
]
