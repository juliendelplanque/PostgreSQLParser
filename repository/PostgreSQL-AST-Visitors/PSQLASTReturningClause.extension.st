Extension { #name : #PSQLASTReturningClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTReturningClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTReturningClause: self
]
