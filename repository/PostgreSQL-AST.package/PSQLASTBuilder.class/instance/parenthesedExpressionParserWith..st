expression
parenthesedExpressionParserWith: expressionParser
	^ (super parenthesedExpressionParserWith: expressionParser) ==> [ :tokens | tokens second ]