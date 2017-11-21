Extension { #name : #PSQLASTHavingClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTHavingClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTHavingClause: self
]
