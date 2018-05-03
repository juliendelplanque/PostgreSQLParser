"
I am an AST node for a loop. I define the fact that a loop may have a begin, a end label and have a list of statements.
"
Class {
	#name : #PSQLPlpgSQLASTLoop,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'beginLabel',
		'endLabel',
		'statements'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #accessing }
PSQLPlpgSQLASTLoop >> beginLabel [
	^ beginLabel
]

{ #category : #accessing }
PSQLPlpgSQLASTLoop >> beginLabel: anObject [
	beginLabel := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTLoop >> endLabel [
	^ endLabel
]

{ #category : #accessing }
PSQLPlpgSQLASTLoop >> endLabel: anObject [
	endLabel := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTLoop >> statements [
	^ statements
]

{ #category : #accessing }
PSQLPlpgSQLASTLoop >> statements: anObject [
	statements := anObject
]
