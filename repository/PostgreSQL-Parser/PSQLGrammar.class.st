"
I parse everything I can parse from SQL code from PostgreSQL.

I should be splitted in different parsers in the future.
"
Class {
	#name : #PSQLGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'asOperator',
		'betweenConstructOperator',
		'betweenSymmetric',
		'binaryLogicalOperator',
		'booleanTestConstructOperator',
		'columnReference',
		'conditionalExpression',
		'deleteCommand',
		'extractFunctionCall',
		'fieldSelection',
		'functionCall',
		'inOperator',
		'insertCommand',
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
		'selectIntoCommand',
		'setItem1',
		'setItem2',
		'setItem3',
		'typeCast',
		'typeCastConstruct',
		'updateDeleteWhereClause',
		'updateCommand',
		'withQuery',
		'returningClause',
		'setClause',
		'selectCommand',
		'valuesCommand',
		'expression',
		'withClause',
		'orderByClause'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLGrammar class >> deleteQueryParser [
	^ PSQLDeleteQueryGrammar
]

{ #category : #accessing }
PSQLGrammar class >> dependencies [
	^ { self valuesCommandParser . self insertQueryParser . self updateQueryParser . self deleteQueryParser . self selectQueryParser }
]

{ #category : #accessing }
PSQLGrammar class >> insertQueryParser [
	^ PSQLInsertQueryGrammar
]

{ #category : #accessing }
PSQLGrammar class >> selectQueryParser [
	^ PSQLSelectQueryGrammar
]

{ #category : #accessing }
PSQLGrammar class >> updateQueryParser [
	^ PSQLUpdateQueryGrammar
]

{ #category : #accessing }
PSQLGrammar class >> valuesCommandParser [
	^ PSQLValuesGrammar
]

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserForm1With: expressionParser [
	^ identifier , 
		openParenthesis ,
		(expressionParser plus separatedBy: comma trim) trim ,
		orderByClause optional,
		closeParenthesis
]

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserForm2With: expressionParser [
	^ identifier , 
		openParenthesis ,
		(kw all / kw distinct) trim ,
		(expressionParser plus separatedBy: comma trim) trim ,
		orderByClause optional,
		closeParenthesis
]

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserForm3With: expressionParser [
	^ identifier , 
		openParenthesis ,
		asterik trim , 
		orderByClause optional,
		closeParenthesis
]

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserForm4With: expressionParse [
	self flag: #todo.
	^ PPFailingParser new
]

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserWith: expressionParser [
	^ (self aggregateExpressionParserForm1With: expressionParser) /
	(self aggregateExpressionParserForm2With: expressionParser) /
	(self aggregateExpressionParserForm3With: expressionParser) /
	(self aggregateExpressionParserForm4With: expressionParser)
]

{ #category : #expression }
PSQLGrammar >> asOperator [
	^ kw asc not , kw as
]

{ #category : #expression }
PSQLGrammar >> betweenConstructOperator [
	^ (betweenSymmetric / notBetweenSymmetric / kw between / notBetween) , keywordStop
]

{ #category : #expression }
PSQLGrammar >> betweenSymmetric [
	^ kw between trim , kw symmetric
]

{ #category : #expression }
PSQLGrammar >> binaryLogicalOperator [
	^ (kw andKeyword / kw or) , #space asParser
]

{ #category : #'accessing - blocks' }
PSQLGrammar >> binaryOperatorBlock [
	^ [ :exp1 :op :exp2 | { exp1 . op . exp2 } ]
]

{ #category : #expression }
PSQLGrammar >> booleanTestConstructOperator [
	^ (isTrue / isNotTrue / isFalse / isNotFalse / isUnknown / isNotUnknown) , keywordStop
]

{ #category : #helpers }
PSQLGrammar >> columnReference [
	^ (identifier , period) optional , identifier
]

{ #category : #expression }
PSQLGrammar >> commaSubscriptWith: expressionParser [
	^ openBracket , (expressionParser trim plus separatedBy: comma trim) , closeBracket
]

{ #category : #expression }
PSQLGrammar >> compositeValueWith: anExpressionParser [
	^ openParenthesis trim , (anExpressionParser plus separatedBy: comma trim) , closeParenthesis trim , typeCastConstruct trim optional
]

{ #category : #expression }
PSQLGrammar >> conditionalExpression [
	^ kw case trim ,
		(kw when trim , expression trim , kw then trim , expression trim) plus,
		(kw else trim , expression trim) optional ,
	kw endKeyword trim
]

{ #category : #dependencies }
PSQLGrammar >> deleteCommand [
	^ (self dependencyAt: self class deleteQueryParser) deleteCommand
]

{ #category : #expression }
PSQLGrammar >> expression [
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
PSQLGrammar >> expressionParserTermFor: expressionParser [
	| parenthesedExpression functionCall aggregateExpression compositeValue |
	parenthesedExpression := self parenthesedExpressionParserWith: expressionParser.
	functionCall := self functionCallParserWith: expressionParser.
	aggregateExpression := self aggregateExpressionParserWith: expressionParser.
	compositeValue := self compositeValueWith: expressionParser.
	^ (parenthesedExpression / nullExpression / compositeValue / conditionalExpression / aggregateExpression / extractFunctionCall / functionCall / primary / selectCommand) , typeCastConstruct optional.
]

{ #category : #expression }
PSQLGrammar >> extractFunctionCall [
	"Parses a call to the EXTRACT(x FROM y) function."
	^ identifier trim , openParenthesis trim , expression trim , kw from trim , expression trim , closeParenthesis
]

{ #category : #expression }
PSQLGrammar >> fieldSelection [
	^ period , (identifier / asterik)
]

{ #category : #expression }
PSQLGrammar >> functionCall [
	"Only for function call with argument list (does not support argument dict)."
	^ identifier trim ,
		openParenthesis trim,
		(expression separatedBy: comma trim) optional, "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim
]

{ #category : #expression }
PSQLGrammar >> functionCallParserWith: expressionParser [
	^ identifier , (openParenthesis trim , 
		(((identifier , ':=' asParser trim , expressionParser) trim / expressionParser trim) star separatedBy: comma trim) , 
		closeParenthesis trim)
]

{ #category : #expression }
PSQLGrammar >> inOperator [
	^ kw into trim not , kw in trim , keywordStop
]

{ #category : #dependencies }
PSQLGrammar >> insertCommand [
	^ (self dependencyAt: self class insertQueryParser) insertCommand
]

{ #category : #expression }
PSQLGrammar >> isDistinctFromOperator [
	^ kw is trim , kw distinct trim , kw from , keywordStop
]

{ #category : #expression }
PSQLGrammar >> isFalse [
	^ kw is trim , kw falseKeyword
]

{ #category : #expression }
PSQLGrammar >> isNotDistinctFromOperator [
	^ kw is trim , kw notKeyword trim , kw distinct trim , kw from , keywordStop
]

{ #category : #expression }
PSQLGrammar >> isNotFalse [
	^ kw is trim , kw notKeyword trim , kw falseKeyword
]

{ #category : #expression }
PSQLGrammar >> isNotNull [
	^ kw is trim , kw notKeyword trim , kw null
]

{ #category : #expression }
PSQLGrammar >> isNotTrue [
	^ kw is trim , kw notKeyword trim , kw trueKeyword
]

{ #category : #expression }
PSQLGrammar >> isNotUnknown [
	^ kw is trim , kw notKeyword trim , kw unknown
]

{ #category : #expression }
PSQLGrammar >> isNull [
	^ kw is trim , kw null
]

{ #category : #expression }
PSQLGrammar >> isTrue [
	^ kw is trim , kw trueKeyword
]

{ #category : #expression }
PSQLGrammar >> isUnknown [
	^ kw is trim , kw unknown
]

{ #category : #helpers }
PSQLGrammar >> keywordStop [
	^ (#space asParser / openBracket / closeBracket / openParenthesis / closeParenthesis / nil asParser) not not
]

{ #category : #expression }
PSQLGrammar >> nonStandardIsNull [
	^ kw isnull
]

{ #category : #expression }
PSQLGrammar >> nonStandardNotNull [
	^ kw notnull
]

{ #category : #expression }
PSQLGrammar >> notBetween [
	^ kw notKeyword trim, kw between
]

{ #category : #expression }
PSQLGrammar >> notBetweenSymmetric [
	^ kw notKeyword trim, kw between trim , kw symmetric
]

{ #category : #expression }
PSQLGrammar >> notInOperator [
	^ kw notKeyword trim , kw in
]

{ #category : #expression }
PSQLGrammar >> nullExpression [
	^ kw null
]

{ #category : #expression }
PSQLGrammar >> nullTestConstructOperator [
	^ (isNull / isNotNull / nonStandardIsNull / nonStandardNotNull) , keywordStop
]

{ #category : #shared }
PSQLGrammar >> orderByClause [
	^ kw order trim , kw by trim ,
		((expression ,
		(kw asc / kw desc) trim optional,
		(kw nulls , (kw first / kw last) trim) trim optional) plus separatedBy: comma trim)
]

{ #category : #expression }
PSQLGrammar >> parenthesedExpressionParserWith: expressionParser [
	^ openParenthesis trim , expressionParser , closeParenthesis trim.
]

{ #category : #'accessing - blocks' }
PSQLGrammar >> postfixOperatorBlock [
	^ [ :op :exp | { op . exp } ]
]

{ #category : #'accessing - blocks' }
PSQLGrammar >> prefixOperatorBlock [
	^ [ :op :exp | { op . exp } ]
]

{ #category : #helpers }
PSQLGrammar >> primary [
	^ constant / columnReference / positionalParameter
]

{ #category : #shared }
PSQLGrammar >> returningClause [
	"RETURNING * | output_expression [ [ AS ] output_name ] [, ...]"
	
	^ kw returning trim ,
		((asterik / (expression trim , (kw as trim optional , identifier) optional)) plus separatedBy: comma trim)
]

{ #category : #dependencies }
PSQLGrammar >> selectCommand [
	^ (self dependencyAt: self class selectQueryParser) selectCommand
]

{ #category : #dependencies }
PSQLGrammar >> selectIntoCommand [
	^ (self dependencyAt: self class selectQueryParser) selectIntoCommand
]

{ #category : #'shared - set clause' }
PSQLGrammar >> setClause [
	"SET { column_name = { expression | DEFAULT } |
                    ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
                    ( column_name [, ...] ) = ( sub-SELECT )
                  } [, ...]"
	^ kw set trim ,
	((setItem1 / setItem2 / setItem3) plus separatedBy: comma trim)
]

{ #category : #'shared - set clause' }
PSQLGrammar >> setItem1 [
	"column_name = { expression | DEFAULT }"
	^ identifier trim , $= asParser trim , (kw default / expression)
]

{ #category : #'shared - set clause' }
PSQLGrammar >> setItem2 [
	"( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] )"
	^ openParenthesis trim , (identifier plus separatedBy: comma trim) trim , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , ((kw default / expression) plus separatedBy: comma trim) , closeParenthesis
]

{ #category : #'shared - set clause' }
PSQLGrammar >> setItem3 [
	"( column_name [, ...] ) = ( sub-SELECT )"
	^ openParenthesis trim , (identifier plus separatedBy: comma trim) , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , selectCommand trim , closeParenthesis trim
]

{ #category : #expression }
PSQLGrammar >> subscriptWith: expressionParser [
	^ openBracket , expressionParser , (colon , expressionParser) optional , closeBracket
]

{ #category : #expression }
PSQLGrammar >> typeCast [
	^ '::' asParser
]

{ #category : #expression }
PSQLGrammar >> typeCastConstruct [
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

{ #category : #dependencies }
PSQLGrammar >> updateCommand [
	^ (self dependencyAt: self class updateQueryParser) updateCommand
]

{ #category : #shared }
PSQLGrammar >> updateDeleteWhereClause [
	"WHERE condition | WHERE CURRENT OF cursor_name"
	^ kw whereKeyword trim , ((kw current trim , kw of trim , identifier) / expression)
]

{ #category : #dependencies }
PSQLGrammar >> valuesCommand [
	^ (self dependencyAt: self class valuesCommandParser) valuesCommand
]

{ #category : #shared }
PSQLGrammar >> withClause [
	^ kw with trim , kw recursive trim optional , (withQuery separatedBy: comma trim)
]

{ #category : #shared }
PSQLGrammar >> withQuery [
	^ identifier trim ,
	  		(openParenthesis trim ,
			(identifier separatedBy: comma trim ) ,
			closeParenthesis trim) optional ,
	  kw as trim ,
	  openParenthesis trim ,
	  (selectCommand / insertCommand / updateCommand / deleteCommand) ,
	  closeParenthesis trim
]
