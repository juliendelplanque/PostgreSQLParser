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
		'keyword',
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
		'table',
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
		'plsqlRowTypeDeclaration',
		'plsqlFieldTypeDeclaration',
		'plsqlRecordDeclaration',
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
		'falseKeyword',
		'trueKeyword',
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
		'typeCastConstruct'
	],
	#category : 'PostgreSQL-Experiments'
}

{ #category : #expression }
PSQLGrammar >> aggregateExpressionParserWith: expressionParser [
	^ aggregateName , (openParenthesis ,
		(asterik /
		 ((all / distinct) optional,
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
	^  all trim /
	(distinct trim , 
		(on trim ,
			openParenthesis trim ,
			(expression plus separatedBy: comma trim) ,
			closeParenthesis trim
		) optional
	)
]

{ #category : #expression }
PSQLGrammar >> betweenConstructOperator [
	^ (betweenSymmetric / notBetweenSymmetric / between / notBetween) , keywordStop
]

{ #category : #expression }
PSQLGrammar >> betweenSymmetric [
	^ between trim , symmetric
]

{ #category : #expression }
PSQLGrammar >> binaryLogicalOperator [
	^ (andKeyword / or) , #space asParser
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

{ #category : #accessing }
PSQLGrammar >> columnDefinition [
	^ columnReference trim , expression
]

{ #category : #accessing }
PSQLGrammar >> columnName [
	^ identifier
]

{ #category : #accessing }
PSQLGrammar >> columnReference [
	^ (correlation , period) optional , columnName
]

{ #category : #accessing }
PSQLGrammar >> columnsAndAliasesSelected [
	"expression [ [ AS ] output_name ] [, ...]"
	^ (expression , (as trim , columnAlias) optional) plus separatedBy: comma trim
]

{ #category : #expression }
PSQLGrammar >> commaSubscriptWith: expressionParser [
	self flag: 'In fact this is an array constructor, maybe it should be treated differently?'.
	^ openBracket , (expressionParser trim plus separatedBy: comma trim) , closeBracket
]

{ #category : #expression }
PSQLGrammar >> compositeValueWith: anExpressionParser [
	^ openParenthesis trim , (anExpressionParser plus separatedBy: comma trim) , closeParenthesis trim , typeCastConstruct trim optional
]

{ #category : #expression }
PSQLGrammar >> conditionalExpression [
	^ case trim ,
		(when trim , expression trim , then trim , expression trim) plus,
		(else trim , expression trim) optional ,
	endKeyword trim
]

{ #category : #accessing }
PSQLGrammar >> correlation [
	^ identifier
]

{ #category : #'create view command' }
PSQLGrammar >> createViewCommand [
	"CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] VIEW name [ ( column_name [, ...] ) ]
    [ WITH ( view_option_name [= view_option_value] [, ... ] ) ]
    AS query"
	self flag: 'TODO: support VALUES command for view definition.'.
	^ create trim ,
		(or trim , replace) trim optional ,
		(temporary / temp) trim optional ,
		view trim ,
		identifier trim , 
		(openParenthesis trim ,
			(columnName plus separatedBy: comma trim) ,
		closeParenthesis trim) trim optional ,
		(with trim , openParenthesis trim ,
			((identifierOrKeyword trim , ($= asParser trim , identifierOrKeyword trim) optional ) plus separatedBy: comma trim) , 
		closeParenthesis trim) trim optional ,
		as trim ,
		selectCommand trim
]

{ #category : #'as yet unclassified' }
PSQLGrammar >> deleteCommand [
	self flag: #todo.
	^ nil asParser
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
			g prefix: notKeyword trim do: self prefixOperatorBlock.
			g prefix: any trim do: self prefixOperatorBlock.
			g prefix: distinct trim do: self prefixOperatorBlock.
			g postfix: nullTestConstructOperator trim do: self postfixOperatorBlock.
			g postfix: booleanTestConstructOperator trim do: self postfixOperatorBlock.
			g postfix: (self subscriptWith: expressionParser) trim do: self postfixOperatorBlock. ];
		group: [ :g | g left: operator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: inOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: isDistinctFromOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: isNotDistinctFromOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: betweenConstructOperator trim do: self binaryOperatorBlock ];
		group: [ :g | g left: binaryLogicalOperator trim do: self binaryOperatorBlock ];
		group: [ :g |
			g postfix: operator trim do: self postfixOperatorBlock.
			g postfix: (self commaSubscriptWith: expressionParser) trim do: self postfixOperatorBlock.
			g postfix: fieldSelection trim do: self postfixOperatorBlock ].
	^ expressionParser
]

{ #category : #expression }
PSQLGrammar >> expressionParserTermFor: expressionParser [
	| parenthesedExpression functionCall aggregateExpression compositeValue |
	parenthesedExpression := self parenthesedExpressionParserWith: expressionParser.
	functionCall := self functionCallParserWith: expressionParser.
	aggregateExpression := self aggregateExpressionParserWith: expressionParser.
	compositeValue := self compositeValueWith: expressionParser.
	^ (parenthesedExpression / compositeValue / conditionalExpression / aggregateExpression / functionCall / primary / selectCommand) , typeCastConstruct optional.
]

{ #category : #keywords }
PSQLGrammar >> falseKeyword [
	"<psqlkeyword>"self flag: 'Or this breaks the parser'.
	^ self buildKeyword: 'false'
]

{ #category : #accessing }
PSQLGrammar >> fetchClause [
	^ fetch trim , (first trim / next trim) , numericConstant trim optional , (rows trim / row trim) , only trim
]

{ #category : #accessing }
PSQLGrammar >> fieldSelection [
	^ period , (identifier / asterik)
]

{ #category : #'select command' }
PSQLGrammar >> forClause [
	^ for trim , (update trim / share trim) , (of trim , (expression plus separatedBy: comma trim)) optional , nowait trim optional
]

{ #category : #'select command' }
PSQLGrammar >> fromClause [
	"See https://www.postgresql.org/docs/9.1/static/sql-select.html#SQL-FROM"
	^ from trim , (fromItems plus separatedBy: comma trim)
]

{ #category : #'select command' }
PSQLGrammar >> fromItems [
	"Have a look at #fromItems6 if you wonder why #fromItems6 is not treated as the others."
	^ (parenthesedFromItems / ((fromItems4 / fromItems5 / fromItems1 / fromItems2 / fromItems3) , fromItems6 optional)) , fromItems6 optional
]

{ #category : #'select command' }
PSQLGrammar >> fromItems1 [
	"[ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ only trim optional ,
			tableName trim , asterik trim optional ,
				(as trim optional , alias trim ,
					(openParenthesis trim ,
					(columnAlias separatedBy: comma trim),
					closeParenthesis trim) optional) optional
]

{ #category : #'select command' }
PSQLGrammar >> fromItems2 [
	"( select ) [ AS ] alias [ ( column_alias [, ...] ) ]"
	^ openParenthesis trim , selectCommand , closeParenthesis trim , as trim optional ,
			alias trim ,
			(openParenthesis trim,
			 (columnAlias separatedBy: comma trim),
			 closeParenthesis trim) optional
]

{ #category : #'select command' }
PSQLGrammar >> fromItems3 [
	"with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ queryName , (
			as trim optional , alias , 
			(openParenthesis trim,
			(columnAlias separatedBy: comma trim),
			closeParenthesis trim) optional) optional
]

{ #category : #accessing }
PSQLGrammar >> fromItems4 [
	"function_name ( [ argument [, ...] ] ) [ AS ] alias [ ( column_alias [, ...] | column_definition [, ...] ) ]"
	^ functionName ,
		openParenthesis trim,
		(expression separatedBy: comma trim), "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim,
		as trim optional ,
		alias trim,
		(openParenthesis trim ,
			((columnDefinition plus separatedBy: comma trim) / (columnReference plus separatedBy: comma trim)),
		closeParenthesis trim) optional
]

{ #category : #accessing }
PSQLGrammar >> fromItems5 [
	"function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )"
	^ functionName ,
		openParenthesis trim,
		(expression separatedBy: comma trim), "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim,
		as trim ,
		(openParenthesis trim ,
			(columnDefinition plus separatedBy: comma trim),
		closeParenthesis trim) optional
]

{ #category : #'select command' }
PSQLGrammar >> fromItems6 [
	"from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	Normally it should behaves as precedently described ^ BUT, because of recursivity problems, it is defined here as:
	
	[ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	and the 'from_item' is manged in #fromItems parser."
	
	^ natural trim optional , joinType trim , fromItems trim , 
		((on trim , expression) / 
		(using trim ,
			openParenthesis trim , 
			(columnReference separatedBy: comma trim),
			closeParenthesis trim)) optional
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
	^ group trim , by trim , (expression plus separatedBy: comma trim)
]

{ #category : #accessing }
PSQLGrammar >> havingClause [
	^ having trim , (expression plus separatedBy: comma trim)
]

{ #category : #helpers }
PSQLGrammar >> identifier [
	^ keyword not , identifierOrKeyword
]

{ #category : #expression }
PSQLGrammar >> inOperator [
	^ into trim not , in trim , keywordStop
]

{ #category : #'as yet unclassified' }
PSQLGrammar >> insertCommand [
	self flag: #todo.
	^ nil asParser
]

{ #category : #'select command' }
PSQLGrammar >> intoClause [
	"INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table"
	^ into trim , (temporary trim / temp trim / unlogged trim) optional , table trim optional , tableName trim
]

{ #category : #expression }
PSQLGrammar >> isDistinctFromOperator [
	^ is trim , distinct trim , from , keywordStop
]

{ #category : #expression }
PSQLGrammar >> isFalse [
	^ is trim , falseKeyword
]

{ #category : #expression }
PSQLGrammar >> isNotDistinctFromOperator [
	^ is trim , notKeyword trim , distinct trim , from , keywordStop
]

{ #category : #expression }
PSQLGrammar >> isNotFalse [
	^ is trim , notKeyword trim , falseKeyword
]

{ #category : #expression }
PSQLGrammar >> isNotNull [
	^ is trim , notKeyword trim , null
]

{ #category : #expression }
PSQLGrammar >> isNotTrue [
	^ is trim , notKeyword trim , trueKeyword
]

{ #category : #expression }
PSQLGrammar >> isNotUnknown [
	^ is trim , notKeyword trim , unknown
]

{ #category : #expression }
PSQLGrammar >> isNull [
	^ is trim , null
]

{ #category : #expression }
PSQLGrammar >> isTrue [
	^ is trim , trueKeyword
]

{ #category : #expression }
PSQLGrammar >> isUnknown [
	^ is trim , unknown
]

{ #category : #helpers }
PSQLGrammar >> keywordStop [
	^ (#space asParser / openBracket / closeBracket / openParenthesis / closeParenthesis / nil asParser) not not
]

{ #category : #accessing }
PSQLGrammar >> limitClause [
	^ limit trim , (numericConstant trim / all trim)
]

{ #category : #expression }
PSQLGrammar >> nonStandardIsNull [
	^ (self buildKeyword: 'isnull')
]

{ #category : #expression }
PSQLGrammar >> nonStandardNotNull [
	^ (self buildKeyword: 'notnull')
]

{ #category : #expression }
PSQLGrammar >> notBetween [
	^ notKeyword trim, between
]

{ #category : #expression }
PSQLGrammar >> notBetweenSymmetric [
	^ notKeyword trim, between trim , symmetric
]

{ #category : #expression }
PSQLGrammar >> nullTestConstructOperator [
	^ (isNull / isNotNull / nonStandardIsNull / nonStandardNotNull) , keywordStop
]

{ #category : #accessing }
PSQLGrammar >> offsetClause [
	^ offset trim , numericConstant trim
]

{ #category : #helpers }
PSQLGrammar >> orderByClause [
	^ order trim , by trim ,
		((expression ,
		(asc / desc) trim optional,
		(nulls , (first / last) trim) trim optional) plus separatedBy: comma trim)
]

{ #category : #expression }
PSQLGrammar >> parenthesedExpressionParserWith: expressionParser [
	^ openParenthesis trim , expressionParser , closeParenthesis trim.
]

{ #category : #'select command' }
PSQLGrammar >> parenthesedFromItems [
	"Have a look at #fromItems6 if you wonder why #fromItems6 is not treated as the others."
	^ openParenthesis trim , fromItems trim , closeParenthesis trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlAliasDeclaration [
	^ identifier trim , alias trim , for trim , (($$ asParser , numericConstant) trim / identifier trim)
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlArrayLoop [
	"[ <<label>> ]
	FOREACH target [ SLICE number ] IN ARRAY expression LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	foreach trim , identifier , (slice trim , numericConstant) trim optional , in trim , array trim , expression , loop trim ,
		plpgsqlStatements ,
	endKeyword trim , loop trim ,
	plpgsqlLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlAssertStatement [
	"ASSERT condition [ , message ]"
	^ (self buildKeyword: 'assert') trim , expression trim , (comma trim , expression) optional
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
	(declare trim , plpgsqlDeclarations trim) optional ,
	begin trim ,
	plpgsqlStatements trim ,
	endKeyword trim ,
	plpgsqlEndLabel trim optional , semicolon trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlBody [
	^ plpgsqlBlock
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlClassicDeclaration [
	^ identifier trim ,
	constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(notKeyword trim , null trim) optional ,
	((default trim / ':=' asParser trim / $= asParser trim) , expression) optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlConditional [
	^ plpgsqlIfThen / plpgsqlIfThenElse / plpgsqlIfThenElsif / plpgsqlSimpleCase / plpgsqlSearchedCase
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlContinueStatement [
	"CONTINUE [ label ] [ WHEN boolean-expression ]"
	^ continue trim , plpgsqlLabel trim optional , (when trim , expression) trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlControlStructure [
	^ plpgsqlReturn / plpgsqlConditional / plpgsqlLoop / plpgsqlExceptionHandler
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlDeclarationCollate [
	^ collate trim , quotedIdentifier trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlDeclarationItem [
	^ plsqlFieldTypeDeclaration / plsqlRowTypeDeclaration / plpgsqlClassicDeclaration / plpgsqlAliasDeclaration / plsqlRecordDeclaration
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlDeclarationType [
	^ collate not , notKeyword not , default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , (
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) /
	(openBracket trim , closeBracket trim) plus) optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlDeclarations [
	^ (plpgsqlDeclarationItem trim separatedBy: semicolon) , semicolon trim
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
	(declare trim , plpgsqlDeclarations trim) optional ,
	begin trim ,
		plpgsqlStatements ,
	exception trim ,
		(when trim , expression , then trim , plpgsqlStatements) plus ,
	endKeyword trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlExecuteStatement [
	"EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ]"
	^ execute trim , expression trim ,
	(into trim , strict trim optional , identifier) trim optional ,
	(using trim, (expression plus separatedBy: comma trim))
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlExitStatement [
	"EXIT [ label ] [ WHEN boolean-expression ]"
	^ exit trim , plpgsqlLabel trim optional , (when trim , expression) trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlForLoop [
	^ plpgsqlBeginLabel trim optional ,
	for trim , identifier trim , in trim , reverse trim optional , expression , '..' asParser trim , expression , (by trim , expression) trim optional , loop trim ,
		plpgsqlStatements ,
	endKeyword trim , loop trim , plpgsqlEndLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlIfThen [
	"IF boolean-expression THEN
    	statements
	END IF"
	^ if trim , expression trim , then trim ,
		plpgsqlStatements trim ,
	endKeyword trim , if trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlIfThenElse [
	"IF boolean-expression THEN
    	statements
	ELSE
    	statements
	END IF"
	^ if trim , expression , then trim ,
		plpgsqlStatements trim ,
	else trim ,
		plpgsqlStatements trim ,
	endKeyword trim , if trim
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
	^ if trim , expression , then trim ,
		plpgsqlStatements ,
	((elsif/(else,if)) trim , expression , then trim ,
			plpgsqlStatements) star ,
	(else trim ,
		plpgsqlStatements) optional ,
	endKeyword trim , if trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlIntoQueryStatement [
	self flag: #'implement others into queries: insert, update and delete'.
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
	loop trim , plpgsqlStatements ,
	endKeyword trim , loop trim ,
	plpgsqlEndLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlNullStatement [
	^ null trim" / #space asParser star"
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlPerformStatement [
	^ perform trim , (semicolon not , #any asParser) plus
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlQuery [
	^ selectCommand
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlQueryResultsLoop [
	"[ <<label>> ]
	FOR target IN query LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	for trim , identifier trim , in trim , plpgsqlQuery , loop trim ,
		plpgsqlStatements ,
	endKeyword trim , loop trim ,
	plpgsqlEndLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseLevel [
	^ (self buildKeyword: 'debug') / (self buildKeyword: 'log') / (self buildKeyword: 'info') / (self buildKeyword: 'notice') / (self buildKeyword: 'warning') / (self buildKeyword: 'exception')
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
	^ raise trim , plpgsqlRaiseLevel trim optional , simpleStringConstant trim , (expression star separatedBy: comma trim) , plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement2 [
	"RAISE [ level ] condition_name [ USING option = expression [, ... ] ]"
	^ raise trim , plpgsqlRaiseLevel trim optional , identifier trim , plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement3 [
	"RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]"
	^ raise trim , plpgsqlRaiseLevel trim optional , 'SQLSTATE' asParser trim , simpleStringConstant trim ,
	plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement4 [
	"RAISE [ level ] USING option = expression [, ... ]"
	^ raise trim , plpgsqlRaiseLevel trim optional ,
		plpgsqlRaiseUsingOptions
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseStatement5 [
	"RAISE"
	^ raise trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlRaiseUsingOptions [
	^  using trim , ((identifier trim , $= asParser trim , expression) plus separatedBy: comma trim)
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlResultValueStatement [
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ get trim , current trim optional , diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlReturn [
	"RETURN expression | 
	 RETURN NEXT expression |
	 RETURN QUERY query |
	 RETURN QUERY EXECUTE command-string [ USING expression [, ... ] ] |
	 RETURN"
	^ (return trim  , expression) /
	(return trim , next trim , expression) /
	(return trim , query trim , plpgsqlQuery) /
	(return trim , query trim , execute trim , stringConstant trim , (using trim , (expression plus separatedBy: comma trim)) optional) /
	return
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlSearchedCase [
	"CASE
    	WHEN boolean-expression THEN
      		statements
  		[ WHEN boolean-expression THEN
      		statements
    		... ]
  		[ ELSE
      		statements ]
	END CASE"
	^ case trim ,
		(when trim , expression , then trim ,
			plpgsqlStatements) plus ,
		(else trim , plpgsqlStatements) optional ,
		endKeyword trim , case trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlSimpleCase [
	"CASE search-expression
    	WHEN expression [, expression [ ... ]] THEN
    		statements
  		[ WHEN expression [, expression [ ... ]] THEN
      		statements
   		 ... ]
  		[ ELSE
      		statements ]
	END CASE"
	^ case trim , expression ,
		(when trim , (expression plus separatedBy: comma trim) , then trim ,
			plpgsqlStatements) plus ,
		(else trim ,
			plpgsqlStatements) optional ,
		endKeyword trim , case trim
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlStatement [
	^ plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlExitStatement / plpgsqlContinueStatement / plpgsqlRaiseStatement / plpgsqlAssertStatement / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlNullStatement / plpgsqlControlStructure / expression / plpgsqlUnhandledStatement
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlStatements [
	^ plpgsqlStatement trim , (semicolon trim , endKeyword not , plpgsqlStatement) trim star , semicolon trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlUnhandledStatement [
	^ PPFailingParser new
]

{ #category : #plpgsql }
PSQLGrammar >> plpgsqlWhileLoop [
	^ plpgsqlBeginLabel trim optional ,
	while trim , expression , loop trim ,
		plpgsqlStatements ,
	endKeyword trim , loop trim , plpgsqlLabel trim optional
]

{ #category : #plpgsql }
PSQLGrammar >> plsqlFieldTypeDeclaration [
	^ identifier trim , tableName , $. asParser , columnName  , $% asParser , identifierOrKeyword
]

{ #category : #plpgsql }
PSQLGrammar >> plsqlRecordDeclaration [
	^ identifier trim , record
]

{ #category : #plpgsql }
PSQLGrammar >> plsqlRowTypeDeclaration [
	^ identifier trim , tableName , $% asParser , identifierOrKeyword
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
    	[ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] select ]
    	[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
    	[ LIMIT { count | ALL } ]
    	[ OFFSET start [ ROW | ROWS ] ]
    	[ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
    	[ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]"
	^ withClause optional ,
	   select trim ,
	   allOrDistinctClause optional ,
		(asterik trim / columnsAndAliasesSelected trim),
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
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
    * | expression [ [ AS ] output_name ] [, ...]
    INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table
    [ FROM from_item [, ...] ]
    [ WHERE condition ]
    [ GROUP BY expression [, ...] ]
    [ HAVING condition [, ...] ]
    [ WINDOW window_name AS ( window_definition ) [, ...] ]
    [ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] select ]
    [ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
    [ LIMIT { count | ALL } ]
    [ OFFSET start [ ROW | ROWS ] ]
    [ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
    [ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]"
	^ withClause optional ,
	   select trim ,
	   allOrDistinctClause optional ,
		(asterik trim / columnsAndAliasesSelected trim),
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

{ #category : #expression }
PSQLGrammar >> subscriptWith: expressionParser [
	^ openBracket , expressionParser , (colon , expressionParser) optional , closeBracket
]

{ #category : #keywords }
PSQLGrammar >> table [
	^ self buildKeyword: 'table'
]

{ #category : #helpers }
PSQLGrammar >> tableName [
	^ identifier
]

{ #category : #keywords }
PSQLGrammar >> trueKeyword [
	"<psqlkeyword>"self flag: 'Or this breaks the parser'.
	^ self buildKeyword: 'true'
]

{ #category : #expression }
PSQLGrammar >> typeCast [
	^ '::' asParser
]

{ #category : #expression }
PSQLGrammar >> typeCastConstruct [
	^ (typeCast trim , ((else not , case not , endKeyword not , andKeyword not , or not , then not , identifierOrKeyword) plus separatedBy: #space asParser plus)) optional.
]

{ #category : #'select command' }
PSQLGrammar >> unionIntersectExceptClause [
	^ (union trim / intersect trim / except trim) , (all trim / distinct trim) optional , selectCommand trim
]

{ #category : #'as yet unclassified' }
PSQLGrammar >> updateCommand [
	self flag: #todo.
	^ nil asParser
]

{ #category : #'select command' }
PSQLGrammar >> whereClause [
	^ where trim , expression
]

{ #category : #'select command' }
PSQLGrammar >> windowClause [
	self flag: #todo.
	^ nil asParser
]

{ #category : #'select command' }
PSQLGrammar >> withClause [
	^ with trim , recursive trim optional , (withQuery separatedBy: comma trim)
]

{ #category : #'select command' }
PSQLGrammar >> withQuery [
	^ identifier trim ,
	  		(openParenthesis trim ,
			(identifierOrKeyword separatedBy: comma trim ) ,
			closeParenthesis trim) optional ,
	  as trim ,
	  openParenthesis trim ,
	  (selectCommand / insertCommand / updateCommand / deleteCommand) ,
	  closeParenthesis trim
]
