Extension { #name : #PSQLASTParenthesedExpression }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTParenthesedExpression >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTParenthesedExpression: self
]
