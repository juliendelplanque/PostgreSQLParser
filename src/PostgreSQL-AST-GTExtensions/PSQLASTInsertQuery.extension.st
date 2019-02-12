Extension { #name : #PSQLASTInsertQuery }

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTInsertQuery >> privateSourceCodeAsText [
	^ PostgreSQLHighlighter highlightInsertQuery: self sourceCode
]
