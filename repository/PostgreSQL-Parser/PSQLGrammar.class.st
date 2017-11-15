"
I parse expressions as defined in https://www.postgresql.org/docs/9.1/static/sql-expressions.html
"
Class {
	#name : #PSQLGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'expression',
		'columnReference',
		'correlation',
		'columnName',
		'primary',
		'functionParameterName',
		'orderByClause',
		'selectCommand',
		'withQuery',
		'fromClause',
		'whereClause',
		'groupByClause',
		'havingClause',
		'windowClause',
		'unionIntersectExceptClause',
		'limitClause',
		'offsetClause',
		'fetchClause',
		'forClause',
		'insertCommand',
		'updateCommand',
		'deleteCommand',
		'withClause',
		'fromItems1',
		'fromItems2',
		'fromItems3',
		'tableName',
		'alias',
		'columnAlias',
		'queryName',
		'functionName',
		'aggregateName',
		'fromItems4',
		'fromItems5',
		'fromItems',
		'fromItems6',
		'joinType',
		'identifier',
		'allOrDistinctClause',
		'columnsAndAliasesSelected',
		'binaryLogicalOperator',
		'columnDefinition',
		'typeCast',
		'isNull',
		'isNotNull',
		'parenthesedFromItems',
		'fieldSelection',
		'conditionalExpression',
		'createViewCommand',
		'intoClause',
		'selectIntoCommand',
		'inOperator',
		'keywordStop',
		'plpgsqlBlock',
		'plpgsqlBeginLabel',
		'plpgsqlDeclarations',
		'plpgsqlStatements',
		'plpgsqlEndLabel',
		'plpgsqlDeclarationItem',
		'plpgsqlDeclarationType',
		'plpgsqlDeclarationCollate',
		'plpgsqlClassicDeclaration',
		'plpgsqlAliasDeclaration',
		'plpgsqlStatement',
		'plpgsqlAssignmentStatement',
		'plpgsqlPerformStatement',
		'plpgsqlIntoQueryStatement',
		'plpgsqlExecuteStatement',
		'plpgsqlResultValueStatement',
		'plpgsqlNullStatement',
		'plpgsqlControlStructure',
		'plpgsqlReturn',
		'plpgsqlConditional',
		'plpgsqlLoop',
		'plpgsqlExceptionHandler',
		'plpgsqlQuery',
		'plpgsqlIfThen',
		'plpgsqlIfThenElse',
		'plpgsqlIfThenElsif',
		'plpgsqlSimpleCase',
		'plpgsqlSearchedCase',
		'plpgsqlLoopLoop',
		'plpgsqlWhileLoop',
		'plpgsqlForLoop',
		'plpgsqlArrayLoop',
		'plpgsqlExitStatement',
		'plpgsqlLabel',
		'plpgsqlContinueStatement',
		'plpgsqlQueryResultsLoop',
		'plpgsqlBody',
		'isNotDistinctFromOperator',
		'isDistinctFromOperator',
		'isTrue',
		'isNotTrue',
		'isFalse',
		'isNotFalse',
		'isNotUnknown',
		'booleanTestConstructOperator',
		'isUnknown',
		'nonStandardIsNull',
		'nonStandardNotNull',
		'nullTestConstructOperator',
		'notBetween',
		'betweenSymmetric',
		'notBetweenSymmetric',
		'betweenConstructOperator',
		'plpgsqlRaiseStatement',
		'plpgsqlRaiseLevel',
		'plpgsqlRaiseStatement1',
		'plpgsqlRaiseStatement2',
		'plpgsqlRaiseStatement3',
		'plpgsqlRaiseStatement4',
		'plpgsqlRaiseStatement5',
		'plpgsqlRaiseUsingOptions',
		'plpgsqlAssertStatement',
		'plpgsqlUnhandledStatement',
		'plpgsqlAssignmentLeftPart',
		'typeCastConstruct',
		'plpgsqlReturnForm1',
		'plpgsqlReturnForm2',
		'plpgsqlReturnForm3',
		'plpgsqlReturnForm4',
		'plpgsqlReturnForm5',
		'plpgsqlIndexParameter',
		'plpgsqlRecordDeclaration',
		'plpgsqlRowTypeDeclaration',
		'plpgsqlCopyTypeDeclaration',
		'plpgsqlCursorDeclaration',
		'plpgsqlOpenCursorForQuery',
		'plpgsqlOpenCursorForExecute',
		'plpgsqlOpenCursorBounded',
		'plpgsqlCursorStatement',
		'plpgsqlFetchCursorDirection',
		'plpgsqlCursorFetch',
		'plpgsqlMoveCursorDirection',
		'plpgsqlCursorMove',
		'plpgsqlCursorClose',
		'plpgsqlCursorForLoop',
		'plpgsqlCursorDelete',
		'plpgsqlCursorUpdate',
		'valuesClause',
		'valuesCommand',
		'onConflictClause',
		'returningClause',
		'conflictTarget',
		'conflictAction',
		'setClause',
		'setItem1',
		'setItem2',
		'setItem3',
		'conflictTarget1',
		'conflictTarget2',
		'nullExpression',
		'usingClause',
		'updateDeleteWhereClause',
		'notInOperator',
		'extractFunctionCall',
		'selectIntoCommandAlternative',
		'selectIntoCommandClassic',
		'fromItems7',
		'identifierWithOptionalFieldAccess',
		'defaultValues',
		'functionCall'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserWith: expressionParser [
	self flag: 'Check if the orderByClause should not be outside the parentheses.'.
	^ aggregateName , (openParenthesis ,
		(asterik /
		 ((kw all / kw distinct) optional,
		 (expressionParser plus separatedBy: comma trim) , orderByClause )),
	closeParenthesis)
]

{ #category : #accessing }
PSQLGrammar >> aggregateName [
	^ identifier
]

{ #category : #helpers }
PSQLGrammar >> alias [
	^ identifier
]

{ #category : #accessing }
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
			((identifier , $. asParser) optional , asterik trim) /
			(expression , (kw as trim , columnAlias) optional)
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

{ #category : #'insert command' }
PSQLGrammar >> conflictAction [
	"DO NOTHING
    DO UPDATE SET { column_name = { expression | DEFAULT } |
                    ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
                    ( column_name [, ...] ) = ( sub-SELECT )
                  } [, ...]
              [ WHERE condition ]"
	^ (kw do trim , kw nothing) /
	(kw do trim , kw update trim , setClause trim , (kw whereKeyword trim , expression) optional)
]

{ #category : #'insert command' }
PSQLGrammar >> conflictTarget [
	"( { index_column_name | ( index_expression ) } [ COLLATE collation ] [ opclass ] [, ...] ) [ WHERE index_predicate ]
	
	or
	
   ON CONSTRAINT constraint_name"
	^ conflictTarget1 / conflictTarget2
]

{ #category : #'insert command' }
PSQLGrammar >> conflictTarget1 [
	"( { index_column_name | ( index_expression ) } [ COLLATE collation ] [ opclass ] [, ...] ) [ WHERE index_predicate ]"
	self flag: 'TODO'. "Not sure of how to parse the rest of this..."
	^ (( openParenthesis trim , expression trim , closeParenthesis ) / columnName) ,
	"Missing something between"
	(kw whereKeyword trim , expression) optional
]

{ #category : #'insert command' }
PSQLGrammar >> conflictTarget2 [
	"ON CONSTRAINT constraint_name"
	^ kw on trim , kw constraint trim , identifier
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

{ #category : #'as yet unclassified' }
PSQLGrammar >> currentResultValueStatement [
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ kw get trim , kw current trim optional , kw diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)
]

{ #category : #'as yet unclassified' }
PSQLGrammar >> declareBlock [
	^ plpgsqlBeginLabel trim optional ,
	(kw declare trim , plpgsqlDeclarations trim) optional ,
	kw begin trim ,
	plpgsqlStatements trim ,
	kw endKeyword trim ,
	plpgsqlEndLabel trim optional , semicolon trim
]

{ #category : #'as yet unclassified' }
PSQLGrammar >> declareExceptionHandler [
	"[ <<label>> ]
	[ DECLARE
    	declarations ]
	BEGIN
    	statements
	EXCEPTION
    	WHEN condition [ OR condition ... ] THEN
        	handler_statements
    	[ WHEN condition [ OR condition ... ] THEN
          handler_statements
      ... ]
	END"
	^ plpgsqlBeginLabel trim optional ,
	(kw declare trim , plpgsqlDeclarations trim) optional ,
	kw begin trim ,
		plpgsqlStatements ,
	kw exception trim ,
		(kw when trim , expression , kw then trim , plpgsqlStatements) plus ,
	kw endKeyword trim
]

{ #category : #'as yet unclassified' }
PSQLGrammar >> defaultClassicDeclaration [
	^ identifier trim ,
	kw constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(kw notKeyword trim , kw null trim) optional ,
	((kw default trim / ':=' asParser trim / $= asParser trim) , expression) optional
]

{ #category : #'as yet unclassified' }
PSQLGrammar >> defaultDeclarationType [
	^ kw collate not , kw notKeyword not , kw default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , (
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) /
	(openBracket trim , closeBracket trim) plus) optional
]

{ #category : #'insert command' }
PSQLGrammar >> defaultValues [
	^ kw default trim , kw values
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
		group: [ :g | g left: kw as trim do: self binaryOperatorBlock ];
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

{ #category : #accessing }
PSQLGrammar >> fetchClause [
	^ kw fetch trim , (kw first trim / kw next trim) , numericConstant trim optional , (kw rows trim / kw row trim) , kw only trim
]

{ #category : #accessing }
PSQLGrammar >> fieldSelection [
	^ period , (identifier / asterik)
]

{ #category : #'select command' }
PSQLGrammar >> forClause [
	^ kw for trim , (kw update trim / kw share trim) , (kw of trim , (expression plus separatedBy: comma trim)) optional , kw nowait trim optional
]

{ #category : #shared }
PSQLGrammar >> fromClause [
	^ kw from trim , (fromItems plus separatedBy: comma trim)
]

{ #category : #shared }
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

{ #category : #shared }
PSQLGrammar >> fromItems1 [
	"[ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
                [ TABLESAMPLE sampling_method ( argument [, ...] ) [ REPEATABLE ( seed ) ] ]"
	self flag: 'Not fully implemented'.
	^ kw only trim optional ,
			identifierWithOptionalFieldAccess trim , asterik trim optional ,
				(kw as trim optional , alias trim ,
					(openParenthesis trim ,
					(columnAlias separatedBy: comma trim),
					closeParenthesis trim) optional) optional
]

{ #category : #shared }
PSQLGrammar >> fromItems2 [
	"This should be implemented as:
		[ LATERAL ] ( select ) [ AS ] alias [ ( column_alias [, ...] ) ]
	But is implemented as:
		[ LATERAL ] ( values | select ) [ AS ] alias [ ( column_alias [, ...] ) ]
	since using a VALUES query is just like if a select query is used except
	that the results are defined directly in the query."
	^ kw lateral trim optional ,
		openParenthesis trim , (valuesCommand / selectCommand) , closeParenthesis trim , kw as trim optional ,
			alias trim ,
			(openParenthesis trim,
			 (columnAlias separatedBy: comma trim),
			 closeParenthesis trim) optional
]

{ #category : #shared }
PSQLGrammar >> fromItems3 [
	"with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ queryName trim , (
			kw as trim optional , alias trim , 
			(openParenthesis trim,
			(columnAlias separatedBy: comma trim),
			closeParenthesis trim) optional) optional
]

{ #category : #shared }
PSQLGrammar >> fromItems4 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) [ AS ] alias ( column_definition [, ...] )"
	^ kw lateral trim optional , 
		functionCall trim ,
		kw as trim optional ,
		alias trim,
		openParenthesis trim ,
			(columnDefinition plus separatedBy: comma trim),
		closeParenthesis trim
]

{ #category : #shared }
PSQLGrammar >> fromItems5 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )"
	^ kw lateral trim optional , 
		functionCall trim ,
		kw as trim ,
		(openParenthesis trim ,
			(columnDefinition plus separatedBy: comma trim),
		closeParenthesis trim)
]

{ #category : #shared }
PSQLGrammar >> fromItems6 [
	"from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	Normally it should behaves as precedently described ^ BUT, because of recursivity problems, it is defined here as:
	
	[ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	and the 'from_item' is manged in #fromItems parser."
	
	^ kw natural trim optional , joinType trim , fromItems trim , 
		((kw on trim , expression) / 
		(kw using trim ,
			openParenthesis trim , 
			(columnReference separatedBy: comma trim),
			closeParenthesis trim)) optional
]

{ #category : #shared }
PSQLGrammar >> fromItems7 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ kw lateral trim optional , 
		functionName ,
		openParenthesis trim,
		(expression separatedBy: comma trim), "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim,
		(kw with trim , kw ordinality trim) optional ,
		(kw as trim optional ,
		alias trim,
		(openParenthesis trim ,
			(columnAlias plus separatedBy: comma trim),
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

{ #category : #accessing }
PSQLGrammar >> groupByClause [
	^ kw group trim , kw by trim , (expression plus separatedBy: comma trim)
]

{ #category : #accessing }
PSQLGrammar >> havingClause [
	^ kw having trim , (expression plus separatedBy: comma trim)
]

{ #category : #helpers }
PSQLGrammar >> identifier [
	^ kw keyword not , identifierOrKeyword
]

{ #category : #helpers }
PSQLGrammar >> identifierWithOptionalFieldAccess [
	^ identifier , ($. asParser , identifier) optional
]

{ #category : #expression }
PSQLGrammar >> inOperator [
	^ kw into trim not , kw in trim , keywordStop
]

{ #category : #'insert command' }
PSQLGrammar >> insertCommand [
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
INSERT INTO table_name [ AS alias ] [ ( column_name [, ...] ) ]
    { DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) [, ...] | query }
    [ ON CONFLICT [ conflict_target ] conflict_action ]
    [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]"
	
	^ withClause trim optional ,
		kw insert trim , kw into trim , identifierWithOptionalFieldAccess trim , (kw as trim , alias) optional , 
		(openParenthesis trim , 
			(expression plus separatedBy: comma trim) , "Apparently, a column name can be generated from an expression."
		closeParenthesis trim) trim optional ,
		valuesClause trim ,
		onConflictClause trim optional ,
		returningClause trim optional
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
	^ kw is trim , kw false
]

{ #category : #expression }
PSQLGrammar >> isNotDistinctFromOperator [
	^ kw is trim , kw notKeyword trim , kw distinct trim , kw from , keywordStop
]

{ #category : #expression }
PSQLGrammar >> isNotFalse [
	^ kw is trim , kw notKeyword trim , kw false
]

{ #category : #expression }
PSQLGrammar >> isNotNull [
	^ kw is trim , kw notKeyword trim , kw null
]

{ #category : #expression }
PSQLGrammar >> isNotTrue [
	^ kw is trim , kw notKeyword trim , kw true
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
	^ kw is trim , kw true
]

{ #category : #expression }
PSQLGrammar >> isUnknown [
	^ kw is trim , kw unknown
]

{ #category : #helpers }
PSQLGrammar >> keywordStop [
	^ (#space asParser / openBracket / closeBracket / openParenthesis / closeParenthesis / nil asParser) not not
]

{ #category : #accessing }
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

{ #category : #accessing }
PSQLGrammar >> offsetClause [
	^ kw offset trim , numericConstant trim
]

{ #category : #'insert command' }
PSQLGrammar >> onConflictClause [
	"ON CONFLICT [ conflict_target ] conflict_action"
	^ kw on trim , kw conflict trim , conflictTarget trim optional , conflictAction
]

{ #category : #helpers }
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

{ #category : #shared }
PSQLGrammar >> parenthesedFromItems [
	"Have a look at #fromItems6 if you wonder why #fromItems6 is not treated as the others."
	^ openParenthesis trim , fromItems trim , closeParenthesis trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlAliasDeclaration [
	^ identifier trim , alias trim , kw for trim , (plpgsqlIndexParameter trim / identifier trim)
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlArrayLoop [
	"[ <<label>> ]
	FOREACH target [ SLICE number ] IN ARRAY expression LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	kw foreach trim , identifier , (kw slice trim , numericConstant) trim optional , kw in trim , kw array trim , expression , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim ,
	plpgsqlLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlAssertStatement [
	"ASSERT condition [ , message ]"
	^ kw assert trim , expression trim , (comma trim , expression) optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlAssignmentLeftPart [
	^ (identifier , ($. asParser , identifier) star) , (self subscriptWith: expression) star
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlAssignmentStatement [
	^ plpgsqlAssignmentLeftPart trim , (':=' asParser / $= asParser) trim , expression
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlBeginLabel [
	^ '<<' asParser trim , plpgsqlLabel , '>>' asParser trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlBlock [
	^ plpgsqlBeginLabel trim optional ,
	(kw declare trim , plpgsqlDeclarations trim optional) optional ,
	kw begin trim ,
	plpgsqlStatements trim ,
	kw endKeyword trim ,
	plpgsqlEndLabel trim optional , semicolon trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlBody [
	^ plpgsqlBlock
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlClassicDeclaration [
	^ identifier trim ,
	kw constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(kw notKeyword trim , kw null trim) optional ,
	((kw default trim / ':=' asParser trim / $= asParser trim) , expression) optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlConditional [
	^ plpgsqlIfThen / plpgsqlIfThenElse / plpgsqlIfThenElsif / plpgsqlSimpleCase / plpgsqlSearchedCase
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlContinueStatement [
	"CONTINUE [ label ] [ WHEN boolean-expression ]"
	^ kw continue trim , plpgsqlLabel trim optional , (kw when trim , expression) trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlControlStructure [
	^ plpgsqlReturn / plpgsqlConditional / plpgsqlLoop / plpgsqlExceptionHandler
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCopyTypeDeclaration [
	^ identifier trim , identifier , $. asParser , identifier , '%TYPE' asParser caseInsensitive
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCursorClose [
	"CLOSE cursor"
	^ kw close trim , identifier
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCursorDeclaration [
	"name [ [ NO ] SCROLL ] CURSOR [ ( arguments ) ] FOR query"
	^ identifier trim , (kw no trim optional , kw scroll) trim optional , kw cursor trim ,
	(openParenthesis trim , 
		((identifier trim , identifierOrKeyword trim plus) plus separatedBy: comma trim) , 
	closeParenthesis trim) trim optional ,
	kw for trim , selectCommand
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCursorDelete [
	"DELETE FROM table WHERE CURRENT OF cursor"
	^ kw delete trim , kw from trim , identifier trim , kw whereKeyword trim , kw current trim , kw of trim , identifier
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCursorFetch [
	"FETCH [ direction { FROM | IN } ] cursor INTO target"
	^ kw fetch trim , 
	(plpgsqlFetchCursorDirection trim , (kw from / kw in)) trim optional ,
	identifier trim , kw into trim , (expression plus separatedBy: comma trim)
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCursorForLoop [
	"[ <<label>> ]
	FOR recordvar IN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ] LOOP
   		statements
	END LOOP [ label ]
	"
	^ plpgsqlBeginLabel trim optional ,
	kw for trim , identifier trim , kw in trim , identifier trim ,
	(openParenthesis trim ,
		(((identifier trim , ':=' asParser) trim optional , expression trim) plus separatedBy: comma trim) ,
	closeParenthesis trim) optional ,
	kw loop trim ,
	plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlEndLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCursorMove [
	"MOVE [ direction { FROM | IN } ] cursor"
	^ kw move trim ,
	(plpgsqlMoveCursorDirection trim , (kw from / kw in)) trim optional ,
	identifier
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCursorStatement [
	^ plpgsqlOpenCursorForQuery /
	plpgsqlOpenCursorForExecute /
	plpgsqlOpenCursorBounded /
	plpgsqlCursorFetch /
	plpgsqlCursorMove /
	plpgsqlCursorDelete /
	plpgsqlCursorUpdate /
	plpgsqlCursorClose /
	plpgsqlCursorForLoop
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlCursorUpdate [
	"UPDATE table SET ... WHERE CURRENT OF cursor"
	^ kw update trim , identifier trim , kw set trim , 
	((identifier trim , $= asParser trim , expression) plus separatedBy: comma trim) ,
	kw whereKeyword trim , kw current trim , kw of trim , identifier
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlDeclarationCollate [
	^ kw collate trim , quotedIdentifier trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlDeclarationItem [
	^ plpgsqlCursorDeclaration / plpgsqlRowTypeDeclaration / plpgsqlCopyTypeDeclaration / plpgsqlAliasDeclaration / plpgsqlClassicDeclaration / plpgsqlRecordDeclaration
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlDeclarationType [
	^ kw collate not , kw notKeyword not , kw default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , 
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) optional ,
	(openBracket trim , closeBracket trim) plus optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlDeclarations [
	^ (plpgsqlDeclarationItem trim separatedBy: semicolon trim) , semicolon trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlEndLabel [
	^ plpgsqlLabel
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlExceptionHandler [
	"[ <<label>> ]
	[ DECLARE
    	declarations ]
	BEGIN
    	statements
	EXCEPTION
    	WHEN condition [ OR condition ... ] THEN
        	handler_statements
    	[ WHEN condition [ OR condition ... ] THEN
          handler_statements
      ... ]
	END"
	^ plpgsqlBeginLabel trim optional ,
	(kw declare trim , plpgsqlDeclarations trim) optional ,
	kw begin trim ,
		plpgsqlStatements ,
	kw exception trim ,
		(kw when trim , expression , kw then trim , plpgsqlStatements) plus ,
	kw endKeyword trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlExecuteStatement [
	"EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ]"
	^ kw execute trim , expression trim ,
	(kw into trim , kw strict trim optional , identifier) trim optional ,
	(kw using trim, (expression plus separatedBy: comma trim))
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlExitStatement [
	"EXIT [ label ] [ WHEN boolean-expression ]"
	^ kw exit trim , plpgsqlLabel trim optional , (kw when trim , expression) trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlFetchCursorDirection [
	"NEXT | PRIOR | FIRST | LAST | ABSOLUTE count | RELATIVE count | FORWARD | BACKWARD"
	^ kw next / 
	kw prior / 
	kw first / 
	kw last / 
	(kw absolute trim , ($- asParser optional , numericConstant)) / 
	(kw relative trim , ($- asParser optional , numericConstant)) / 
	kw forward / 
	kw backward
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlForLoop [
	^ plpgsqlBeginLabel trim optional ,
	kw for trim , identifier trim , kw in trim , kw reverse trim optional , expression , '..' asParser trim , expression , (kw by trim , expression) trim optional , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlEndLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlIfThen [
	"IF boolean-expression THEN
    	statements
	END IF"
	^ kw if trim , expression trim , kw then trim ,
		plpgsqlStatements trim ,
	kw endKeyword trim , kw if trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlIfThenElse [
	"IF boolean-expression THEN
    	statements
	ELSE
    	statements
	END IF"
	^ kw if trim , expression , kw then trim ,
		plpgsqlStatements trim ,
	kw else trim ,
		plpgsqlStatements trim ,
	kw endKeyword trim , kw if trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlIfThenElsif [
	"IF boolean-expression THEN
    	statements
	[ ELSIF boolean-expression THEN
   	 	statements
	[ ELSIF boolean-expression THEN
    	statements
    ...]]
	[ ELSE
    	statements ]
	END IF"
	^ kw if trim , expression , kw then trim ,
		plpgsqlStatements ,
	((kw elsif/(kw else trim,kw if)) trim , expression , kw then trim ,
			plpgsqlStatements) star ,
	(kw else trim ,
		plpgsqlStatements) optional ,
	kw endKeyword trim , kw if trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlIndexParameter [
	^ $$ asParser , #digit asParser plus
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlIntoQueryStatement [
	^ selectIntoCommand
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlLabel [
	^ identifier
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlLoop [
	^ plpgsqlLoopLoop / plpgsqlWhileLoop / plpgsqlForLoop / plpgsqlQueryResultsLoop / plpgsqlArrayLoop
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlLoopLoop [
	"[ <<label>> ]
	LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	kw loop trim , plpgsqlStatements ,
	kw endKeyword trim , kw loop trim ,
	plpgsqlEndLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlMoveCursorDirection [
	"NEXT | PRIOR | FIRST | LAST | ABSOLUTE count | RELATIVE count | ALL | FORWARD [ count | ALL ] | BACKWARD [ count | ALL ]"
	^ kw next / 
	kw prior / 
	kw first / 
	kw last / 
	(kw absolute trim , ($- asParser optional , numericConstant)) / 
	(kw relative trim , ($- asParser optional , numericConstant)) / 
	kw all / 
	(kw forward trim , (kw all / ($- asParser optional , numericConstant))) / 
	(kw backward trim , (kw all / ($- asParser optional , numericConstant)))
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlNullStatement [
	^ kw null trim / kw endKeyword not not trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlOpenCursorBounded [
	"OPEN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ]"
	^ kw open trim , identifier trim , 
	( openParenthesis trim , 
		(((identifier trim , ':=' asParser) trim optional , expression trim) plus separatedBy: comma trim) ,
	closeParenthesis trim ) optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlOpenCursorForExecute [
	"OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR EXECUTE query_string [ USING expression [, ... ] ]"
	^ kw open trim , identifier trim ,
		(kw no trim optional , kw scroll trim) trim optional ,
		kw for trim , kw execute trim , expression trim , "This expression has to lead to a String"
		(kw using trim , (expression plus separatedBy: comma trim)) optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlOpenCursorForQuery [
	"OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR query"
	^ kw open trim , identifier trim , 
		(kw no trim optional , kw scroll trim) trim optional ,
		kw for trim , 
		selectCommand trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlPerformStatement [
	^ kw perform trim , (semicolon not , #any asParser) plus
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlQuery [
	^ selectCommand / insertCommand / updateCommand / deleteCommand
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlQueryResultsLoop [
	"[ <<label>> ]
	FOR target IN query LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	kw for trim , identifier trim , kw in trim , plpgsqlQuery , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim ,
	plpgsqlEndLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseLevel [
	^ kw debug / kw log / kw info / kw notice / kw warning / kw exception
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement [
	"RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ]
	RAISE [ level ] condition_name [ USING option = expression [, ... ] ]
	RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]
	RAISE [ level ] USING option = expression [, ... ]
	RAISE "
	^ plpgsqlRaiseStatement1 / plpgsqlRaiseStatement2 /plpgsqlRaiseStatement3 / plpgsqlRaiseStatement4 / plpgsqlRaiseStatement5
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement1 [
	"RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , simpleStringConstant trim , (expression star separatedBy: comma trim) , plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement2 [
	"RAISE [ level ] condition_name [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , identifier trim , plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement3 [
	"RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , 'SQLSTATE' asParser trim , simpleStringConstant trim ,
	plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement4 [
	"RAISE [ level ] USING option = expression [, ... ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional ,
		plpgsqlRaiseUsingOptions
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement5 [
	"RAISE"
	^ kw raise trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseUsingOptions [
	^  kw using trim , ((identifier trim , $= asParser trim , expression) plus separatedBy: comma trim)
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRecordDeclaration [
	^ identifier trim , kw record
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlResultValueStatement [
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ kw get trim , kw current trim optional , kw diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlReturn [
	"RETURN expression | 
	 RETURN NEXT expression |
	 RETURN QUERY query |
	 RETURN QUERY EXECUTE command-string [ USING expression [, ... ] ] |
	 RETURN"
	^ plpgsqlReturnForm1 /
	plpgsqlReturnForm2 /
	plpgsqlReturnForm3 /
	plpgsqlReturnForm4 /
	plpgsqlReturnForm5
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlReturnForm1 [
	^ kw return trim  , expression
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlReturnForm2 [
	^ kw return trim , kw next trim , expression
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlReturnForm3 [
	^ kw return trim , kw query trim , plpgsqlQuery
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlReturnForm4 [
	^ kw return trim , kw query trim , kw execute trim , stringConstant trim , (kw using trim , (expression plus separatedBy: comma trim)) optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlReturnForm5 [
	^ kw return
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRowTypeDeclaration [
	^ identifier trim , tableName , '%ROWTYPE' asParser caseInsensitive
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlSearchedCase [
	"CASE search-expression
    	WHEN expression [, expression [ ... ]] THEN
    		statements
  		[ WHEN expression [, expression [ ... ]] THEN
      		statements
   		 ... ]
  		[ ELSE
      		statements ]
	END CASE"
	^ kw case trim , expression ,
		(kw when trim , (expression plus separatedBy: comma trim) , kw then trim ,
			plpgsqlStatements) plus ,
		(kw else trim ,
			plpgsqlStatements) optional ,
		kw endKeyword trim , kw case trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlSimpleCase [
	"CASE
    	WHEN boolean-expression THEN
      		statements
  		[ WHEN boolean-expression THEN
      		statements
    		... ]
  		[ ELSE
      		statements ]
	END CASE"
	^ kw case trim ,
		(kw when trim , expression , kw then trim ,
			plpgsqlStatements) plus ,
		(kw else trim , plpgsqlStatements) optional ,
		kw endKeyword trim , kw case trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlStatement [
	^ plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlExitStatement / plpgsqlContinueStatement / plpgsqlRaiseStatement / plpgsqlAssertStatement / plpgsqlCursorStatement / plpgsqlControlStructure / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlNullStatement / plpgsqlQuery / expression
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlStatements [
	^ plpgsqlStatement trim , (semicolon trim , kw endKeyword not , plpgsqlStatement) trim star , semicolon trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlUnhandledStatement [
	^ PPFailingParser new
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlWhileLoop [
	^ plpgsqlBeginLabel trim optional ,
	kw while trim , expression , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlLabel trim optional
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

{ #category : #shared }
PSQLGrammar >> setClause [
	"SET { column_name = { expression | DEFAULT } |
                    ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
                    ( column_name [, ...] ) = ( sub-SELECT )
                  } [, ...]"
	^ kw set trim ,
	((setItem1 / setItem2 / setItem3) plus separatedBy: comma trim)
]

{ #category : #shared }
PSQLGrammar >> setItem1 [
	"column_name = { expression | DEFAULT }"
	^ columnName trim , $= asParser trim , (kw default / expression)
]

{ #category : #shared }
PSQLGrammar >> setItem2 [
	"( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] )"
	^ openParenthesis trim , (columnName plus separatedBy: comma trim) trim , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , ((kw default / expression) plus separatedBy: comma trim) , closeParenthesis
]

{ #category : #shared }
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

{ #category : #accessing }
PSQLGrammar >> updateCommand [
	"https://www.postgresql.org/docs/9.6/static/sql-update.html
	[ WITH [ RECURSIVE ] with_query [, ...] ]
		UPDATE [ ONLY ] table_name [ * ] [ [ AS ] alias ]
    	SET { column_name = { expression | DEFAULT } |
          ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
          ( column_name [, ...] ) = ( sub-SELECT )
        } [, ...]
    	[ FROM from_list ]
    	[ WHERE condition | WHERE CURRENT OF cursor_name ]
    	[ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]"
	^ withClause trim optional ,
		kw update trim , kw only trim optional , identifierWithOptionalFieldAccess trim , asterik trim optional , (kw as trim optional , identifier) optional ,
		setClause trim ,
		fromClause trim optional ,
		updateDeleteWhereClause trim optional ,
		returningClause trim optional
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

{ #category : #'insert command' }
PSQLGrammar >> valuesClause [
	"DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) [, ...] | query"
	^ defaultValues /
	valuesCommand /
	selectCommand
]

{ #category : #'values command' }
PSQLGrammar >> valuesCommand [
	"This should implement:
		VALUES ( expression [, ...] ) [, ...]
	But it implements:
		VALUES ( { expression | DEFAULT } [, ...] ) [, ...]
	instead in order to be reusable in #insertCommand.
	
	Please manage this fact while building the AST."
	
	^ kw values trim ,
	((openParenthesis trim,
		((kw default / expression) plus separatedBy: comma trim) ,
	closeParenthesis trim) plus separatedBy: comma trim)
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
