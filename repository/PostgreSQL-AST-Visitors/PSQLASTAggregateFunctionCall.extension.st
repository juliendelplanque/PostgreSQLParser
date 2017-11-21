Extension { #name : #PSQLASTAggregateFunctionCall }

{ #category : #'*PostgreSQL-AST-Visitors' }
PSQLASTAggregateFunctionCall >> accept: aPSQLVisitor [
	^ aPSQLVisitor visitPSQLASTAggregateFunctionCall: self
]
