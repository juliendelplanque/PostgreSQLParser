"
I am FROM clause item of type 6. See PSQLGrammar>>#fromItems6.
"
Class {
	#name : #PSQLASTFromClauseItemType6,
	#superclass : #PSQLASTFromClauseItem,
	#instVars : [
		'leftFromItem',
		'hasNatural',
		'joinType',
		'rightFromItem',
		'joinCondition',
		'usingList'
	],
	#category : #PostgreSQL-AST
}

{ #category : #testing }
PSQLASTFromClauseItemType6 >> hasJoinCondition [
	^ self joinCondition isNotNil
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> hasNatural [
	^ hasNatural
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> hasNatural: anObject [
	hasNatural := anObject
]

{ #category : #testing }
PSQLASTFromClauseItemType6 >> hasUsingList [
	^ self usingList isNotNil
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> joinCondition [
	^ joinCondition
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> joinCondition: anObject [
	joinCondition := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> joinType [
	^ joinType
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> joinType: anObject [
	joinType := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> leftFromItem [
	^ leftFromItem
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> leftFromItem: anObject [
	leftFromItem := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> rightFromItem [
	^ rightFromItem
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> rightFromItem: anObject [
	rightFromItem := anObject
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> usingList [
	^ usingList
]

{ #category : #accessing }
PSQLASTFromClauseItemType6 >> usingList: anObject [
	usingList := anObject
]
