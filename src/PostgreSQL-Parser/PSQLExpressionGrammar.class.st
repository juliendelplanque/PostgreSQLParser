"
I parse PostgreSQL expressions.
"
Class {
	#name : #PSQLExpressionGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'asOperator',
		'betweenConstructOperator',
		'betweenSymmetric',
		'binaryLogicalOperator',
		'booleanTestConstructOperator',
		'columnReference',
		'conditionalExpression',
		'extractFunctionCall',
		'fieldSelection',
		'functionCall',
		'inOperator',
		'isDistinctFromOperator',
		'isFalse',
		'isNotDistinctFromOperator',
		'isNotFalse',
		'isNotNull',
		'isNotTrue',
		'isNotUnknown',
		'isNull',
		'isTrue',
		'isUnknown',
		'keywordStop',
		'nonStandardIsNull',
		'nonStandardNotNull',
		'notBetween',
		'notBetweenSymmetric',
		'notInOperator',
		'nullExpression',
		'nullTestConstructOperator',
		'primary',
		'typeCast',
		'typeCastConstruct',
		'selectCommand',
		'expression',
		'orderByClause',
		'identifier',
		'openParenthesis',
		'comma',
		'closeParenthesis',
		'kw',
		'asterik',
		'openBracket',
		'closeBracket',
		'operator',
		'period',
		'colon',
		'identifierOrKeyword',
		'constant',
		'positionalParameter',
		'whenExpression'
	],
	#category : #'PostgreSQL-Parser-Core'
}

