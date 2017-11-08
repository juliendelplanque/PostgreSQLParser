"
I represent a constant.
"
Class {
	#name : #PSQLASTConstant,
	#superclass : #PSQLASTNode,
	#instVars : [
		'content'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLASTConstant >> content [
	^ content
]

{ #category : #accessing }
PSQLASTConstant >> content: anObject [
	content := anObject
]
