Extension { #name : #FmxSQLColumn }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLColumn >> createReferenceEntityTo: aFmxSQLEntity [
	| columnReference |
	columnReference := FmxSQLColumnReference new
		column: self;
		yourself.
	aFmxSQLEntity references add: columnReference.
	^ columnReference
]
