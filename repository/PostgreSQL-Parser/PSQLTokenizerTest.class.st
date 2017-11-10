Class {
	#name : #PSQLTokenizerTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLTokenizerTest >> parserClass [
	^ PSQLTokenizer
]

{ #category : #tests }
PSQLTokenizerTest >> testAsterik [
	self parse: '*' rule: #asterik
]

{ #category : #tests }
PSQLTokenizerTest >> testBinaryBitStringConstant [
	self
		parse: 'b''''' rule: #binaryBitStringConstant;
		parse: 'b''0101''' rule: #binaryBitStringConstant	;
		parse: 'B''''' rule: #binaryBitStringConstant;
		parse: 'B''0101''' rule: #binaryBitStringConstant	
]

{ #category : #tests }
PSQLTokenizerTest >> testBitStringConstant [
	self
		parse: 'b''''' rule: #bitStringConstant;
		parse: 'b''0101''' rule: #bitStringConstant	;
		parse: 'B''''' rule: #bitStringConstant;
		parse: 'B''0101''' rule: #bitStringConstant	;
		parse: 'x''''' rule: #bitStringConstant;
		parse: 'x''1F''' rule: #bitStringConstant;
		parse: 'X''''' rule: #bitStringConstant;
		parse: 'X''1F''' rule: #bitStringConstant
]

{ #category : #tests }
PSQLTokenizerTest >> testCloseBracket [
	self parse: ']' rule: #closeBracket
]

{ #category : #tests }
PSQLTokenizerTest >> testCloseParenthesis [
	self parse: ')' rule: #closeParenthesis
]

{ #category : #tests }
PSQLTokenizerTest >> testColon [
	self parse: ':' rule: #colon
]

{ #category : #tests }
PSQLTokenizerTest >> testComma [
	self parse: ',' rule: #comma
]

{ #category : #tests }
PSQLTokenizerTest >> testComment [
	self
		parse: '-- One line comment.' rule: #comment.

	self
		parse: '/* multiline comment
 * lol
 */' rule: #comment.	
]

{ #category : #tests }
PSQLTokenizerTest >> testConstant [
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
]

{ #category : #tests }
PSQLTokenizerTest >> testDollarQuotedStringConstant [
	self
		parse: '$$Dianne''s horse$ $' rule: #dollarQuotedStringConstant;
		parse: '$SomeTag$Dianne''s horse$ SomeTag$' rule: #dollarQuotedStringConstant;
		parse: '$function$
BEGIN
    RETURN ($1 ~ $q$[\t\r\n\v\\]$ q$);
END;
$ function$' rule: #dollarQuotedStringConstant
]

{ #category : #tests-accessing }
PSQLTokenizerTest >> testDollarQuotedStringConstantCloseTag [
	self
		parse: '$ hello$' rule: #dollarQuotedStringConstantCloseTag;
		fail: '$hello$' rule: #dollarQuotedStringConstantCloseTag
]

{ #category : #tests-accessing }
PSQLTokenizerTest >> testDollarQuotedStringConstantOpenTag [
	self
		fail: '$ hello$' rule: #dollarQuotedStringConstantOpenTag;
		parse: '$hello$' rule: #dollarQuotedStringConstantOpenTag
]

{ #category : #tests-accessing }
PSQLTokenizerTest >> testEscapeStringConstant [
	self 
		parse: 'e''\\''' rule: #escapeStringConstant
]

{ #category : #tests }
PSQLTokenizerTest >> testHexBitStringConstant [
	self
		parse: 'x''''' rule: #hexBitStringConstant;
		parse: 'x''1F''' rule: #hexBitStringConstant;
		parse: 'X''''' rule: #hexBitStringConstant;
		parse: 'X''1F''' rule: #hexBitStringConstant	
]

{ #category : #tests }
PSQLTokenizerTest >> testIdentifierOrKeyword [
	self
		parse: 'select' rule: #identifierOrKeyword;
		parse: 'SELECT' rule: #identifierOrKeyword;
		parse: '_hello' rule: #identifierOrKeyword;
		parse: 'he$llo$' rule: #identifierOrKeyword;
		parse: '"quoted_identifier"' rule: #identifierOrKeyword;
		parse: 'U&"d\0061t\+000061"' rule: #identifierOrKeyword;
		parse: 'U&"\0441\043B\043E\043D"' rule: #identifierOrKeyword;
		parse: 'U&"d!0061t!+000061"' rule: #identifierOrKeyword
]

{ #category : #tests }
PSQLTokenizerTest >> testMultiLineComment [
	self
		parse: '/* multiline comment
 * lol
 */' rule: #multiLineComment
]

{ #category : #tests }
PSQLTokenizerTest >> testNestedMultiLineComment [
	self
		parse: '/* multiline comment
 * with nesting: /* nested block comment */
 */' rule: #multiLineComment
]

{ #category : #tests }
PSQLTokenizerTest >> testNumericConstant [
	self
		parse: '42' rule: #numericConstant;
		parse: '3.5' rule: #numericConstant;
		parse: '4.' rule: #numericConstant;
		parse: '.001' rule: #numericConstant;
		parse: '5e2' rule: #numericConstant;
		parse: '1.925e-3' rule: #numericConstant
]

{ #category : #tests }
PSQLTokenizerTest >> testOneLineComment [
	self
		parse: '-- This is a standard SQL comment' rule: #oneLineComment
]

{ #category : #tests }
PSQLTokenizerTest >> testOpenBracket [
	self parse: '[' rule: #openBracket
]

{ #category : #tests }
PSQLTokenizerTest >> testOpenParenthesis [
	self parse: '(' rule: #openParenthesis
]

{ #category : #tests }
PSQLTokenizerTest >> testOperator [
	self
		parse: '+' rule: #operator;
		parse: '-' rule: #operator;
		parse: '/%^/-/' rule: #operator
]

{ #category : #tests }
PSQLTokenizerTest >> testPeriod [
	self parse: '.' rule: #period
]

{ #category : #tests }
PSQLTokenizerTest >> testPositionalParameter [
	self
		parse: '$1' rule: #positionalParameter;
		parse: '$42' rule: #positionalParameter
]

{ #category : #tests }
PSQLTokenizerTest >> testQuotedIdentifier [
	self
		parse: '"select"' rule: #quotedIdentifier;
		parse: '"SELECT"' rule: #quotedIdentifier;
		parse: '"_hello"' rule: #quotedIdentifier;
		parse: '"he$llo$"' rule: #quotedIdentifier;
		parse: 'U&"d\0061t\+000061"' rule: #quotedIdentifier;
		parse: 'U&"\0441\043B\043E\043D"' rule: #quotedIdentifier;
		parse: 'U&"d!0061t!+000061"' rule: #quotedIdentifier
]

{ #category : #tests }
PSQLTokenizerTest >> testSimpleQuotedIdentifier [
	self
		parse: '"select"' rule: #simpleQuotedIdentifier;
		parse: '"SELECT"' rule: #simpleQuotedIdentifier;
		parse: '"_hello"' rule: #simpleQuotedIdentifier;
		parse: '"he$llo$"' rule: #simpleQuotedIdentifier
]

{ #category : #tests }
PSQLTokenizerTest >> testSimpleStringConstant [
	self
		parse: '''Hello you!''' rule: #simpleStringConstant;
		parse: '''Hello \''mister\''!''' rule: #simpleStringConstant
]

{ #category : #tests }
PSQLTokenizerTest >> testStringConstant [
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
$ function$' rule: #stringConstant;
		parse: '''SELECT count(*) FROM %I ''' rule: #stringConstant
]

{ #category : #tests }
PSQLTokenizerTest >> testStringConstantWithUnicodeEscape [
	self
		parse: 'U&''d\0061t\+000061''' rule: #stringConstantWithUnicodeEscape;
		parse: 'U&''\0441\043B\043E\043D''' rule: #stringConstantWithUnicodeEscape;
		parse: 'U&''d!0061t!+000061''' rule: #stringConstantWithUnicodeEscape
]

{ #category : #tests }
PSQLTokenizerTest >> testUnicodeQuotedIdentifier [
	self
		parse: 'U&"d\0061t\+000061"' rule: #unicodeQuotedIdentifier;
		parse: 'U&"\0441\043B\043E\043D"' rule: #unicodeQuotedIdentifier;
		parse: 'U&"d!0061t!+000061"' rule: #unicodeQuotedIdentifier
]
