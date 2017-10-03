accessing
dollarQuotedStringConstant
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	While the standard syntax for specifying string constants is usually convenient, it can be difficult to understand when the desired string contains many single quotes or backslashes, since each of those must be doubled. To allow more readable queries in such situations, PostgreSQL provides another way, called ''dollar quoting'', to write string constants. A dollar-quoted string constant consists of a dollar sign ($), an optional ''tag'' of zero or more characters, another dollar sign, an arbitrary sequence of characters that makes up the string content, a dollar sign, the same tag that began this dollar quote, and a dollar sign."
	^ dollarQuotedStringConstantOpenTag ,
	(dollarQuotedStringConstant / positionalParameter / dollarQuotedStringConstantCloseTag negate) plus ,
	dollarQuotedStringConstantCloseTag