Extension { #name : #PSQLASTFromClauseItemType6 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFromClauseItemType6 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFromClauseItemType6: self
]
