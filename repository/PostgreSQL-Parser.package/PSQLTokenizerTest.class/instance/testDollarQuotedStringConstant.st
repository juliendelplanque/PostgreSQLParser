tests
testDollarQuotedStringConstant
	self
		parse: '$$Dianne''s horse$ $' rule: #dollarQuotedStringConstant;
		parse: '$SomeTag$Dianne''s horse$ SomeTag$' rule: #dollarQuotedStringConstant;
		parse: '$function$
BEGIN
    RETURN ($1 ~ $q$[\t\r\n\v\\]$ q$);
END;
$ function$' rule: #dollarQuotedStringConstant