"
I am a block I hold a label, declarations and statements.
"
Class {
	#name : #PSQLPlpgSQLASTBlock,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'label',
		'declarations',
		'statements'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLPlpgSQLASTBlock >> declarations [
	^ declarations
]

{ #category : #accessing }
PSQLPlpgSQLASTBlock >> declarations: anObject [
	declarations := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTBlock >> label [
	^ label
]

{ #category : #accessing }
PSQLPlpgSQLASTBlock >> label: anObject [
	label := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTBlock >> statements [
	^ statements
]

{ #category : #accessing }
PSQLPlpgSQLASTBlock >> statements: anObject [
	statements := anObject
]
