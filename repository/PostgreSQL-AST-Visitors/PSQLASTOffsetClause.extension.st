Extension { #name : #PSQLASTOffsetClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTOffsetClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTOffsetClause: self
]
