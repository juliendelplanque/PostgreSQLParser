Extension { #name : #PSQLASTTableAlias }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTTableAlias >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTTableAlias: self
]
