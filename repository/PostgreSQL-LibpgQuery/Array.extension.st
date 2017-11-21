Extension { #name : #Array }

{ #category : #'*PostgreSQL-LibpgQuery' }
Array >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitArray: self
]
