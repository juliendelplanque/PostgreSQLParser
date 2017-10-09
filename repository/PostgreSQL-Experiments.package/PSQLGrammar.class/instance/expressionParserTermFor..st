expression
expressionParserTermFor: expressionParser
	| parenthesedExpression functionCall aggregateExpression |
	parenthesedExpression := self parenthesedExpressionParserWith: expressionParser.
	functionCall := self functionCallParserWith: expressionParser.
	aggregateExpression := self aggregateExpressionParserWith: expressionParser.
	^ into not , (parenthesedExpression / conditionalExpression / aggregateExpression / functionCall / primary / selectCommand) , (typeCast trim , ((keyword not , identifierOrKeyword) plus separatedBy: #space asParser plus)) optional.