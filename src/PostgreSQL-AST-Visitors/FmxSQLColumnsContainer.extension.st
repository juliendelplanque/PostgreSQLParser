Extension { #name : #FmxSQLColumnsContainer }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLColumnsContainer >> isColumnsContainer [
	^ true
]

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLColumnsContainer >> reachableEntities [
	^ self columns
]
