Extension { #name : #Dictionary }

{ #category : #'*PostgreSQL-LibpgQuery' }
Dictionary >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitDictionary: self
]
