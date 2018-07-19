"
I am a trait for visitors that are using a solver
"
Trait {
	#name : #PSQLSolverUserVisitor,
	#instVars : [
		'solver'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #accessing }
PSQLSolverUserVisitor >> currentEntity [
	^ self solver currentEntity
]

{ #category : #accessing }
PSQLSolverUserVisitor >> currentEntity: anEntity [
	^ self solver pushScope: (PSQLEntityScope currentEntity: anEntity)
]

{ #category : #alias }
PSQLSolverUserVisitor >> defineAliasInCurrentScope: anAlias for: aBlockClosure [
	^ self solver defineAliasInCurrentScope: anAlias for: aBlockClosure
]

{ #category : #accessing }
PSQLSolverUserVisitor >> errorReport [
	errorReport ifNil: [ errorReport := PSQParsingReport new ].
	^ errorReport
]

{ #category : #accessing }
PSQLSolverUserVisitor >> errorReport: anObject [
	errorReport := anObject
]

{ #category : #initialization }
PSQLSolverUserVisitor >> initialiseSolver [
	solver := PSQLReferenciesSolver new
]

{ #category : #scope }
PSQLSolverUserVisitor >> popScope [
	^ self solver popScope
]

{ #category : #scope }
PSQLSolverUserVisitor >> pushEntitiesAsScope: aCollectionOfEntities [
	self solver pushEntitiesAsScope: aCollectionOfEntities
]

{ #category : #scope }
PSQLSolverUserVisitor >> pushEntityAsScope: anEntity [
	self solver pushEntityAsScope: anEntity
]

{ #category : #resolution }
PSQLSolverUserVisitor >> resolve: identifiers [
	self solver resolve: identifiers
]

{ #category : #resolution }
PSQLSolverUserVisitor >> resolveSilently: identifiers [
	[ self resolve: identifiers ]
		on: PSQLReferenciesInconsistencies , PSQLReferenciesNotFound
		do: [ :err |  self errorReport addError: err ]
]

{ #category : #accessing }
PSQLSolverUserVisitor >> solver [
	^ solver
]

{ #category : #accessing }
PSQLSolverUserVisitor >> topScopeReachableEntities [
	^ self solver topScopeReachableEntities
]

{ #category : #scope }
PSQLSolverUserVisitor >> useCurrentEntity: anEntity during: aBlock [
	"Here we are not testing that we remove the right scope but if it's not the case, it's probably a bug"

	| entityScope |
	entityScope := self currentEntity: anEntity.
	aBlock value.
	"This assert is to check that the good scope is poped"
	self assert: self solver topScope equals: entityScope.
	self popScope.
	^ anEntity
]
