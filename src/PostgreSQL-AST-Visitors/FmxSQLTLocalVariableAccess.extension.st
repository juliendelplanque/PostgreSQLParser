Extension { #name : #FmxSQLTLocalVariableAccess }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLTLocalVariableAccess >> reference [
	^ self localVariable
]
