Extension { #name : #PSQLASTConditionalExpression }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTConditionalExpression >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTConditionalExpression: self
]