{ #category : #accessing }
PSQLExpressionGrammar class >> dependencies [
	^ { self selectQueryParser . self sharedParser . self tokenParser }
]

{ #category : #example }
PSQLExpressionGrammar class >> example [
	^ self parse: 'fct(x) + id--'
]

{ #category : #accessing }
PSQLExpressionGrammar class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLExpressionGrammar class >> selectQueryParser [
	^ PSQLSelectQueryGrammar
]

{ #category : #accessing }
PSQLExpressionGrammar class >> sharedParser [
	^ PSQLSharedGrammar
]

{ #category : #accessing }
PSQLExpressionGrammar class >> tokenParser [
	^ PSQLTokenizer
]

{ #category : #expression }
PSQLExpressionGrammar >> aggregateExpressionParserForm1With: expressionParser [
	^ identifier , 
		openParenthesis ,
		(expressionParser plus separatedBy: comma trim) trim ,
		orderByClause optional,
		closeParenthesis
]

{ #category : #expression }
PSQLExpressionGrammar >> aggregateExpressionParserForm2With: expressionParser [
	^ identifier , 
		openParenthesis ,
		(kw all / kw distinct) trim ,
		(expressionParser plus separatedBy: comma trim) trim ,
		orderByClause optional,
		closeParenthesis
]

{ #category : #expression }
PSQLExpressionGrammar >> aggregateExpressionParserForm3With: expressionParser [
	^ identifier , 
		openParenthesis ,
		asterik trim , 
		orderByClause optional,
		closeParenthesis
]

{ #category : #expression }
PSQLExpressionGrammar >> aggregateExpressionParserForm4With: expressionParse [
	self flag: #todo.
	^ PPFailingParser new
]

{ #category : #expression }
PSQLExpressionGrammar >> aggregateExpressionParserWith: expressionParser [
	^ (self aggregateExpressionParserForm1With: expressionParser) /
	(self aggregateExpressionParserForm2With: expressionParser) /
	(self aggregateExpressionParserForm3With: expressionParser) /
	(self aggregateExpressionParserForm4With: expressionParser)
]

{ #category : #expression }
PSQLExpressionGrammar >> asOperator [
	^ kw asc not , kw as
]

{ #category : #dependencies }
PSQLExpressionGrammar >> asterik [
	^ (self dependencyAt: self class tokenParser) asterik
]

{ #category : #expression }
PSQLExpressionGrammar >> betweenConstructOperator [
	^ (betweenSymmetric / notBetweenSymmetric / kw between / notBetween) , keywordStop
]

{ #category : #expression }
PSQLExpressionGrammar >> betweenSymmetric [
	^ kw between trim , kw symmetric
]

{ #category : #expression }
PSQLExpressionGrammar >> binaryLogicalOperator [
	^ (kw andKeyword / kw or) , #space asParser
]

{ #category : #'accessing - blocks' }
PSQLExpressionGrammar >> binaryOperatorBlock [
	^ [ :exp1 :op :exp2 | { exp1 . op . exp2 } ]
]

{ #category : #expression }
PSQLExpressionGrammar >> booleanTestConstructOperator [
	^ (isTrue / isNotTrue / isFalse / isNotFalse / isUnknown / isNotUnknown) , keywordStop
]

{ #category : #dependencies }
PSQLExpressionGrammar >> closeBracket [
	^ (self dependencyAt: self class tokenParser) closeBracket
]

{ #category : #dependencies }
PSQLExpressionGrammar >> closeParenthesis [
	^ (self dependencyAt: self class tokenParser) closeParenthesis
]

{ #category : #dependencies }
PSQLExpressionGrammar >> colon [
	^ (self dependencyAt: self class tokenParser) colon
]

{ #category : #helpers }
PSQLExpressionGrammar >> columnReference [
	^ (identifier , period) optional , identifier
]

{ #category : #dependencies }
PSQLExpressionGrammar >> comma [
	^ (self dependencyAt: self class tokenParser) comma
]

{ #category : #expression }
PSQLExpressionGrammar >> commaSubscriptWith: expressionParser [
	^ openBracket , (expressionParser trim plus separatedBy: comma trim) , closeBracket
]

{ #category : #expression }
PSQLExpressionGrammar >> compositeValueWith: anExpressionParser [
	^ openParenthesis trim , (anExpressionParser plus separatedBy: comma trim) , closeParenthesis trim , typeCastConstruct trim optional
]

{ #category : #expression }
PSQLExpressionGrammar >> conditionalExpression [
	^ kw case trim ,
		(whenExpression , kw then trim , expression trim) plus,
		(kw else trim , expression trim) optional ,
	kw endKeyword trim
]

{ #category : #dependencies }
PSQLExpressionGrammar >> constant [
	^ (self dependencyAt: self class tokenParser) constant
]

{ #category : #expression }
PSQLExpressionGrammar >> expression [
	| expressionParser |
	expressionParser := PPExpressionParser new.
	"Terms definitions"
	expressionParser term: (self expressionParserTermFor: expressionParser).
	"Operators definitions"
	expressionParser
		group: [ :g |
			g prefix: operator trim do: self prefixOperatorBlock.
			g prefix: kw notKeyword trim do: self prefixOperatorBlock.
			g prefix: kw any trim do: self prefixOperatorBlock.
			g prefix: kw distinct trim do: self prefixOperatorBlock.
			g postfix: nullTestConstructOperator trim do: self postfixOperatorBlock.
			g postfix: booleanTestConstructOperator trim do: self postfixOperatorBlock.
			g postfix: (self subscriptWith: expressionParser) trim do: self postfixOperatorBlock.
			g postfix: (self commaSubscriptWith: expressionParser) trim do: self postfixOperatorBlock.
			g postfix: fieldSelection trim do: self postfixOperatorBlock.
			g postfix: typeCastConstruct trim do: self postfixOperatorBlock. ];
		group: [ :g | g left: operator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: inOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: notInOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: isDistinctFromOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: isNotDistinctFromOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: betweenConstructOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: binaryLogicalOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: asOperator trim do: self binaryOperatorBlock ];
		group: [ :g |
			g postfix: operator trim do: self postfixOperatorBlock ].
	^ expressionParser
]

{ #category : #expression }
PSQLExpressionGrammar >> expressionParserTermFor: expressionParser [
	| parenthesedExpression functionCallTemp aggregateExpression compositeValue |
	parenthesedExpression := self parenthesedExpressionParserWith: expressionParser.
	functionCallTemp := self functionCallParserWith: expressionParser.
	aggregateExpression := self aggregateExpressionParserWith: expressionParser.
	compositeValue := self compositeValueWith: expressionParser.
	^ (parenthesedExpression / nullExpression / compositeValue / conditionalExpression / aggregateExpression / extractFunctionCall / functionCallTemp / primary / selectCommand) , typeCastConstruct optional.
]

{ #category : #expression }
PSQLExpressionGrammar >> extractFunctionCall [
	"Parses a call to the EXTRACT(x FROM y) function."
	^ identifier trim , openParenthesis trim , expression trim , kw from trim , expression trim , closeParenthesis
]

{ #category : #expression }
PSQLExpressionGrammar >> fieldSelection [
	^ period , (identifier / asterik)
]

{ #category : #expression }
PSQLExpressionGrammar >> functionCall [
	"Only for function call with argument list (does not support argument dict)."
	^ identifier trim ,
		openParenthesis trim,
		(expression separatedBy: comma trim) optional, "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim
]

{ #category : #expression }
PSQLExpressionGrammar >> functionCallParserWith: expressionParser [
	^ identifier , (openParenthesis trim , 
		(((identifier , ':=' asParser trim , expressionParser) trim / expressionParser trim) star separatedBy: comma trim) , 
		closeParenthesis trim)
]

{ #category : #dependencies }
PSQLExpressionGrammar >> identifier [
	^ (self dependencyAt: self class tokenParser) identifier
]

{ #category : #dependencies }
PSQLExpressionGrammar >> identifierOrKeyword [
	^ (self dependencyAt: self class tokenParser) identifierOrKeyword
]

{ #category : #dependencies }
PSQLExpressionGrammar >> identifierWithOptionalFieldAccess [
	^ (self dependencyAt: self class tokenParser) identifierWithOptionalFieldAccess
]

{ #category : #expression }
PSQLExpressionGrammar >> inOperator [
	^ kw into trim not , kw in trim , keywordStop
]

{ #category : #initialization }
PSQLExpressionGrammar >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new

]

{ #category : #expression }
PSQLExpressionGrammar >> isDistinctFromOperator [
	^ kw is trim , kw distinct trim , kw from , keywordStop
]

{ #category : #expression }
PSQLExpressionGrammar >> isFalse [
	^ kw is trim , kw falseKeyword
]

{ #category : #expression }
PSQLExpressionGrammar >> isNotDistinctFromOperator [
	^ kw is trim , kw notKeyword trim , kw distinct trim , kw from , keywordStop
]

{ #category : #expression }
PSQLExpressionGrammar >> isNotFalse [
	^ kw is trim , kw notKeyword trim , kw falseKeyword
]

{ #category : #expression }
PSQLExpressionGrammar >> isNotNull [
	^ kw is trim , kw notKeyword trim , kw null
]

{ #category : #expression }
PSQLExpressionGrammar >> isNotTrue [
	^ kw is trim , kw notKeyword trim , kw trueKeyword
]

{ #category : #expression }
PSQLExpressionGrammar >> isNotUnknown [
	^ kw is trim , kw notKeyword trim , kw unknown
]

{ #category : #expression }
PSQLExpressionGrammar >> isNull [
	^ kw is trim , kw null
]

{ #category : #expression }
PSQLExpressionGrammar >> isTrue [
	^ kw is trim , kw trueKeyword
]

{ #category : #expression }
PSQLExpressionGrammar >> isUnknown [
	^ kw is trim , kw unknown
]

{ #category : #helpers }
PSQLExpressionGrammar >> keywordStop [
	^ (#space asParser / openBracket / closeBracket / openParenthesis / closeParenthesis / nil asParser) not not
]

{ #category : #expression }
PSQLExpressionGrammar >> nonStandardIsNull [
	^ kw isnull
]

{ #category : #expression }
PSQLExpressionGrammar >> nonStandardNotNull [
	^ kw notnull
]

{ #category : #expression }
PSQLExpressionGrammar >> notBetween [
	^ kw notKeyword trim, kw between
]

{ #category : #expression }
PSQLExpressionGrammar >> notBetweenSymmetric [
	^ kw notKeyword trim, kw between trim , kw symmetric
]

{ #category : #expression }
PSQLExpressionGrammar >> notInOperator [
	^ kw notKeyword trim , kw in
]

{ #category : #expression }
PSQLExpressionGrammar >> nullExpression [
	^ kw null
]

{ #category : #expression }
PSQLExpressionGrammar >> nullTestConstructOperator [
	^ (isNull / isNotNull / nonStandardIsNull / nonStandardNotNull) , keywordStop
]

{ #category : #dependencies }
PSQLExpressionGrammar >> numericConstant [
	^ (self dependencyAt: self class tokenParser) numericConstant
]

{ #category : #dependencies }
PSQLExpressionGrammar >> openBracket [
	^ (self dependencyAt: self class tokenParser) openBracket
]

{ #category : #dependencies }
PSQLExpressionGrammar >> openParenthesis [
	^ (self dependencyAt: self class tokenParser) openParenthesis
]

{ #category : #dependencies }
PSQLExpressionGrammar >> operator [
	^ (self dependencyAt: self class tokenParser) operator
]

{ #category : #dependencies }
PSQLExpressionGrammar >> orderByClause [
	^ (self dependencyAt: self class sharedParser) orderByClause
]

{ #category : #expression }
PSQLExpressionGrammar >> parenthesedExpressionParserWith: expressionParser [
	^ openParenthesis trim , expressionParser , closeParenthesis trim.
]

{ #category : #dependencies }
PSQLExpressionGrammar >> period [
	^ (self dependencyAt: self class tokenParser) period
]

{ #category : #dependencies }
PSQLExpressionGrammar >> positionalParameter [
	^ (self dependencyAt: self class tokenParser) positionalParameter
]

{ #category : #'accessing - blocks' }
PSQLExpressionGrammar >> postfixOperatorBlock [
	^ [ :op :exp | { op . exp } ]
]

{ #category : #'accessing - blocks' }
PSQLExpressionGrammar >> prefixOperatorBlock [
	^ [ :op :exp | { op . exp } ]
]

{ #category : #helpers }
PSQLExpressionGrammar >> primary [
	^ constant / columnReference / positionalParameter
]

{ #category : #dependencies }
PSQLExpressionGrammar >> selectCommand [
	^ (self dependencyAt: self class selectQueryParser) selectCommand
]

{ #category : #dependencies }
PSQLExpressionGrammar >> simpleStringConstant [
	^ (self dependencyAt: self class tokenParser) simpleStringConstant
]

{ #category : #accessing }
PSQLExpressionGrammar >> start [
	^ expression end
]

{ #category : #expression }
PSQLExpressionGrammar >> subscriptWith: expressionParser [
	^ openBracket , expressionParser , (colon , expressionParser) optional , closeBracket
]

{ #category : #expression }
PSQLExpressionGrammar >> typeCast [
	^ '::' asParser
]

{ #category : #expression }
PSQLExpressionGrammar >> typeCastConstruct [
	^ typeCast trim , 
			((
			kw else not , 
			kw case not , 
			kw endKeyword not , 
			kw andKeyword not , 
			kw or not , 
			kw then not,
			identifierOrKeyword , (openParenthesis trim , (constant separatedBy: comma trim) , closeParenthesis trim) optional
			) plus separatedBy: #space asParser plus).
]

{ #category : #expression }
PSQLExpressionGrammar >> whenExpression [
	^ kw when trim , expression trim
]
