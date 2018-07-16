Extension { #name : #FmxSQLStoredProcedure }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLStoredProcedure >> createReferenceEntityFrom: aFmxSQLStoredProcedure [ 
	| call |
	call := FmxSQLStoredProcedureCall new
		storedProcedure: self;
		yourself.
	aFmxSQLStoredProcedure references add: call.
	^ call
]

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLStoredProcedure >> reachableEntities [
	^ self localVariables, self parameters
]
