tests
testConstant
	self
		parse: '''Hello you!''' rule: #constant;
		parse: '''Hello \''mister\''!''' rule: #constant;
		parse: 'U&''d\0061t\+000061''' rule: #constant;
		parse: 'U&''\0441\043B\043E\043D''' rule: #constant;
		parse: 'U&''d!0061t!+000061''' rule: #constant;
		parse: '$$Dianne''s horse$ $' rule: #constant;
		parse: '$SomeTag$Dianne''s horse$ SomeTag$' rule: #constant;
		parse: '$function$
BEGIN
    RETURN ($1 ~ $q$[\t\r\n\v\\]$ q$);
END;
$ function$' rule: #constant;
		parse: '42' rule: #constant;
		parse: '3.5' rule: #constant;
		parse: '4.' rule: #constant;
		parse: '.001' rule: #constant;
		parse: '5e2' rule: #constant;
		parse: '1.925e-3' rule: #constant