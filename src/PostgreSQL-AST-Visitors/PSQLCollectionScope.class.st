"
I am a scope that contains and returns all the reachable entities. I am ignored considering the current entity level.
"
Class {
	#name : #PSQLCollectionScope,
	#superclass : #PSQLScope,
	#instVars : [
		'reachableEntitiesOwned'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #'instance creation' }
PSQLCollectionScope class >> reachableEntities: aMooseGroup [
	^ self new
		reachableEntitiesOwned: aMooseGroup;
		yourself
]

{ #category : #accessing }
PSQLCollectionScope >> reachableEntitiesOwned [
	^ reachableEntitiesOwned
]

{ #category : #accessing }
PSQLCollectionScope >> reachableEntitiesOwned: anObject [
	reachableEntitiesOwned := anObject
]
