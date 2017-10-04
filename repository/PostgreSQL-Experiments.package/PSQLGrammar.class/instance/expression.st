accessing
expression
	| expressionParser parenthesedExpression fieldSelection functionCall subscript aggregateExpression |
	expressionParser := PPExpressionParser new.
	"Terms definitions"
	parenthesedExpression := openParenthesis trim , expressionParser , closeParenthesis trim.
	functionCall := functionName , (openParenthesis , 
		(((functionParameterName , ':=' asParser trim , expressionParser) / expressionParser) star separatedBy: comma trim) , 
		closeParenthesis).
	aggregateExpression := aggregateName , (openParenthesis ,
		(asterik /
		 ((all / distinct) optional,
		 (expressionParser plus separatedBy: comma trim) , orderByClause )),
	closeParenthesis).
	expressionParser term: parenthesedExpression / aggregateExpression / functionCall / primary.
	"Operators definitions"
	subscript := openBracket , expressionParser , (colon , expressionParser) optional , closeBracket.
	fieldSelection := period , (identifier / asterik).
	expressionParser
		group: [ :g |
			g left: operator trim do: [ :a :op :b | { a . op . b } ] ];
		group: [ :g |
			g prefix: operator trim do: [ :op :a | { op . a } ].
			g postfix: operator trim do: [ :a :op | { a . op } ].
			g postfix: subscript trim do: [ :a :op | { a . op } ].
			g postfix: fieldSelection trim do: [ :a :op | { a . op } ] ].
	^ expressionParser