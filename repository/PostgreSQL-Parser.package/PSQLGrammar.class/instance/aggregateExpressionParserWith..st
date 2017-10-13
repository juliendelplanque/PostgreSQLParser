expression
aggregateExpressionParserWith: expressionParser
	self flag: 'Check if the orderByClause should not be outside the parentheses.'.
	^ aggregateName , (openParenthesis ,
		(asterik /
		 ((kw all / kw distinct) optional,
		 (expressionParser plus separatedBy: comma trim) , orderByClause )),
	closeParenthesis)