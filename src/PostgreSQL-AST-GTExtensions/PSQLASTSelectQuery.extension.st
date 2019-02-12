Extension { #name : #PSQLASTSelectQuery }

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTSelectQuery >> privateSourceCodeAsText [
	^ PostgreSQLHighlighter highlightSelectQuery: self sourceCode
]
