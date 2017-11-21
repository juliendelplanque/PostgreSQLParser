Extension { #name : #PSQLASTOrderByClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTOrderByClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTOrderByClause: self
]
