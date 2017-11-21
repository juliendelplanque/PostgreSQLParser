Extension { #name : #PSQLASTDefaultValues }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTDefaultValues >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTDefaultValues: self
]
