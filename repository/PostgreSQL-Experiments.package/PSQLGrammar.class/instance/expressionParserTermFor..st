expression
expressionParserTermFor: expressionParser
	| parenthesedExpression functionCall aggregateExpression |
	parenthesedExpression := self parenthesedExpressionParserWith: expressionParser.
	functionCall := self functionCallParserWith: expressionParser.
	aggregateExpression := self aggregateExpressionParserWith: expressionParser.
	^ (parenthesedExpression / conditionalExpression / aggregateExpression / functionCall / primary / selectCommand) , ((typeCast trim , ((else not , case not , endKeyword not , andKeyword not , or not , identifierOrKeyword) plus separatedBy: #space asParser plus)) "/
	betweenConstruct") optional.