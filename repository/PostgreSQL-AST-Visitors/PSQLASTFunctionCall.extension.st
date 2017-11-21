Extension { #name : #PSQLASTFunctionCall }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTFunctionCall >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTFunctionCall: self
]
