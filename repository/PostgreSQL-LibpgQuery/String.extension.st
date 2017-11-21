Extension { #name : #String }

{ #category : #'*PostgreSQL-LibpgQuery' }
String >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitString: self
]
