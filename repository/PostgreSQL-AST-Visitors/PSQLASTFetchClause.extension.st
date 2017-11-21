Extension { #name : #PSQLASTFetchClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFetchClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFetchClause: self
]
