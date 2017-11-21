Extension { #name : #PSQLASTExceptClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTExceptClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTExceptClause: self
]
