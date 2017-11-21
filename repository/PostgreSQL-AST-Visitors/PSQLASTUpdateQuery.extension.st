Extension { #name : #PSQLASTUpdateQuery }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTUpdateQuery >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTUpdateQuery: self
]
