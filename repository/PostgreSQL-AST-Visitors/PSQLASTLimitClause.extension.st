Extension { #name : #PSQLASTLimitClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTLimitClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTLimitClause: self
]
