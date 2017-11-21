Extension { #name : #PSQLASTSubscript }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTSubscript >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTSubscript: self
]
