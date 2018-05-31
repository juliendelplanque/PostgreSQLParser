"
I am a scope that define the current entity level. I will return all the reachable entities from the entity i contain if i am asked to.
"
Class {
	#name : #PSQLCurrentEntityScope,
	#superclass : #PSQLScope,
	#instVars : [
		'currentEntity'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #'instance creation' }
PSQLCurrentEntityScope class >> entity: anEntity [
	^ self new
		currentEntity: anEntity;
		yourself
]

{ #category : #accessing }
PSQLCurrentEntityScope >> currentEntity [
	^ currentEntity
]

{ #category : #accessing }
PSQLCurrentEntityScope >> currentEntity: anObject [
	currentEntity := anObject
]

{ #category : #testing }
PSQLCurrentEntityScope >> hasCurrentEntity [
	^ true
]

{ #category : #accessing }
PSQLCurrentEntityScope >> reachableEntities [
	^ self currentEntity reachableEntities
]
