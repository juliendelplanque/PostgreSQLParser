Extension { #name : #FmxSQLStoredProcedure }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLStoredProcedure >> reachableEntities [
	^ self localVariables 
]
