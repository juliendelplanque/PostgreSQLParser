"
I am FROM clause item of type 3. See PSQLGrammar>>#fromItems3.
"
Class {
	#name : #PSQLASTFromClauseItemType3,
	#superclass : #PSQLASTFromClauseItem,
	#instVars : [
		'withQueryName',
		'alias',
		'columnAliases'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTFromClauseItemType3 >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTFromClauseItemType3: self
]

{ #category : #accessing }
PSQLASTFromClauseItemType3 >> alias [
	^ alias
]

{ #category : #accessing }
PSQLASTFromClauseItemType3 >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType3 >> columnAliases [
	^ columnAliases
]

{ #category : #accessing }
PSQLASTFromClauseItemType3 >> columnAliases: anObject [
	columnAliases := anObject
]

{ #category : #testing }
PSQLASTFromClauseItemType3 >> hasAlias [
	^ self alias isNotNil
]

{ #category : #testing }
PSQLASTFromClauseItemType3 >> hasColumnAliases [
	^ self columnAliases isNotNil
]

{ #category : #accessing }
PSQLASTFromClauseItemType3 >> withQueryName [
	^ withQueryName
]

{ #category : #accessing }
PSQLASTFromClauseItemType3 >> withQueryName: anObject [
	withQueryName := anObject
]
