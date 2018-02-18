"
I am FROM clause item of type 1. See PSQLGrammar>>#fromItems1.
"
Class {
	#name : #PSQLASTFromClauseItemType1,
	#superclass : #PSQLASTFromClauseItem,
	#instVars : [
		'hasOnly',
		'tableName',
		'alias',
		'columnAliases',
		'areDescendantTablesIncluded'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTFromClauseItemType1 >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTFromClauseItemType1: self
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> alias [
	^ alias
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> areDescendantTablesIncluded [
	^ areDescendantTablesIncluded
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> areDescendantTablesIncluded: anObject [
	areDescendantTablesIncluded := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> columnAliases [
	^ columnAliases
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> columnAliases: anObject [
	columnAliases := anObject
]

{ #category : #testing }
PSQLASTFromClauseItemType1 >> hasAlias [
	^ self alias isNotNil
]

{ #category : #testing }
PSQLASTFromClauseItemType1 >> hasColumnAliases [
	^ self columnAliases isNotNil
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> hasOnly [
	^ hasOnly
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> hasOnly: anObject [
	hasOnly := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> tableName [
	^ tableName
]

{ #category : #accessing }
PSQLASTFromClauseItemType1 >> tableName: anObject [
	tableName := anObject
]
