Extension { #name : #PSQLASTPostfixOperator }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTPostfixOperator >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTPostfixOperator: self
]
