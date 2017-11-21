Extension { #name : #PSQLPlpgSQLASTCopyTypeDeclaration }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTCopyTypeDeclaration >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTCopyTypeDeclaration: self
]
