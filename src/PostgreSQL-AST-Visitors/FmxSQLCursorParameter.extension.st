Extension { #name : #FmxSQLCursorParameter }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLCursorParameter >> createReferenceEntityFrom: aFmxSQLEntity [
	| cursorParameterAccess |
	cursorParameterAccess := FmxSQLCursorParameterAccess new
		parameter: self;
		yourself.
	aFmxSQLEntity references add: cursorParameterAccess.
	^ cursorParameterAccess
]
