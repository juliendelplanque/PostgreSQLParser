accessing
parenthesedExpressionParserWith: expressionParser
	^ openParenthesis trim , expressionParser , closeParenthesis trim.