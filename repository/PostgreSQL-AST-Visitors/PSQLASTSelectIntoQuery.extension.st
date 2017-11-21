Extension { #name : #PSQLASTSelectIntoQuery }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTSelectIntoQuery >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTSelectIntoQuery: self
]
