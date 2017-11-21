Extension { #name : #Dictionary }

{ #category : #'*PostgreSQL-LibpgQuery' }
Dictionary >> extractString [
	^ self psqlJSONAccept: PSQLStringExtractor new
]

{ #category : #'*PostgreSQL-LibpgQuery' }
Dictionary >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitDictionary: self
]
