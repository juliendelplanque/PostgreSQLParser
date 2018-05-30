Extension { #name : #FmxSQLReference }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLReference >> reference [
	^ self subclassResponsibility
]

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLReference >> resolveAsPartOfTheQuery: aFmxSQLInsertQuery [ 
	self shouldBeImplemented.
]
