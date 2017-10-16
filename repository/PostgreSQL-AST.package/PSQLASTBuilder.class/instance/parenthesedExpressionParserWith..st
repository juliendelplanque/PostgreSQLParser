expression
parenthesedExpressionParserWith: expressionParser
	^ (super parenthesedExpressionParserWith: expressionParser)
			==> [ :tokens | 
				PSQLParenthesedExpression new
					expression: tokens second;
					yourself ]