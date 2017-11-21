Extension { #name : #PSQLASTArrayConstructor }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTArrayConstructor >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTArrayConstructor: self
]
