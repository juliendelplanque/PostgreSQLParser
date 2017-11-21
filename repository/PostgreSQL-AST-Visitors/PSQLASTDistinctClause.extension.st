Extension { #name : #PSQLASTDistinctClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTDistinctClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTDistinctClause: self
]
