Extension { #name : #PSQLPlpgSQLASTQueryResultsLoop }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLPlpgSQLASTQueryResultsLoop >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLPlpgSQLASTQueryResultsLoop: self
]
