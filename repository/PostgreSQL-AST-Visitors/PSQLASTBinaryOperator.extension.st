Extension { #name : #PSQLASTBinaryOperator }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTBinaryOperator >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTBinaryOperator: self
]
