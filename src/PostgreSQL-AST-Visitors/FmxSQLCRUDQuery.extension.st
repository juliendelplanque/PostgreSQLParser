Extension { #name : #FmxSQLCRUDQuery }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLCRUDQuery >> reachableEntities [
	"a query do not add reachable entities (but one of its clauses can)"
	^ #()
]
