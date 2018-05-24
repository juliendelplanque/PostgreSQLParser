Class {
	#name : #PSQLScope,
	#superclass : #Object,
	#instVars : [
		'reachableEntities'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #accessing }
PSQLScope >> reachableEntities [
	^ reachableEntities
]

{ #category : #accessing }
PSQLScope >> reachableEntities: anObject [
	reachableEntities := anObject
]
