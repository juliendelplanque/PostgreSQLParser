Extension { #name : #FmxSQLDerivedTable }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLDerivedTable >> createReferenceEntityFrom: aFmxSQLEntity [
	| derivedTableReference |
	derivedTableReference := FmxSQLDerivedTableReference new
		derivedTable: self;
		yourself.
	aFmxSQLEntity references add: derivedTableReference.
	^ derivedTableReference
]
