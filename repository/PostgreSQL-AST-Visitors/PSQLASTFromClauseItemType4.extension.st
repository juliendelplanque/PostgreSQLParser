Extension { #name : #PSQLASTFromClauseItemType4 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFromClauseItemType4 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFromClauseItemType4: self
]
