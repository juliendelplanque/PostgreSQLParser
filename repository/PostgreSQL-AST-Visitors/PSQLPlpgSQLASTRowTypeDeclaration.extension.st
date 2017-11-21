Extension { #name : #PSQLPlpgSQLASTRowTypeDeclaration }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTRowTypeDeclaration >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTRowTypeDeclaration: self
]
