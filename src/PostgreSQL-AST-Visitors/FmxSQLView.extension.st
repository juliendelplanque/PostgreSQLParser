Extension { #name : #FmxSQLView }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLView >> createReferenceEntityFrom: aFmxSQLEntity [
	| viewReference |
	viewReference := FmxSQLViewReference new
		view: self;
		yourself.
	aFmxSQLEntity references add: viewReference.
	^ viewReference
]
