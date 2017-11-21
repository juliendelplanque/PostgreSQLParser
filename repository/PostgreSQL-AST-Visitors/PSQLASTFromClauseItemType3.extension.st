Extension { #name : #PSQLASTFromClauseItemType3 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFromClauseItemType3 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFromClauseItemType3: self
]
