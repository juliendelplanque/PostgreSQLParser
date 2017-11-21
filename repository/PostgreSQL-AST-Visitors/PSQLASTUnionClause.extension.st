Extension { #name : #PSQLASTUnionClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTUnionClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTUnionClause: self
]
