Extension { #name : #PSQLASTAttributeAccess }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTAttributeAccess >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTAttributeAccess: self
]
