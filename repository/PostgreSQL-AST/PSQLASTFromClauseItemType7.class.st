"
I am FROM clause item of type 7. See PSQLGrammar>>#fromItems7.
"
Class {
	#name : #PSQLASTFromClauseItemType7,
	#superclass : #PSQLASTFromClauseItem,
	#instVars : [
		'hasLateral',
		'hasWithOrdinality',
		'functionCall',
		'alias',
		'columnAliases'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> alias [
	^ alias
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> columnAliases [
	^ columnAliases
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> columnAliases: anObject [
	columnAliases := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> functionCall [
	^ functionCall
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> functionCall: anObject [
	functionCall := anObject
]

{ #category : #testing }
PSQLASTFromClauseItemType7 >> hasAlias [
	^ self alias isNotNil
]

{ #category : #testing }
PSQLASTFromClauseItemType7 >> hasColumnAliases [
	^ self columnAliases isNotNil
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> hasLateral [
	^ hasLateral
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> hasLateral: anObject [
	hasLateral := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> hasWithOrdinality [
	^ hasWithOrdinality
]

{ #category : #accessing }
PSQLASTFromClauseItemType7 >> hasWithOrdinality: anObject [
	hasWithOrdinality := anObject
]
