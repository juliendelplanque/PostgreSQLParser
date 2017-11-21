Extension { #name : #PSQLASTSetClauseItemType3 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTSetClauseItemType3 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTSetClauseItemType3: self
]
