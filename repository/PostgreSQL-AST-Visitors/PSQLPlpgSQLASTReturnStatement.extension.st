Extension { #name : #PSQLPlpgSQLASTReturnStatement }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTReturnStatement >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTReturnStatement: self
]
