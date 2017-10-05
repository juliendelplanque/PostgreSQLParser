accessing
endKeyword
	"Parses a character that ends a keyword without consuming it."
	^ (#space asParser / openBracket / closeBracket / openParenthesis / closeParenthesis / nil asParser) not not