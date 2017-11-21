Extension { #name : #PSQLPlpgSQLASTForLoop }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTForLoop >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTForLoop: self
]
