Extension { #name : #PSQLPlpgSQLASTArrayLoop }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTArrayLoop >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTArrayLoop: self
]
