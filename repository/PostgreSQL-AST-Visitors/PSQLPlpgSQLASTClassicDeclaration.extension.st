Extension { #name : #PSQLPlpgSQLASTClassicDeclaration }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTClassicDeclaration >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTClassicDeclaration: self
]
