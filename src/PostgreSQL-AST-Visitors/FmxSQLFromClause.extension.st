Extension { #name : #FmxSQLFromClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLFromClause >> reachableEntities [
	^ self references flatCollect: [ :aReference | aReference reference reachableEntities ]
]
