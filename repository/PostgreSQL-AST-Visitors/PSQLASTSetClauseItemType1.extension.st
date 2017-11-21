Extension { #name : #PSQLASTSetClauseItemType1 }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTSetClauseItemType1 >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTSetClauseItemType1: self
]
