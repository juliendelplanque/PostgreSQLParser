tests
testStringConstant
	self
		parse: '''Hello you!''' rule: #stringConstant;
		parse: '''Hello \''mister\''!''' rule: #stringConstant;
		parse: 'U&''d\0061t\+000061''' rule: #stringConstant;
		parse: 'U&''\0441\043B\043E\043D''' rule: #stringConstant;
		parse: 'U&''d!0061t!+000061''' rule: #stringConstant;
		parse: '$$Dianne''s horse$ $' rule: #stringConstant;
		parse: '$SomeTag$Dianne''s horse$ SomeTag$' rule: #stringConstant;
		parse: '$function$
BEGIN
    RETURN ($1 ~ $q$[\t\r\n\v\\]$ q$);
END;
$ function$' rule: #stringConstant