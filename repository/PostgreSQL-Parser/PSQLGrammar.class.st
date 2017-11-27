"
I parse everything I can parse from SQL code from PostgreSQL.

I should be splitted in different parsers in the future.
"
Class {
	#name : #PSQLGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'aggregateName',
		'alias',
		'allOrDistinctClause',
		'asOperator',
		'betweenConstructOperator',
		'betweenSymmetric',
		'binaryLogicalOperator',
		'booleanTestConstructOperator',
		'columnAlias',
		'columnDefinition',
		'columnName',
		'columnReference',
		'columnsAndAliasesSelected',
		'conditionalExpression',
		'correlation',
		'createViewCommand',
		'deleteCommand',
		'extractFunctionCall',
		'fetchClause',
		'fieldSelection',
		'forClause',
		'fromClause',
		'fromItems',
		'fromItems1',
		'fromItems2',
		'fromItems3',
		'fromItems4',
		'fromItems5',
		'fromItems6',
		'fromItems7',
		'functionCall',
		'functionName',
		'functionParameterName',
		'groupByClause',
		'havingClause',
		'inOperator',
		'insertCommand',
		'intoClause',
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
		'joinType',
		'keywordStop',
		'limitClause',
		'nonStandardIsNull',
		'nonStandardNotNull',
		'notBetween',
		'notBetweenSymmetric',
		'notInOperator',
		'nullExpression',
		'nullTestConstructOperator',
		'offsetClause',
		'orderByClause',
		'parenthesedFromItems',
		'primary',
		'queryName',
		'selectIntoCommand',
		'selectIntoCommandAlternative',
		'selectIntoCommandClassic',
		'setItem1',
		'setItem2',
		'setItem3',
		'tableName',
		'typeCast',
		'typeCastConstruct',
		'unionIntersectExceptClause',
		'updateCommand',
		'updateDeleteWhereClause',
		'usingClause',
		'whereClause',
		'windowClause',
		'withQuery',
		'setClause',
		'expression',
		'withClause',
		'selectCommand',
		'returningClause',
		'valuesCommand'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLGrammar class >> dependencies [
	^ { self valuesCommandParser . self insertQueryParser . self updateQueryParser }
]

{ #category : #accessing }
PSQLGrammar class >> insertQueryParser [
	^ PSQLInsertQueryGrammar
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
	^ aggregateName , 
		openParenthesis ,
		(expressionParser plus separatedBy: comma trim) trim ,
		orderByClause optional,
		closeParenthesis
]

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserForm2With: expressionParser [
	^ aggregateName , 
		openParenthesis ,
		(kw all / kw distinct) trim ,
		(expressionParser plus separatedBy: comma trim) trim ,
		orderByClause optional,
		closeParenthesis
]

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserForm3With: expressionParser [
	^ aggregateName , 
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

{ #category : #accessing }
PSQLGrammar >> aggregateName [
	^ identifier
]

{ #category : #helpers }
PSQLGrammar >> alias [
	^ identifier
]

{ #category : #'select command' }
PSQLGrammar >> allOrDistinctClause [
	"ALL | DISTINCT [ ON ( expression [, ...] ) ]"
	^ kw all trim /
	(kw distinct trim , 
		(kw on trim ,
			openParenthesis trim ,
			(expression plus separatedBy: comma trim) ,
			closeParenthesis trim
		) optional
	)
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
PSQLGrammar >> columnAlias [
	^ identifier
]

{ #category : #shared }
PSQLGrammar >> columnDefinition [
	^ columnReference trim , (identifier plus separatedBy: #space asParser plus)
]

{ #category : #accessing }
PSQLGrammar >> columnName [
	^ identifier
]

{ #category : #accessing }
PSQLGrammar >> columnReference [
	^ (correlation , period) optional , columnName
]

{ #category : #'select command' }
PSQLGrammar >> columnsAndAliasesSelected [
	^ (
			((identifier , $. asParser) optional , asterik trim) / expression
		) plus separatedBy: comma trim
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

{ #category : #accessing }
PSQLGrammar >> correlation [
	^ identifier
]

{ #category : #accessing }
PSQLGrammar >> createViewCommand [
	"CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] VIEW name [ ( column_name [, ...] ) ]
    [ WITH ( kw view_option_name [= kw view_option_value] [, ... ] ) ]
    AS query"
	^ kw create trim ,
		(kw or trim , kw replace) trim optional ,
		(kw temporary / kw temp) trim optional ,
		kw view trim ,
		identifier trim , 
		(openParenthesis trim ,
			(columnName plus separatedBy: comma trim) ,
		closeParenthesis trim) trim optional ,
		(kw with trim , openParenthesis trim ,
			((identifierOrKeyword trim , ($= asParser trim , identifierOrKeyword trim) optional ) plus separatedBy: comma trim) , 
		closeParenthesis trim) trim optional ,
		kw as trim ,
		selectCommand trim
]

{ #category : #'delete command' }
PSQLGrammar >> deleteCommand [
	"https://www.postgresql.org/docs/9.6/static/sql-delete.html
	[ WITH [ RECURSIVE ] with_query [, ...] ]
		DELETE FROM [ ONLY ] table_name [ * ] [ [ AS ] alias ]
   		[ USING using_list ]
    	[ WHERE condition | WHERE CURRENT OF cursor_name ]
    	[ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]"
	^ withClause trim optional ,
	kw delete trim , kw from trim , kw only trim optional , identifierWithOptionalFieldAccess trim , asterik trim optional , (kw as trim optional , identifier) optional ,
		usingClause optional ,
		updateDeleteWhereClause trim optional ,
		returningClause trim optional
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

{ #category : #'select command' }
PSQLGrammar >> fetchClause [
	^ kw fetch trim , (kw first trim / kw next trim) , numericConstant trim optional , (kw rows trim / kw row trim) , kw only trim
]

{ #category : #expression }
PSQLGrammar >> fieldSelection [
	^ period , (identifier / asterik)
]

{ #category : #'select command' }
PSQLGrammar >> forClause [
	^ kw for trim , (kw update trim / kw share trim) , (kw of trim , (expression plus separatedBy: comma trim)) optional , kw nowait trim optional
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromClause [
	^ kw from trim , (fromItems plus separatedBy: comma trim)
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromItems [
	"Have a look at #fromItems6 if you wonder why #fromItems6 is not treated as the others.
	
	[ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
                [ TABLESAMPLE sampling_method ( argument [, ...] ) [ REPEATABLE ( seed ) ] ] <- #fromItems1
    [ LATERAL ] ( select ) [ AS ] alias [ ( column_alias [, ...] ) ] <- #fromItems2
    with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ] <- #fromItems3
    [ LATERAL ] function_name ( [ argument [, ...] ] )
                [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ] <- #fromItems 7
    [ LATERAL ] function_name ( [ argument [, ...] ] ) [ AS ] alias ( column_definition [, ...] ) <- #fromItems4
    [ LATERAL ] function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] ) <- #fromItems5
    [ LATERAL ] ROWS FROM( function_name ( [ argument [, ...] ] ) [ AS ( column_definition [, ...] ) ] [, ...] )
                [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ] <- This is not implemented yet
    from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ] <- #fromItems6"
	^ (parenthesedFromItems / ( fromItems4 / fromItems5 / fromItems7 / fromItems1 / fromItems2 / fromItems3)) , fromItems6 star
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromItems1 [
	"[ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
                [ TABLESAMPLE sampling_method ( argument [, ...] ) [ REPEATABLE ( seed ) ] ]"
	self flag: 'Not fully implemented'.
	^ kw only trim optional ,
			identifierWithOptionalFieldAccess trim , asterik trim optional ,
				(kw as trim optional , identifier trim ,
					(openParenthesis trim ,
					(identifier separatedBy: comma trim),
					closeParenthesis trim) optional) optional
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromItems2 [
	"This should be implemented as:
		[ LATERAL ] ( select ) [ AS ] alias [ ( column_alias [, ...] ) ]
	But is implemented as:
		[ LATERAL ] ( values | select ) [ AS ] alias [ ( column_alias [, ...] ) ]
	since using a VALUES query is just like if a select query is used except
	that the results are defined directly in the query."
	^ kw lateral trim optional ,
		openParenthesis trim , (valuesCommand / selectCommand) , closeParenthesis trim , kw as trim optional ,
			identifier trim ,
			(openParenthesis trim,
			 (identifier separatedBy: comma trim),
			 closeParenthesis trim) optional
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromItems3 [
	"with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ identifier trim , (
			kw as trim optional , identifier trim , 
			(openParenthesis trim,
			(identifier separatedBy: comma trim),
			closeParenthesis trim) optional) optional
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromItems4 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) [ AS ] alias ( column_definition [, ...] )"
	^ kw lateral trim optional , 
		functionCall trim ,
		kw as trim optional ,
		identifier trim,
		openParenthesis trim ,
			(columnDefinition plus separatedBy: comma trim),
		closeParenthesis trim
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromItems5 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )"
	^ kw lateral trim optional , 
		functionCall trim ,
		kw as trim ,
		openParenthesis trim ,
			(columnDefinition plus separatedBy: comma trim),
		closeParenthesis trim
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromItems6 [
	"from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	Normally it should behaves as precedently described ^ BUT, because of recursivity problems, it is defined here as:
	
	[ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	and the 'from_item' is managed in #fromItems parser."
	
	^ kw natural trim optional , joinType trim , fromItems trim , 
		((kw on trim , expression) / 
		(kw using trim ,
			openParenthesis trim , 
			(columnReference plus separatedBy: comma trim),
			closeParenthesis trim)) optional
]

{ #category : #'shared - from clause' }
PSQLGrammar >> fromItems7 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ kw lateral trim optional , 
		functionCall trim ,
		(kw with trim , kw ordinality trim) optional ,
		(kw as trim optional ,
		identifier trim,
		(openParenthesis trim ,
			(identifier plus separatedBy: comma trim),
		closeParenthesis trim) optional ) optional
]

{ #category : #expression }
PSQLGrammar >> functionCall [
	"Only for function call with argument list (does not support argument dict)."
	^ functionName trim ,
		openParenthesis trim,
		(expression separatedBy: comma trim) optional, "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim
]

{ #category : #expression }
PSQLGrammar >> functionCallParserWith: expressionParser [
	^ functionName , (openParenthesis trim , 
		(((functionParameterName , ':=' asParser trim , expressionParser) trim / expressionParser trim) star separatedBy: comma trim) , 
		closeParenthesis trim)
]

{ #category : #accessing }
PSQLGrammar >> functionName [
	^ identifier
]

{ #category : #accessing }
PSQLGrammar >> functionParameterName [
	^ identifier
]

{ #category : #'select command' }
PSQLGrammar >> groupByClause [
	^ kw group trim , kw by trim , (expression plus separatedBy: comma trim)
]

{ #category : #'select command' }
PSQLGrammar >> havingClause [
	^ kw having trim , (expression plus separatedBy: comma trim)
]

{ #category : #expression }
PSQLGrammar >> inOperator [
	^ kw into trim not , kw in trim , keywordStop
]

{ #category : #dependencies }
PSQLGrammar >> insertCommand [
	^ (self dependencyAt: self class insertQueryParser) insertCommand
]

{ #category : #'select command' }
PSQLGrammar >> intoClause [
	"INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table"
	^ kw into trim , (kw temporary trim / kw temp trim / kw unlogged trim) optional , kw table trim optional , expression trim
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

{ #category : #'shared - from clause' }
PSQLGrammar >> joinType [
	^ (kw inner trim optional, kw join trim) /
	(kw left trim , kw outer trim optional , kw join trim) /
	(kw right trim , kw outer trim optional , kw join trim) /
	(kw full trim , kw outer trim optional , kw join trim) /
	(kw cross trim , kw join trim)
]

{ #category : #helpers }
PSQLGrammar >> keywordStop [
	^ (#space asParser / openBracket / closeBracket / openParenthesis / closeParenthesis / nil asParser) not not
]

{ #category : #'select command' }
PSQLGrammar >> limitClause [
	^ kw limit trim , (numericConstant trim / kw all trim)
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

{ #category : #'select command' }
PSQLGrammar >> offsetClause [
	^ kw offset trim , numericConstant trim
]

{ #category : #'select command' }
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

{ #category : #'shared - from clause' }
PSQLGrammar >> parenthesedFromItems [
	"Have a look at #fromItems6 if you wonder why #fromItems6 is not treated as the others."
	^ openParenthesis trim , fromItems trim , closeParenthesis trim
]

{ #category : #'accessing - blocks' }
PSQLGrammar >> postfixOperatorBlock [
	^ [ :op :exp | { op . exp } ]
]

{ #category : #'accessing - blocks' }
PSQLGrammar >> prefixOperatorBlock [
	^ [ :op :exp | { op . exp } ]
]

{ #category : #accessing }
PSQLGrammar >> primary [
	^ constant / columnReference / positionalParameter
]

{ #category : #helpers }
PSQLGrammar >> queryName [
	^ identifier
]

{ #category : #shared }
PSQLGrammar >> returningClause [
	"RETURNING * | output_expression [ [ AS ] output_name ] [, ...]"
	
	^ kw returning trim ,
		((asterik / (expression trim , (kw as trim optional , identifier) optional)) plus separatedBy: comma trim)
]

{ #category : #'select command' }
PSQLGrammar >> selectCommand [
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
	 SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
    	* | expression [ [ AS ] output_name ] [, ...]
    	[ FROM from_item [, ...] ]
    	[ WHERE condition ]
    	[ GROUP BY expression [, ...] ]
    	[ HAVING condition [, ...] ]
    	[ WINDOW window_name AS ( window_definition ) [, ...] ]
    	[ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] kw select ]
    	[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
    	[ LIMIT { count | ALL } ]
    	[ OFFSET start [ ROW | ROWS ] ]
    	[ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
    	[ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]"
	^ withClause optional ,
	   kw select trim ,
	   allOrDistinctClause optional ,
		columnsAndAliasesSelected trim,
		fromClause optional ,
		whereClause optional ,
		groupByClause optional ,
		havingClause optional ,
		windowClause optional ,
		unionIntersectExceptClause optional ,
		orderByClause optional ,
		limitClause optional ,
		offsetClause optional ,
		fetchClause optional ,
		forClause optional	
]

{ #category : #'select command' }
PSQLGrammar >> selectIntoCommand [
	^ selectIntoCommandAlternative / selectIntoCommandClassic
]

{ #category : #'select command' }
PSQLGrammar >> selectIntoCommandAlternative [
	"Alternative way to construct a SELECT INTO that was found in a DB schema.
	It is similar to #selectIntoClassic but with the following construct allowed:
	
	SELECT INTO table * | columns ...
	"
	^ withClause optional ,
	   kw select trim , kw into trim , identifierWithOptionalFieldAccess trim  ,
		columnsAndAliasesSelected trim ,
		fromClause optional ,
		whereClause optional ,
		groupByClause optional ,
		havingClause optional ,
		windowClause optional ,
		unionIntersectExceptClause optional ,
		orderByClause optional ,
		limitClause optional ,
		offsetClause optional ,
		fetchClause optional ,
		forClause optional	
]

{ #category : #'select command' }
PSQLGrammar >> selectIntoCommandClassic [
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
    * | expression [ [ AS ] output_name ] [, ...]
    INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table
    [ FROM from_item [, ...] ]
    [ WHERE condition ]
    [ GROUP BY expression [, ...] ]
    [ HAVING condition [, ...] ]
    [ WINDOW window_name AS ( window_definition ) [, ...] ]
    [ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] kw select ]
    [ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
    [ LIMIT { count | ALL } ]
    [ OFFSET start [ ROW | ROWS ] ]
    [ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
    [ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]"
	^ withClause optional ,
	   kw select trim ,
	   allOrDistinctClause optional ,
		columnsAndAliasesSelected trim,
		intoClause ,
		fromClause optional ,
		whereClause optional ,
		groupByClause optional ,
		havingClause optional ,
		windowClause optional ,
		unionIntersectExceptClause optional ,
		orderByClause optional ,
		limitClause optional ,
		offsetClause optional ,
		fetchClause optional ,
		forClause optional	
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
	^ columnName trim , $= asParser trim , (kw default / expression)
]

{ #category : #'shared - set clause' }
PSQLGrammar >> setItem2 [
	"( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] )"
	^ openParenthesis trim , (columnName plus separatedBy: comma trim) trim , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , ((kw default / expression) plus separatedBy: comma trim) , closeParenthesis
]

{ #category : #'shared - set clause' }
PSQLGrammar >> setItem3 [
	"( column_name [, ...] ) = ( sub-SELECT )"
	^ openParenthesis trim , (columnName plus separatedBy: comma trim) , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , selectCommand trim , closeParenthesis trim
]

{ #category : #expression }
PSQLGrammar >> subscriptWith: expressionParser [
	^ openBracket , expressionParser , (colon , expressionParser) optional , closeBracket
]

{ #category : #helpers }
PSQLGrammar >> tableName [
	^ identifier
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

{ #category : #'select command' }
PSQLGrammar >> unionIntersectExceptClause [
	^ (kw union trim / kw intersect trim / kw except trim) , (kw all trim / kw distinct trim) optional , selectCommand trim
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

{ #category : #'delete command' }
PSQLGrammar >> usingClause [
	"USING using_list"
	^ kw using trim , (expression separatedBy: comma trim)
]

{ #category : #dependencies }
PSQLGrammar >> valuesCommand [
	^ (self dependencyAt: self class valuesCommandParser) valuesCommand
]

{ #category : #'select command' }
PSQLGrammar >> whereClause [
	^ kw whereKeyword trim , expression
]

{ #category : #'select command' }
PSQLGrammar >> windowClause [
	self flag: #todo.
	^ nil asParser
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
