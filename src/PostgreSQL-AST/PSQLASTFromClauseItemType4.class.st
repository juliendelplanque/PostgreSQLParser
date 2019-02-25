"
I am FROM clause item of type 4. See PSQLGrammar>>#fromItems4.
"
Class {
	#name : #PSQLASTFromClauseItemType4,
	#superclass : #PSQLASTFromClauseItem,
	#instVars : [
		'hasLateral',
		'functionCall',
		'alias',
		'columnDefinitions'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTFromClauseItemType4 >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTFromClauseItemType4: self
]

{ #category : #accessing }
PSQLASTFromClauseItemType4 >> alias [
	^ alias
]

{ #category : #accessing }
PSQLASTFromClauseItemType4 >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType4 >> columnDefinitions [
	^ columnDefinitions
]

{ #category : #accessing }
PSQLASTFromClauseItemType4 >> columnDefinitions: anObject [
	columnDefinitions := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType4 >> functionCall [
	^ functionCall
]

{ #category : #accessing }
PSQLASTFromClauseItemType4 >> functionCall: anObject [
	functionCall := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType4 >> hasLateral [
	^ hasLateral
]

{ #category : #accessing }
PSQLASTFromClauseItemType4 >> hasLateral: anObject [
	hasLateral := anObject
]

{ #category : #testing }
PSQLASTFromClauseItemType4 >> isFromClauseItemType4 [
	^ true
]
