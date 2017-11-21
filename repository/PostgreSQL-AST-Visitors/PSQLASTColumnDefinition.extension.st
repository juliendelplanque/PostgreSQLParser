Extension { #name : #PSQLASTColumnDefinition }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTColumnDefinition >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTColumnDefinition: self
]
