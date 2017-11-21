Extension { #name : #PSQLPlpgSQLASTBlockLabel }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTBlockLabel >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTBlockLabel: self
]
