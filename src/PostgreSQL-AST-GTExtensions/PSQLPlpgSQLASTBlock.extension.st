Extension { #name : #PSQLPlpgSQLASTBlock }

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLPlpgSQLASTBlock >> privateSourceCodeAsText [
	^ PostgreSQLHighlighter highlightStoredProcedureBody: self sourceCode
]
