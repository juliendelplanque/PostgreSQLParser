Extension { #name : #PSQLASTForClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTForClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTForClause: self
]
