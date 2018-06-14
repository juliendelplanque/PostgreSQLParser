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
	self
		pushScope:
			(PSQLAliasScope new
				alias: aString;
				correspondingEntity: aBlockClosure value;
				yourself)
]

{ #category : #accessing }
PSQLReferenciesSolver >> initialize [
	super initialize.
	self scopes: Stack new
]

{ #category : #accessing }
PSQLReferenciesSolver >> popScope [
	"poping will remove all the transparents scopes (alias) and the first real scope"

	[ self scopes top isAlias ] whileTrue: [ self scopes pop ].
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
	self
		pushScope:
			(PSQLNotCurrentEntityScope new
				entity: anEntity;
				yourself)
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
			aChainOfIdentifiers entity: entity.
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

{ #category : #accessing }
PSQLReferenciesSolver >> topScopeReachableEntities [
	^ (self scopes detect: [ :aScope | aScope isAlias not ]) reachableEntities
]
