Extension { #name : #Boolean }

{ #category : #'*PostgreSQL-LibpgQuery' }
Boolean >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitBoolean: self
]
