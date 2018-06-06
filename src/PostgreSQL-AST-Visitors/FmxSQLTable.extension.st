Extension { #name : #FmxSQLTable }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLTable >> createReferenceEntityFrom: aFmxSQLEntity [
	| tableReference |
	tableReference := FmxSQLTableReference new
		table: self;
		yourself.
	aFmxSQLEntity references add: tableReference.
	^ tableReference
]

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLTable >> reachableEntities [
	^ self columns 
]
