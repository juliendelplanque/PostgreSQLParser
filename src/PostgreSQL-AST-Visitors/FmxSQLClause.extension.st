Extension { #name : #FmxSQLClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLClause >> reachableEntities [
	^ self aliases
]
