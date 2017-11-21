Extension { #name : #PSQLASTGroupByClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTGroupByClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTGroupByClause: self
]
