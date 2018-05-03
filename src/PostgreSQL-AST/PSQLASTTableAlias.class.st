"
I describe a table.

I hold the identifier used to name the table and a list of column aliases.
"
Class {
	#name : #PSQLASTTableAlias,
	#superclass : #PSQLASTNode,
	#instVars : [
		'identifier',
		'columnAliases'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTTableAlias >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTTableAlias: self
]

{ #category : #accessing }
PSQLASTTableAlias >> columnAliases [
	^ columnAliases
]

{ #category : #accessing }
PSQLASTTableAlias >> columnAliases: anObject [
	columnAliases := anObject
]

{ #category : #accessing }
PSQLASTTableAlias >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLASTTableAlias >> identifier: anObject [
	identifier := anObject
]
