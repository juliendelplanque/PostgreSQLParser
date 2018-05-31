"
I am a scope that contains and returns all the reachable entities. I am ignored considering the current entity level.
"
Class {
	#name : #PSQLCollectionScope,
	#superclass : #PSQLScope,
	#instVars : [
		'reachableEntities'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #accessing }
PSQLCollectionScope >> reachableEntities [
	^ reachableEntities
]

{ #category : #accessing }
PSQLCollectionScope >> reachableEntities: anObject [
	reachableEntities := anObject
]
