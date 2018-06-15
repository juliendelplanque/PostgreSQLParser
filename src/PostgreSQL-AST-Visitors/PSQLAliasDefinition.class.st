Class {
	#name : #PSQLAliasDefinition,
	#superclass : #Object,
	#instVars : [
		'alias',
		'entity'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #accessing }
PSQLAliasDefinition >> alias [
	^ alias
]

{ #category : #accessing }
PSQLAliasDefinition >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
PSQLAliasDefinition >> entity [
	^ entity
]

{ #category : #accessing }
PSQLAliasDefinition >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
PSQLAliasDefinition >> name [
	^ self alias
]

{ #category : #accessing }
PSQLAliasDefinition >> reachableEntities [
	^ self entity reachableEntities 
]

{ #category : #evaluating }
PSQLAliasDefinition >> value [
	^ self entity
]
