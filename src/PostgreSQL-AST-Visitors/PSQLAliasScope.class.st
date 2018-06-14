Class {
	#name : #PSQLAliasScope,
	#superclass : #PSQLScope,
	#instVars : [
		'alias',
		'correspondingEntity'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #accessing }
PSQLAliasScope >> alias [
	^ alias
]

{ #category : #accessing }
PSQLAliasScope >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLAliasScope >> correspondingEntity [
	^ correspondingEntity
]

{ #category : #accessing }
PSQLAliasScope >> correspondingEntity: anObject [
	correspondingEntity := anObject
]

{ #category : #accessing }
PSQLAliasScope >> isAlias [
	^ true
]

{ #category : #accessing }
PSQLAliasScope >> name [
	^ self alias
]

{ #category : #accessing }
PSQLAliasScope >> reachableEntities [
	^ { self }
]

{ #category : #evaluating }
PSQLAliasScope >> value [
	^ self correspondingEntity
]
