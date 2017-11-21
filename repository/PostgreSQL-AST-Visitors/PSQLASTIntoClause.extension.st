Extension { #name : #PSQLASTIntoClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTIntoClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTIntoClause: self
]
