accessing
unicodeQuotedIdentifier
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	A variant of quoted identifiers allows including escaped Unicode characters identified by their code points. This variant starts with U& (upper or lower case U followed by ampersand) immediately before the opening double quote, without any spaces in between, for example U&''foo''. (Note that this creates an ambiguity with the operator &. Use spaces around the operator to avoid this problem.) Inside the quotes, Unicode characters can be specified in escaped form by writing a backslash followed by the four-digit hexadecimal code point number or alternatively a backslash followed by a plus sign followed by a six-digit hexadecimal code point number."
	^ 'U&"' asParser,
	('""' asParser / $" asParser negate) star ,
	$" asParser