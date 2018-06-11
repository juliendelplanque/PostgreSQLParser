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
	^ self solver pushScope: (PSQLCurrentEntityScope entity: anEntity)
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

{ #category : #'as yet unclassified' }
PSQLSolverUserVisitor >> resolve: identifiers [
	self solver resolve: identifiers
]

{ #category : #'as yet unclassified' }
PSQLSolverUserVisitor >> resolveSilently: identifiers [
	[ self resolve: identifiers ]
		on: PSQLReferenciesInconsistencies
		do: [ :err | self addError: err ]
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

	self currentEntity: anEntity.
	aBlock value.
	self popScope.
	^ anEntity
]
