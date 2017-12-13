"
This parser only works for strings that have been pre-processed by PSQLPreprocessor!
"
Class {
	#name : #PSQLTokenizer,
	#superclass : #PPCompositeParser,
	#instVars : [
		'whiteSpace',
		'comment',
		'oneLineComment',
		'multiLineComment',
		'identifierOrKeyword',
		'quotedIdentifier',
		'simpleQuotedIdentifier',
		'unicodeQuotedIdentifier',
		'stringConstant',
		'simpleStringConstant',
		'stringConstantWithUnicodeEscape',
		'dollarQuotedStringConstant',
		'binaryBitStringConstant',
		'hexBitStringConstant',
		'bitStringConstant',
		'numericConstant',
		'constant',
		'operator',
		'positionalParameter',
		'openParenthesis',
		'closeParenthesis',
		'openBracket',
		'closeBracket',
		'comma',
		'semicolon',
		'colon',
		'asterik',
		'period',
		'special',
		'psqlToken',
		'unquotedIdentifierOrKeyword',
		'dollarQuotedStringConstantOpenTag',
		'dollarQuotedStringConstantCloseTag',
		'tagIdentifier',
		'metaCommand',
		'kw',
		'escapeStringConstant',
		'identifier',
		'identifierWithOptionalFieldAccess'
	],
	#category : #'PostgreSQL-Parser-Core'
}

