"
I am a scope that contains one entity. I will return all the reachable entities from the entity i contain if i am asked to. But i will be ignored concerning current entity
"
Class {
	#name : #PSQLNotCurrentEntityScope,
	#superclass : #PSQLScope,
	#instVars : [
		'entity'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #accessing }
PSQLNotCurrentEntityScope >> entity [
	^ entity
]

{ #category : #accessing }
PSQLNotCurrentEntityScope >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
PSQLNotCurrentEntityScope >> reachableEntities [
	^ self entity reachableEntities
]
