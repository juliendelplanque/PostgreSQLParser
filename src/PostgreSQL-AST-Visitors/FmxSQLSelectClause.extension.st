Extension { #name : #FmxSQLSelectClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLSelectClause >> reachableEntities [
	"The Select clause can be used in a Using clause with an alias so all its columns will be reachable"

	^ super reachableEntities
		,
			(self references
				collect: [ :aReference | aReference reference ]
				thenSelect: [ :referenced | referenced class = FmxSQLColumn ])
]
