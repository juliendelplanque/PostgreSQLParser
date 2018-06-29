Extension { #name : #FmxSQLCursor }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLCursor >> createReferenceEntityFrom: aFmxSQLEntity [
	| cursorReference |
	cursorReference := FmxSQLCursorReference new
		cursor: self;
		yourself.
	aFmxSQLEntity references add: cursorReference.
	^ cursorReference
]

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLCursor >> query [
	self assert: self queries size equals: 1.
	^ self queries first
]
