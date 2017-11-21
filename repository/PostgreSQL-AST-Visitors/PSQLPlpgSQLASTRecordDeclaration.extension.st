Extension { #name : #PSQLPlpgSQLASTRecordDeclaration }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTRecordDeclaration >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTRecordDeclaration: self
]
