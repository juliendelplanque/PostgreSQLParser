"
I am a RETURN statement.
"
Class {
	#name : #PSQLPlpgSQLASTReturnStatement,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'expression',
		'isReturnNext',
		'query',
		'queryExecute',
		'usingExpressions'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> expression [
	^ expression
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> expression: anObject [
	expression := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTReturnStatement >> hasUsingExpressions [
	^ self usingExpressions isNotNil
]

{ #category : #initialization }
PSQLPlpgSQLASTReturnStatement >> initialize [
	super initialize.
	self
		isReturnNext: false
]

{ #category : #testing }
PSQLPlpgSQLASTReturnStatement >> isEmptyReturn [
	"Returns true if I represent a statement with the form 'RETURN'."
	^ self expression isNil and: [ self isReturnNext not and: [ self query isNil and: [ self queryExecute isNil and: [ self usingExpressions isNil ] ] ] ]
]

{ #category : #testing }
PSQLPlpgSQLASTReturnStatement >> isReturnExpression [
	"Returns true if I represent a statement with the form 'RETURN expression'."
	^ self isReturnNext not and: [ self expression isNotNil ]
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> isReturnNext [
	^ isReturnNext
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> isReturnNext: anObject [
	isReturnNext := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTReturnStatement >> isReturnQuery [
	"Returns true if I represent a statement with the form 'RETURN QUERY query'."
	^ self query isNotNil
]

{ #category : #testing }
PSQLPlpgSQLASTReturnStatement >> isReturnQueryExecute [
	"Returns true if I represent a statement with the form 'RETURN QUERY EXECUTE command-string [ USING expression [, ... ] ]'."
	^ self queryExecute isNotNil
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> query [
	^ query
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> query: anObject [
	query := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> queryExecute [
	^ queryExecute
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> queryExecute: anObject [
	queryExecute := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> usingExpressions [
	^ usingExpressions
]

{ #category : #accessing }
PSQLPlpgSQLASTReturnStatement >> usingExpressions: anObject [
	usingExpressions := anObject
]
