Extension { #name : #FmxSQLType }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLType >> reachableEntities [
	self flag: #TODO. "Types can be defined with contained fields"
	^ #()
]
