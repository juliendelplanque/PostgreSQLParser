Extension { #name : #FmxSQLAlias }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLAlias >> createReferenceEntityFrom: aFmxSQLEntity [
	| aliasAccess |
	aliasAccess := FmxSQLAliasAccess new
		alias: self;
		yourself.
	aFmxSQLEntity references add: aliasAccess.
	^ aliasAccess
]

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLAlias >> reachableEntities [
	^ self references collect: [ :link | link reference ] thenReject: [ :entity | entity class = FmxSQLStoredProcedure ]
]
