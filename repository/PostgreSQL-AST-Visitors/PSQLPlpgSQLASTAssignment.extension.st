Extension { #name : #PSQLPlpgSQLASTAssignment }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTAssignment >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTAssignment: self
]
