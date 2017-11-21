Extension { #name : #PSQLASTStringConstant }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTStringConstant >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTStringConstant: self
]
