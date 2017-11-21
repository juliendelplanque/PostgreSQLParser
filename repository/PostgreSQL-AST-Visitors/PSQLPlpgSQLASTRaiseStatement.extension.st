Extension { #name : #PSQLPlpgSQLASTRaiseStatement }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTRaiseStatement >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTRaiseStatement: self
]
