Extension { #name : #PSQLASTSetClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTSetClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTSetClause: self
]
