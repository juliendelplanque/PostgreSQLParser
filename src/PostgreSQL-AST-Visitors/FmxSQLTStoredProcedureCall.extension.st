Extension { #name : #FmxSQLTStoredProcedureCall }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLTStoredProcedureCall >> reference [
	^ self storedProcedure 
]
