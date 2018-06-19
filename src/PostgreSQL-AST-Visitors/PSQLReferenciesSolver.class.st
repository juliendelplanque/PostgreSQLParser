"
I am a class that can solve referencies and is able to give you the current entity for your visit
"
Class {
	#name : #PSQLReferenciesSolver,
	#superclass : #Object,
	#instVars : [
		'scopes'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #accessing }
PSQLReferenciesSolver >> currentEntity [
	^ (self scopes detect: #hasCurrentEntity) currentEntity
]

{ #category : #alias }
PSQLReferenciesSolver >> defineAliasInCurrentScope: aString for: aBlockClosure [
	self topScope addAlias: aString forEntity: aBlockClosure value
]

{ #category : #accessing }
PSQLReferenciesSolver >> initialize [
	super initialize.
	self scopes: Stack new
]

{ #category : #accessing }
PSQLReferenciesSolver >> popScope [
	^ self scopes pop
]

{ #category : #accessing }
PSQLReferenciesSolver >> pushEntitiesAsScope: aCollectionOfEntities [
	self
		pushScope:
			(PSQLCollectionScope new
				reachableEntities: aCollectionOfEntities;
				yourself)
]

{ #category : #accessing }
PSQLReferenciesSolver >> pushEntityAsScope: anEntity [
	self pushScope: (PSQLEntityScope entity: anEntity)
]

{ #category : #accessing }
PSQLReferenciesSolver >> pushScope: aScope [
	self scopes push: aScope
]

{ #category : #detect }
PSQLReferenciesSolver >> reachableEntitiesFor: aScope detect: aBlockClosure ifFound: aBlockClosureAction [
	"optimisation to avoid recreate collection"

	aScope reachableEntities
		detect: aBlockClosure
		ifFound: [ :f | ^ aBlockClosureAction value: f ]
		ifNone: [ "continue" ].
	NotFound signal
]

{ #category : #accessing }
PSQLReferenciesSolver >> resolve: aChainOfIdentifiers [
	"a collection of identifier will be for example {'myTable' . 'columnA'}"

	self scopes
		do: [ :aScope | 
			[ ^ self resolve: aChainOfIdentifiers inScope: aScope ]
				on: NotFound
				do: [ "do nothing to try superior scope" ] ].
	NotFound signal
]

{ #category : #accessing }
PSQLReferenciesSolver >> resolve: aChainOfIdentifiers inScope: aScope [
	^ self
		reachableEntitiesFor: aScope
		detect: [ :entity | entity name = aChainOfIdentifiers identifier ]
		ifFound: [ :entity | 
			aChainOfIdentifiers entity: entity value.
			aChainOfIdentifiers isLast
				ifTrue: [ ^ aChainOfIdentifiers ]
				ifFalse: [ [ (self resolve: aChainOfIdentifiers next inScope: entity) ]
						on: NotFound
						do: [ PSQLReferenciesInconsistencies signal ] ] ]
]

{ #category : #accessing }
PSQLReferenciesSolver >> scopes [
	^ scopes
]

{ #category : #accessing }
PSQLReferenciesSolver >> scopes: anObject [
	scopes := anObject
]

{ #category : #alias }
PSQLReferenciesSolver >> topScope [
	^ self scopes top
]

{ #category : #accessing }
PSQLReferenciesSolver >> topScopeReachableEntities [
	^ self topScope reachableEntities
]
