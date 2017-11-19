"
I am FROM clause item of type 5. See PSQLGrammar>>#fromItems5.
"
Class {
	#name : #PSQLASTFromClauseItemType5,
	#superclass : #PSQLASTFromClauseItem,
	#instVars : [
		'hasLateral',
		'functionCall',
		'columnDefinitions'
	],
	#category : #PostgreSQL-AST
}

{ #category : #accessing }
PSQLASTFromClauseItemType5 >> columnDefinitions [
	^ columnDefinitions
]

{ #category : #accessing }
PSQLASTFromClauseItemType5 >> columnDefinitions: anObject [
	columnDefinitions := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType5 >> functionCall [
	^ functionCall
]

{ #category : #accessing }
PSQLASTFromClauseItemType5 >> functionCall: anObject [
	functionCall := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType5 >> hasLateral [
	^ hasLateral
]

{ #category : #accessing }
PSQLASTFromClauseItemType5 >> hasLateral: anObject [
	hasLateral := anObject
]
