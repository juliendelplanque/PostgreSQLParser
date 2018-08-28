Extension { #name : #FmxSQLStoredProcedureCall }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLStoredProcedureCall >> reference [
	^ self storedProcedure 
]
