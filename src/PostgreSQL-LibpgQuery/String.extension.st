Extension { #name : #String }

{ #category : #'*PostgreSQL-LibpgQuery' }
String >> psqlJSONAccept: aPSQLJSONVisitor [
	^ aPSQLJSONVisitor visitString: self
]

{ #category : #'*PostgreSQL-LibpgQuery' }
String >> psqlRemoveComments [
	^ PSQLCommentsRemover new
		parse: self
]
