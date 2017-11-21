Extension { #name : #PSQLASTFromClauseItemType2 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFromClauseItemType2 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFromClauseItemType2: self
]
