Class {
	#name : #PSQLScopeManager,
	#superclass : #Object,
	#instVars : [
		'associatedSolver',
		'addedScopes'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #'instance creation' }
PSQLScopeManager class >> newAssociatedToSolver: aPSQLReferenciesSolver [
	^ self new
		associatedSolver: aPSQLReferenciesSolver;
		yourself
]

{ #category : #accessing }
PSQLScopeManager >> addedScopes [
	^ addedScopes
]

{ #category : #accessing }
PSQLScopeManager >> addedScopes: anObject [
	addedScopes := anObject
]

{ #category : #accessing }
PSQLScopeManager >> associatedSolver [
	^ associatedSolver
]

{ #category : #accessing }
PSQLScopeManager >> associatedSolver: anObject [
	associatedSolver := anObject
]

{ #category : #clearing }
PSQLScopeManager >> clear [
	self addedScopes do: [ :aScope | self associatedSolver removeScope: aScope ]
]

{ #category : #clearing }
PSQLScopeManager >> clearAndReturnScope [
	| compositeScope |
	compositeScope := PSQLCompositeScope withScopes: self addedScopes.
	self clear.
	^ compositeScope
]

{ #category : #initialization }
PSQLScopeManager >> initialize [
	super initialize.
	self addedScopes: OrderedCollection new
]

{ #category : #'scope creation' }
PSQLScopeManager >> pushScope: aPSQLScope [
	self associatedSolver pushScope: aPSQLScope.
	self addedScopes add: aPSQLScope.
	^ aPSQLScope
]
