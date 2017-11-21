Extension { #name : #PSQLASTIntersectClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTIntersectClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTIntersectClause: self
]
