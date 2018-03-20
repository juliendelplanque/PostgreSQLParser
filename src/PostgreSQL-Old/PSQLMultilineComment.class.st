"
I represent a multiline comment.

e.g. '/* hello */'
or '/* hello /* nested */ */'
"
Class {
	#name : #PSQLMultilineComment,
	#superclass : #PSQLComment,
	#instVars : [
		'subcomments'
	],
	#category : 'PostgreSQL-Old'
}

{ #category : #testing }
PSQLMultilineComment >> isPSQLMultilineComment [
	^ true
]

{ #category : #accessing }
PSQLMultilineComment >> subcomments [
	^ subcomments
]

{ #category : #accessing }
PSQLMultilineComment >> subcomments: anObject [
	subcomments := anObject
]
