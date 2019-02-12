Extension { #name : #PSQLASTDeleteQuery }

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTDeleteQuery >> privateSourceCodeAsText [
	^ PostgreSQLHighlighter highlightDeleteQuery: self sourceCode
]
