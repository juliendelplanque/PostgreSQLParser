Extension { #name : #PSQLASTPrefixOperator }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTPrefixOperator >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTPrefixOperator: self
]
