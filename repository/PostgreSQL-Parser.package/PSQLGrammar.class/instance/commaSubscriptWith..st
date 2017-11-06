expression
commaSubscriptWith: expressionParser
	^ openBracket , (expressionParser trim plus separatedBy: comma trim) , closeBracket