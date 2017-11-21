Extension { #name : #PSQLPlpgSQLASTContinue }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTContinue >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTContinue: self
]
