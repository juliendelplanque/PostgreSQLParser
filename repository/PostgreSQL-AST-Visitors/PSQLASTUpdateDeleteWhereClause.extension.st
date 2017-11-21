Extension { #name : #PSQLASTUpdateDeleteWhereClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTUpdateDeleteWhereClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTUpdateDeleteWhereClause: self
]
