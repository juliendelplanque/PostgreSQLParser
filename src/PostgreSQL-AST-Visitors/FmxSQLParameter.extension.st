Extension { #name : #FmxSQLParameter }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLParameter >> createReferenceEntityFrom: aFmxSQLEntity [
	| parameterAccess |
	parameterAccess := FmxSQLParameterAccess new
		parameter: self;
		yourself.
	aFmxSQLEntity references add: parameterAccess.
	^ parameterAccess
]
