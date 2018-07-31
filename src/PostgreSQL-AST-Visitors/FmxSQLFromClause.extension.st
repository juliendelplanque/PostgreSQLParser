Extension { #name : #FmxSQLFromClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLFromClause >> reachableEntities [
	"The FROM clause add only tables and views in the scope, not the columns and functions which are only used for conditions"

	^ super reachableEntities
		,
			(self references
				flatCollect: [ :aReference | 
					aReference reference isColumnsContainer
						ifTrue: [ aReference reference reachableEntities ]
						ifFalse: [ #() ] ])
]
