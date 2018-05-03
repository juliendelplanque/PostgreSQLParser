"
I represent the GROUP BY clause of a SELECT query.
"
Class {
	#name : #PSQLASTGroupByClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'expressions'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTGroupByClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTGroupByClause: self
]

{ #category : #accessing }
PSQLASTGroupByClause >> expressions [
	^ expressions
]

{ #category : #accessing }
PSQLASTGroupByClause >> expressions: anObject [
	expressions := anObject
]
