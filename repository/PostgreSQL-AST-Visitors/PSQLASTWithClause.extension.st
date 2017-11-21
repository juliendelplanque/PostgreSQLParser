Extension { #name : #PSQLASTWithClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTWithClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTWithClause: self
]
