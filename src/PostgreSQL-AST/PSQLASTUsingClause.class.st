Class {
	#name : #PSQLASTUsingClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'list'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTUsingClause >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTUsingClause: self
]

{ #category : #accessing }
PSQLASTUsingClause >> list [
	^ list
]

{ #category : #accessing }
PSQLASTUsingClause >> list: anObject [
	list := anObject
]
