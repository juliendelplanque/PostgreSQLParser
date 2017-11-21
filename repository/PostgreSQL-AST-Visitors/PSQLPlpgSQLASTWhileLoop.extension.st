Extension { #name : #PSQLPlpgSQLASTWhileLoop }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTWhileLoop >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTWhileLoop: self
]
