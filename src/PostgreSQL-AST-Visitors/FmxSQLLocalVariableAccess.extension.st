Extension { #name : #FmxSQLLocalVariableAccess }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLLocalVariableAccess >> reference [
	^ self localVariable
]
