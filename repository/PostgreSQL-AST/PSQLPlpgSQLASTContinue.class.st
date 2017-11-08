"
I am a continue statement that can eventually target a #label and a #whenExpression.
"
Class {
	#name : #PSQLPlpgSQLASTContinue,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'label',
		'whenExpression'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLPlpgSQLASTContinue >> label [
	^ label
]

{ #category : #accessing }
PSQLPlpgSQLASTContinue >> label: anObject [
	label := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTContinue >> whenExpression [
	^ whenExpression
]

{ #category : #accessing }
PSQLPlpgSQLASTContinue >> whenExpression: anObject [
	whenExpression := anObject
]
