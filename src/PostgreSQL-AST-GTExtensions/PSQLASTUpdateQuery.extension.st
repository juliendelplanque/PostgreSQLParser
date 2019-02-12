Extension { #name : #PSQLASTUpdateQuery }

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTUpdateQuery >> privateSourceCodeAsText [
	^ PostgreSQLHighlighter highlightUpdateQuery: self sourceCode
]
