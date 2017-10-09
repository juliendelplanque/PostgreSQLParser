helpers
keywordStop
	^ (#space asParser / openBracket / closeBracket / openParenthesis / closeParenthesis / nil asParser) not not