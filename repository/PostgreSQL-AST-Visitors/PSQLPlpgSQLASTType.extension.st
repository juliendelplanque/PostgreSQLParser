Extension { #name : #PSQLPlpgSQLASTType }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTType >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTType: self
]
