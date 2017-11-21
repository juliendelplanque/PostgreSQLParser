Extension { #name : #PSQLASTFromClauseItemType5 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFromClauseItemType5 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFromClauseItemType5: self
]
