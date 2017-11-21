Extension { #name : #PSQLASTSelectWhereClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTSelectWhereClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTSelectWhereClause: self
]
