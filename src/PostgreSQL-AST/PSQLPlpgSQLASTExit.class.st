"
I am an exit node in the AST. I can have a label to reach it if specified and I can also contain a boolean expression which is the condition to leave
"
Class {
	#name : #PSQLPlpgSQLASTExit,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'label',
		'booleanExpression'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTExit >> acceptVisitor: aPSQLASTReflectiveVisitor [ 
	^ aPSQLASTReflectiveVisitor visitPSQPlpgSQLASTExit: self
]

{ #category : #accessing }
PSQLPlpgSQLASTExit >> booleanExpression [
	^ booleanExpression
]

{ #category : #accessing }
PSQLPlpgSQLASTExit >> booleanExpression: anObject [
	booleanExpression := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTExit >> label [
	^ label
]

{ #category : #accessing }
PSQLPlpgSQLASTExit >> label: anObject [
	label := anObject
]