{ #category : #accessing }
PSQLTokenizer class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLTokenizer >> asterik [
	^ $* asParser
]

{ #category : #accessing }
PSQLTokenizer >> binaryBitStringConstant [
	^ ($b asParser / $B asParser) , $' asParser ,
	($0 asParser / $1 asParser) star,
	$' asParser
]

{ #category : #accessing }
PSQLTokenizer >> bitStringConstant [
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	Bit-string constants look like regular string constants with a B (upper or lower case) immediately before the opening quote (no intervening whitespace), e.g., B'1001'. The only characters allowed within bit-string constants are 0 and 1.

Alternatively, bit-string constants can be specified in hexadecimal notation, using a leading X (upper or lower case), e.g., X'1FF'. This notation is equivalent to a bit-string constant with four binary digits for each hexadecimal digit.

Both forms of bit-string constant can be continued across lines in the same way as regular string constants. Dollar quoting cannot be used in a bit-string constant."
	^ binaryBitStringConstant / hexBitStringConstant
]

{ #category : #accessing }
PSQLTokenizer >> closeBracket [
	^ $] asParser
]

{ #category : #accessing }
PSQLTokenizer >> closeParenthesis [
	^ $) asParser
]

{ #category : #accessing }
PSQLTokenizer >> colon [
	^ $: asParser
]

{ #category : #accessing }
PSQLTokenizer >> comma [
	^ $, asParser
]

{ #category : #accessing }
PSQLTokenizer >> comment [
	^ oneLineComment / multiLineComment
]

{ #category : #accessing }
PSQLTokenizer >> constant [
	^ stringConstant / numericConstant
]

{ #category : #accessing }
PSQLTokenizer >> dollarQuotedStringConstant [
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	While the standard syntax for specifying string constants is usually convenient, it can be difficult to understand when the desired string contains many single quotes or backslashes, since each of those must be doubled. To allow more readable queries in such situations, PostgreSQL provides another way, called ''dollar quoting'', to write string constants. A dollar-quoted string constant consists of a dollar sign ($), an optional ''tag'' of zero or more characters, another dollar sign, an arbitrary sequence of characters that makes up the string content, a dollar sign, the same tag that began this dollar quote, and a dollar sign."
	^ dollarQuotedStringConstantOpenTag ,
	(dollarQuotedStringConstant / positionalParameter / dollarQuotedStringConstantCloseTag negate) plus ,
	dollarQuotedStringConstantCloseTag
]

{ #category : #accessing }
PSQLTokenizer >> dollarQuotedStringConstantCloseTag [
	"There is no really close tag defined for dollar quoted strings defined in PostgreSQL spec, this kind of tag is introduced by the pre-processor."
	^ '$ ' asParser , tagIdentifier optional , $$ asParser
]

{ #category : #accessing }
PSQLTokenizer >> dollarQuotedStringConstantOpenTag [
	^ $$ asParser , tagIdentifier optional , $$ asParser
]

{ #category : #accessing }
PSQLTokenizer >> escapeStringConstant [
	^ $e asParser caseInsensitive ,  $' asParser, $' asParser negate star , $' asParser
]

{ #category : #accessing }
PSQLTokenizer >> hexBitStringConstant [
	^ ($x asParser / $X asParser) , $' asParser ,
	(#letter asParser/#digit asParser) star,
	$' asParser
]

{ #category : #helpers }
PSQLTokenizer >> identifier [
	^ kw keyword not , identifierOrKeyword
]

{ #category : #accessing }
PSQLTokenizer >> identifierOrKeyword [
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	SQL identifiers and key words must begin with a letter (a-z, but also letters with diacritical marks and non-Latin letters) or an underscore (_). Subsequent characters in an identifier or key word can be letters, underscores, digits (0-9), or dollar signs ($). Note that dollar signs are not allowed in identifiers according to the letter of the SQL standard, so their use might render applications less portable. The SQL standard will not define a key word that contains digits or starts or ends with an underscore, so identifiers of this form are safe against possible conflict with future extensions of the standard."
	^ quotedIdentifier / unquotedIdentifierOrKeyword
]

{ #category : #helpers }
PSQLTokenizer >> identifierWithOptionalFieldAccess [
	^ identifier , ($. asParser , identifier) optional
]

{ #category : #initialization }
PSQLTokenizer >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new

]

{ #category : #accessing }
PSQLTokenizer >> metaCommand [
	^ '\.' asParser / '\?' asParser / '\!' asParser / ($\ asParser , ((#letter asParser / $_ asParser) , (#letter asParser / $_ asParser / #digit asParser / $$ asParser) star))
]

{ #category : #accessing }
PSQLTokenizer >> multiLineComment [
	^ '/*' asParser , (multiLineComment / '*/' asParser negate) star , '*/' asParser
]

{ #category : #accessing }
PSQLTokenizer >> numericConstant [
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	Numeric constants are accepted in these general forms:
	digits
	digits.[digits][e[+-]digits]
	[digits].digits[e[+-]digits]
	digitse[+-]digits
"
	^
	(#digit asParser plus, $. asParser , $. asParser not , #digit asParser star , ($e asParser , ($+ asParser / $- asParser) optional , #digit asParser plus) optional) /
	(#digit asParser star , $. asParser , $. asParser not , #digit asParser plus , ($e asParser , ($+ asParser / $- asParser) optional , #digit asParser plus) optional) /
	(#digit asParser plus , $e asParser , ($+ asParser / $- asParser) optional, #digit asParser plus) /
	#digit asParser plus
]

{ #category : #accessing }
PSQLTokenizer >> oneLineComment [
	 ^ '--' asParser, #newline asParser negate star
]

{ #category : #accessing }
PSQLTokenizer >> openBracket [
	^ $[ asParser
]

{ #category : #accessing }
PSQLTokenizer >> openParenthesis [
	^ $( asParser
]

{ #category : #accessing }
PSQLTokenizer >> operator [
	^ ($+ asParser / $- asParser / $* asParser / $/ asParser / $< asParser / $> asParser / $= asParser / $~ asParser / $! asParser / $@ asParser / $# asParser / $% asParser / $^ asParser / $& asParser / $| asParser / $` asParser / $? asParser) plus
]

{ #category : #accessing }
PSQLTokenizer >> period [
	^ $. asParser
]

{ #category : #accessing }
PSQLTokenizer >> positionalParameter [
	^ $$ asParser , #digit asParser plus
]

{ #category : #accessing }
PSQLTokenizer >> psqlToken [
	^ comment / constant / metaCommand / identifierOrKeyword / special / operator
]

{ #category : #accessing }
PSQLTokenizer >> quotedIdentifier [
	^ simpleQuotedIdentifier / unicodeQuotedIdentifier
]

{ #category : #accessing }
PSQLTokenizer >> semicolon [
	^ $; asParser
]

{ #category : #accessing }
PSQLTokenizer >> simpleQuotedIdentifier [
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	There is a second kind of identifier: the delimited identifier or quoted identifier. It is formed by enclosing an arbitrary sequence of characters in double-quotes . A delimited identifier is always an identifier, never a key word. So ''select'' could be used to refer to a column or table named ''select'', whereas an unquoted select would be taken as a key word and would therefore provoke a parse error when used where a table or column name is expected"
	^
	$" asParser , 
	(#letter asParser / $_ asParser) , (#letter asParser / $_ asParser / #digit asParser / $$ asParser / '""' asParser) star ,
	$" asParser
]

{ #category : #accessing }
PSQLTokenizer >> simpleStringConstant [
	^ $' asParser, ('\''' asParser / $' asParser negate) star , $' asParser
]

{ #category : #accessing }
PSQLTokenizer >> special [
	^ positionalParameter / openParenthesis / closeParenthesis / openBracket / closeBracket / comma / semicolon / colon / asterik / period
]

{ #category : #accessing }
PSQLTokenizer >> start [
	^ (psqlToken separatedBy: whiteSpace star) end
]

{ #category : #accessing }
PSQLTokenizer >> stringConstant [
	^ escapeStringConstant / bitStringConstant / dollarQuotedStringConstant / stringConstantWithUnicodeEscape / simpleStringConstant
]

{ #category : #accessing }
PSQLTokenizer >> stringConstantWithUnicodeEscape [
	^ 'U&''' asParser , ('\''' asParser / $' asParser negate) star , $' asParser
]

{ #category : #accessing }
PSQLTokenizer >> tagIdentifier [
	^ ((#letter asParser / $_ asParser) , (#letter asParser / $_ asParser / #digit asParser) star)
]

{ #category : #accessing }
PSQLTokenizer >> unicodeQuotedIdentifier [
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	A variant of quoted identifiers allows including escaped Unicode characters identified by their code points. This variant starts with U& (upper or lower case U followed by ampersand) immediately before the opening double quote, without any spaces in between, for example U&''foo''. (Note that this creates an ambiguity with the operator &. Use spaces around the operator to avoid this problem.) Inside the quotes, Unicode characters can be specified in escaped form by writing a backslash followed by the four-digit hexadecimal code point number or alternatively a backslash followed by a plus sign followed by a six-digit hexadecimal code point number."
	^ 'U&"' asParser,
	('""' asParser / $" asParser negate) star ,
	$" asParser
]

{ #category : #accessing }
PSQLTokenizer >> unquotedIdentifierOrKeyword [
	^ ((#letter asParser / $_ asParser) , (#letter asParser / $_ asParser / #digit asParser / $$ asParser) star)
]

{ #category : #accessing }
PSQLTokenizer >> whiteSpace [
	^ #space asParser / #tab asParser / #newline asParser
]
