Extension { #name : #PSQLASTFromClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFromClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFromClause: self
]
