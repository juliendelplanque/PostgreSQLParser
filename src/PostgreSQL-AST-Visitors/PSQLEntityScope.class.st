"
I am a scope that contains one entity. I will return all the reachable entities from the entity i contain if i am asked to. But i will be ignored concerning current entity
"
Class {
	#name : #PSQLEntityScope,
	#superclass : #PSQLScope,
	#instVars : [
		'entity',
		'isCurrentEntity'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #accessing }
PSQLEntityScope class >> currentEntity: anEntity [
	^ self new
		entity: anEntity;
		isCurrentEntity: true;
		yourself
]

{ #category : #accessing }
PSQLEntityScope class >> entity: anEntity [
	^ self new
		entity: anEntity;
		isCurrentEntity: false;
		yourself
]

{ #category : #accessing }
PSQLEntityScope >> currentEntity [
	self assert: self isCurrentEntity.
	^ self entity
]

{ #category : #accessing }
PSQLEntityScope >> entity [
	^ entity
]

{ #category : #accessing }
PSQLEntityScope >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
PSQLEntityScope >> hasCurrentEntity [
	^ self isCurrentEntity
]

{ #category : #initialization }
PSQLEntityScope >> initialize [
	super initialize.
	self isCurrentEntity: false
]

{ #category : #accessing }
PSQLEntityScope >> isCurrentEntity [
	^ isCurrentEntity
]

{ #category : #accessing }
PSQLEntityScope >> isCurrentEntity: anObject [
	isCurrentEntity := anObject
]

{ #category : #accessing }
PSQLEntityScope >> reachableEntities [
	^ self entity reachableEntities
]
