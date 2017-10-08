accessing
expression
	| expressionParser subscript commaSubscript |
	expressionParser := PPExpressionParser new.
	"Terms definitions"
	expressionParser term: (self expressionParserTermFor: expressionParser).
	"Operators definitions"
	subscript := openBracket , expressionParser , (colon , expressionParser) optional , closeBracket.
	commaSubscript := openBracket , (expressionParser trim plus separatedBy: comma trim) , closeBracket.
	expressionParser
		group: [ :g |
			g prefix: operator trim do: self prefixOperatorBlock.
			g prefix: notKeyword trim do: self prefixOperatorBlock.
			g prefix: any trim do: self prefixOperatorBlock ];
		group: [ :g | g left: operator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: in trim do: self binaryOperatorBlock ];
		group: [ :g | g left: binaryLogicalOperator trim do: self binaryOperatorBlock ];
		group: [ :g |
			g postfix: operator trim do: self postfixOperatorBlock.
			g postfix: subscript trim do: self postfixOperatorBlock.
			g postfix: commaSubscript trim do: self postfixOperatorBlock.
			g postfix: fieldSelection trim do: self postfixOperatorBlock.
			g postfix: (isNull , endKeyword optional) trim do: self postfixOperatorBlock.
			g postfix: (isNotNull , endKeyword optional) trim do: self postfixOperatorBlock ].
	^ expressionParser