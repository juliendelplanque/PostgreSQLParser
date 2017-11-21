Extension { #name : #PSQLASTDeleteQuery }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTDeleteQuery >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTDeleteQuery: self
]
