Extension { #name : #PSQLASTSetClauseItemType2 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTSetClauseItemType2 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTSetClauseItemType2: self
]
