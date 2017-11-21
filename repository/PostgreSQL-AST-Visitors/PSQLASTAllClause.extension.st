Extension { #name : #PSQLASTAllClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTAllClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTAllClause: self
]
