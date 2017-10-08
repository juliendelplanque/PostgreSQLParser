expression
expression
	| expressionParser |
	expressionParser := PPExpressionParser new.
	"Terms definitions"
	expressionParser term: (self expressionParserTermFor: expressionParser).
	"Operators definitions"
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
			g postfix: (self subscriptWith: expressionParser) trim do: self postfixOperatorBlock.
			g postfix: (self commaSubscriptWith: expressionParser) trim do: self postfixOperatorBlock.
			g postfix: fieldSelection trim do: self postfixOperatorBlock.
			g postfix: isNullOperator trim do: self postfixOperatorBlock.
			g postfix: isNotNullOperator trim do: self postfixOperatorBlock ].
	^ expressionParser