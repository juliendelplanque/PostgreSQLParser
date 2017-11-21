Extension { #name : #UndefinedObject }

{ #category : #'*PostgreSQL-LibpgQuery' }
UndefinedObject >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitUndefinedObject: self
]
