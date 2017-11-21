Extension { #name : #PSQLASTOrderByClauseItem }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTOrderByClauseItem >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTOrderByClauseItem: self
]
