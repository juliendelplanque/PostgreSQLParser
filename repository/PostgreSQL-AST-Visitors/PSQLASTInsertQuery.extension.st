Extension { #name : #PSQLASTInsertQuery }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTInsertQuery >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTInsertQuery: self
]
