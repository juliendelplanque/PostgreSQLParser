Extension { #name : #Number }

{ #category : #'*PostgreSQL-LibpgQuery' }
Number >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitNumber: self
]
