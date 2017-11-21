Extension { #name : #PSQLASTNumericConstant }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTNumericConstant >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTNumericConstant: self
]
