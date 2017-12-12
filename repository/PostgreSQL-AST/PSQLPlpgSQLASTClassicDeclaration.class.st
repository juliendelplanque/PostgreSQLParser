"
I represent a classic declaration.
"
Class {
	#name : #PSQLPlpgSQLASTClassicDeclaration,
	#superclass : #PSQLPlpgSQLASTDeclaration,
	#instVars : [
		'isConstant',
		'type',
		'collate',
		'isNotNull',
		'defaultExpression'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> collate [
	^ collate
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> collate: anObject [
	collate := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> defaultExpression [
	^ defaultExpression
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> defaultExpression: anObject [
	defaultExpression := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> isConstant [
	^ isConstant
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> isConstant: anObject [
	isConstant := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> isNotNull [
	^ isNotNull
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> isNotNull: anObject [
	isNotNull := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> type [
	^ type
]

{ #category : #accessing }
PSQLPlpgSQLASTClassicDeclaration >> type: anObject [
	type := anObject
]
