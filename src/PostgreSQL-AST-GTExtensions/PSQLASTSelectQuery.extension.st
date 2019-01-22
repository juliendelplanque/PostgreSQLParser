Extension { #name : #PSQLASTSelectQuery }

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTSelectQuery >> privateSourceCodeAsText [
	| text |
	text := super privateSourceCodeAsText.
	PPTextHighlighter new
						parser: (PSQLKeywordsParser new / #any asParser) star end;
						bold: #keyword;
						highlight: text.

	PPTextHighlighter new
						parser: PSQLTokenizer new;
						color: #comment with: Color gray;
						color: #constant with: Color yellow;
						color: #identifier with: Color red;
						highlight: text.

	PPTextHighlighter new
						parser: PSQLSelectQueryGrammar new;
						addAttribute: TextEmphasis italic for: #identifier;
						highlight: text.
	^ text
]
