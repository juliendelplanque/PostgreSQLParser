Extension { #name : #PSQLASTCompositeValue }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTCompositeValue >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTCompositeValue: self
]
