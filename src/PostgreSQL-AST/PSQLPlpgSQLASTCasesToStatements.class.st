Class {
	#name : #PSQLPlpgSQLASTCasesToStatements,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'cases',
		'statements'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #'instance creation' }
PSQLPlpgSQLASTCasesToStatements class >> cases: collectionOfCases statements: statements [
	^ self new
		cases: collectionOfCases;
		statements: statements;
		yourself
]

{ #category : #visiting }
PSQLPlpgSQLASTCasesToStatements >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCasesToStatements: self
]

{ #category : #accessing }
PSQLPlpgSQLASTCasesToStatements >> cases [
	^ cases
]

{ #category : #accessing }
PSQLPlpgSQLASTCasesToStatements >> cases: anObject [
	cases := anObject
]

{ #category : #testing }
PSQLPlpgSQLASTCasesToStatements >> isCasesToStatements [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTCasesToStatements >> statements [
	^ statements
]

{ #category : #accessing }
PSQLPlpgSQLASTCasesToStatements >> statements: anObject [
	statements := anObject
]
