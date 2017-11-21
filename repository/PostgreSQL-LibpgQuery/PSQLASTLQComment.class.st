"
I am the AST node representing a 'COMMENT ON' statement.
"
Class {
	#name : #PSQLASTLQComment,
	#superclass : #PSQLASTNode,
	#instVars : [
		'comment',
		'target'
	],
	#category : #PostgreSQL-LibpgQuery-AST-Extension
}

{ #category : #accessing }
PSQLASTLQComment >> comment [
	^ comment
]

{ #category : #accessing }
PSQLASTLQComment >> comment: anObject [
	comment := anObject
]

{ #category : #accessing }
PSQLASTLQComment >> target [
	^ target
]

{ #category : #accessing }
PSQLASTLQComment >> target: anObject [
	target := anObject
]
