Class {
	#name : #PSQLScope,
	#superclass : #Object,
	#instVars : [
		'aliases'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #adding }
PSQLScope >> addAlias: anAlias forEntity: aCorrespondingEntity [
	self aliases
		add:
			(PSQLAliasDefinition new
				alias: anAlias;
				entity: aCorrespondingEntity;
				yourself)
]

{ #category : #accessing }
PSQLScope >> aliases [
	^ aliases ifNil: [ aliases := OrderedCollection new ] ifNotNil: [ aliases ]
]

{ #category : #accessing }
PSQLScope >> aliases: anObject [
	aliases := anObject
]

{ #category : #accessing }
PSQLScope >> hasAliases [
	^ aliases notNil and: [ aliases notEmpty ]
]

{ #category : #testing }
PSQLScope >> hasCurrentEntity [
	^ false
]

{ #category : #accessing }
PSQLScope >> reachableEntities [
	^ self hasAliases
		ifTrue: [ self aliases , self reachableEntitiesOwned ]
		ifFalse: [ self reachableEntitiesOwned ]
]

{ #category : #accessing }
PSQLScope >> reachableEntitiesOwned [
	^ self subclassResponsibility 
]
