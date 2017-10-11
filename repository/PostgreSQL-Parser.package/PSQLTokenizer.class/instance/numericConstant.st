accessing
numericConstant
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