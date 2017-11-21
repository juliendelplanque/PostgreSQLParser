Extension { #name : #PSQLASTOnConflictClause }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTOnConflictClause >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTOnConflictClause: self
]
