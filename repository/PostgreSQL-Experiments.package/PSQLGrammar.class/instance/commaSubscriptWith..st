expression
commaSubscriptWith: expressionParser
	self flag: 'In fact this is an array constructor, maybe it should be treated differently?'.
	^ openBracket , (expressionParser trim plus separatedBy: comma trim) , closeBracket