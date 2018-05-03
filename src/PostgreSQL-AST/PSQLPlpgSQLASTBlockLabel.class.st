"
I represent the label of a block.
"
Class {
	#name : #PSQLPlpgSQLASTBlockLabel,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'labelContent'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #'instance creation' }
PSQLPlpgSQLASTBlockLabel class >> labelContent: aString [
	^ self new
		labelContent: aString;
		yourself
]

{ #category : #visiting }
PSQLPlpgSQLASTBlockLabel >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTBlockLabel: self
]

{ #category : #printing }
PSQLPlpgSQLASTBlockLabel >> innerPrintOn: aStream [
	aStream << self labelContent
]

{ #category : #accessing }
PSQLPlpgSQLASTBlockLabel >> labelContent [
	^ labelContent
]

{ #category : #accessing }
PSQLPlpgSQLASTBlockLabel >> labelContent: anObject [
	labelContent := anObject
]
