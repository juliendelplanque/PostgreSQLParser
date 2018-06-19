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
PSQLScope >> allReachableEntities [
	^ self hasAliases
		ifTrue: [ self aliases , self reachableEntities ]
		ifFalse: [ self reachableEntities ]
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
	^ self subclassResponsibility 
]
