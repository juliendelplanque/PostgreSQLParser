Extension { #name : #PSQLPlpgSQLASTSimpleCase }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTSimpleCase >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTSimpleCase: self
]
