tests
testStringConstantWithUnicodeEscape
	self
		parse: 'U&''d\0061t\+000061''' rule: #stringConstantWithUnicodeEscape;
		parse: 'U&''\0441\043B\043E\043D''' rule: #stringConstantWithUnicodeEscape;
		parse: 'U&''d!0061t!+000061''' rule: #stringConstantWithUnicodeEscape