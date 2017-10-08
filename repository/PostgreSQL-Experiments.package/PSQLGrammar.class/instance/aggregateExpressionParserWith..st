expression
aggregateExpressionParserWith: expressionParser
	^ aggregateName , (openParenthesis ,
		(asterik /
		 ((all / distinct) optional,
		 (expressionParser plus separatedBy: comma trim) , orderByClause )),
	closeParenthesis)