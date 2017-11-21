Extension { #name : #PSQLPlpgSQLASTIf }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTIf >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTIf: self
]
