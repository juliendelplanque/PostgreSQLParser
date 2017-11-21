Extension { #name : #PSQLPlpgSQLASTSearchedCase }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTSearchedCase >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTSearchedCase: self
]
