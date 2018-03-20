Extension { #name : #Array }

{ #category : #'*PostgreSQL-LibpgQuery' }
Array >> extractString [
	^ self psqlJSONAccept: PSQLStringExtractor new
]

{ #category : #'*PostgreSQL-LibpgQuery' }
Array >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitArray: self
]
