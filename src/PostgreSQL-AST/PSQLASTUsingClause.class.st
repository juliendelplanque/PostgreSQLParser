Class {
	#name : #PSQLASTUsingClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'list'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTUsingClause >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTUsingClause: self
]

{ #category : #testing }
PSQLASTUsingClause >> isUsingClause [
	^ true
]

{ #category : #accessing }
PSQLASTUsingClause >> list [
	^ list
]

{ #category : #accessing }
PSQLASTUsingClause >> list: anObject [
	list := anObject
]
