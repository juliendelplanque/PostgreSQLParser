Extension { #name : #PSQLPlpgSQLASTPositionalParameter }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTPositionalParameter >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTPositionalParameter: self
]
