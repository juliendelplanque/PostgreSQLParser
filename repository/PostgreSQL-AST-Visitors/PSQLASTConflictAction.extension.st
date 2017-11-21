Extension { #name : #PSQLASTConflictAction }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTConflictAction >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTConflictAction: self
]
