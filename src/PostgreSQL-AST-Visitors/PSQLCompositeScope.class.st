Class {
	#name : #PSQLCompositeScope,
	#superclass : #PSQLScope,
	#instVars : [
		'scopes'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #'instance creation' }
PSQLCompositeScope class >> withScopes: aCollectionOfScope [
	^ self new
		addScopes: aCollectionOfScope;
		yourself
]

{ #category : #initialization }
PSQLCompositeScope >> addScopes: aCollectionOfScopes [
	self scopes addAll: aCollectionOfScopes
]

{ #category : #accessing }
PSQLCompositeScope >> aliases [
	^ super aliases , (self scopes flatCollect: #aliases)
]

{ #category : #accessing }
PSQLCompositeScope >> hasAliases [
	^ self scopes anySatisfy: #hasAliases
]

{ #category : #initialization }
PSQLCompositeScope >> initialize [
	super initialize.
	self scopes: OrderedCollection new
]

{ #category : #accessing }
PSQLCompositeScope >> reachableEntitiesOwned [
	^ self scopes flatCollect: #reachableEntities
]

{ #category : #accessing }
PSQLCompositeScope >> scopes [
	^ scopes
]

{ #category : #accessing }
PSQLCompositeScope >> scopes: anObject [
	scopes := anObject
]
