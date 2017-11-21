Extension { #name : #PSQLASTWildCard }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTWildCard >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTWildCard: self
]
