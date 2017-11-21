Extension { #name : #PSQLASTAlternativeSelectIntoQuery }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTAlternativeSelectIntoQuery >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTAlternativeSelectIntoQuery: self
]
