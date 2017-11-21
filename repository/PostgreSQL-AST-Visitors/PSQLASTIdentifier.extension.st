Extension { #name : #PSQLASTIdentifier }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTIdentifier >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTIdentifier: self
]
