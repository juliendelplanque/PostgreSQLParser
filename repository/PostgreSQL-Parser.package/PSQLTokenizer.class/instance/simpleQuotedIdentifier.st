accessing
simpleQuotedIdentifier
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	There is a second kind of identifier: the delimited identifier or quoted identifier. It is formed by enclosing an arbitrary sequence of characters in double-quotes . A delimited identifier is always an identifier, never a key word. So ''select'' could be used to refer to a column or table named ''select'', whereas an unquoted select would be taken as a key word and would therefore provoke a parse error when used where a table or column name is expected"
	^
	$" asParser , 
	(#letter asParser / $_ asParser) , (#letter asParser / $_ asParser / #digit asParser / $$ asParser / '""' asParser) star ,
	$" asParser