"
I am the AST node for a FOR loop on a #target taking values from #fromExpression to #toExpression. Also, I can be reversed.
"
Class {
	#name : #PSQLPlpgSQLASTForLoop,
	#superclass : #PSQLPlpgSQLASTLoop,
	#instVars : [
		'target',
		'isReversed',
		'fromExpression',
		'toExpression'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTForLoop >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTForLoop: self
]

{ #category : #accessing }
PSQLPlpgSQLASTForLoop >> fromExpression [
	^ fromExpression
]

{ #category : #accessing }
PSQLPlpgSQLASTForLoop >> fromExpression: anObject [
	fromExpression := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTForLoop >> isForLoop [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTForLoop >> isReversed [
	^ isReversed
]

{ #category : #accessing }
PSQLPlpgSQLASTForLoop >> isReversed: anObject [
	isReversed := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTForLoop >> target [
	^ target
]

{ #category : #accessing }
PSQLPlpgSQLASTForLoop >> target: anObject [
	target := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTForLoop >> toExpression [
	^ toExpression
]

{ #category : #accessing }
PSQLPlpgSQLASTForLoop >> toExpression: anObject [
	toExpression := anObject
]
