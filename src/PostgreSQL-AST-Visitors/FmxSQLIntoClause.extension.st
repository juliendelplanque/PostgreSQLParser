Extension { #name : #FmxSQLIntoClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLIntoClause >> reachableEntities [
	"The INTO clause adds only tables and views in the scope"

	^ super reachableEntities
		,
			(self references
				flatCollect: [ :aReference | 
					aReference reference isColumnsContainer
						ifTrue: [ aReference reference reachableEntities ]
						ifFalse: [ #() ] ])
]
