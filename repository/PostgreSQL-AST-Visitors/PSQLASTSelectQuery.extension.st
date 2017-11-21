Extension { #name : #PSQLASTSelectQuery }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTSelectQuery >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTSelectQuery: self
]
