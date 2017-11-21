Extension { #name : #PSQLASTFromClauseItemType1 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFromClauseItemType1 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFromClauseItemType1: self
]
