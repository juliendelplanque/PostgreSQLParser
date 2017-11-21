Extension { #name : #PSQLPlpgSQLASTBlock }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTBlock >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTBlock: self
]
