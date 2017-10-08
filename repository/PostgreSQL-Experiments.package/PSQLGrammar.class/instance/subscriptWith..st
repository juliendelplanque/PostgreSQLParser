accessing
subscriptWith: expressionParser
	^ openBracket , expressionParser , (colon , expressionParser) optional , closeBracket