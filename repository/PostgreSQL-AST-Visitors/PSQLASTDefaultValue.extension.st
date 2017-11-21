Extension { #name : #PSQLASTDefaultValue }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTDefaultValue >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTDefaultValue: self
]
