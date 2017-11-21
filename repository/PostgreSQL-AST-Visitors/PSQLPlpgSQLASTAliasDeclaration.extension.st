Extension { #name : #PSQLPlpgSQLASTAliasDeclaration }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTAliasDeclaration >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTAliasDeclaration: self
]
