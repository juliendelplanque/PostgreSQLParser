"
I parse PL/pgSQL source code. 
"
Class {
	#name : #PSQLPlpgSQLGrammar,
	#superclass : #PPCompositeParser,
	#traits : 'PSQLTExpressionDependingGrammar',
	#classTraits : 'PSQLTExpressionDependingGrammar classTrait',
	#instVars : [
		'deleteCommand',
		'expression',
		'insertCommand',
		'selectCommand',
		'selectIntoCommand',
		'updateCommand',
		'plpgsqlRecordDeclaration',
		'plpgsqlIfThenElse',
		'plpgsqlSearchedCase',
		'plpgsqlAssertStatement',
		'plpgsqlCursorClose',
		'plpgsqlQuery',
		'plpgsqlExceptionHandler',
		'plpgsqlReturnForm1',
		'plpgsqlIntoQueryStatement',
		'plpgsqlStatements',
		'plpgsqlCursorUpdate',
		'plpgsqlRaiseStatement4',
		'plpgsqlEndLabel',
		'plpgsqlReturn',
		'plpgsqlAssignmentLeftPart',
		'plpgsqlCursorDeclaration',
		'plpgsqlCursorDelete',
		'plpgsqlAssignmentStatement',
		'plpgsqlQueryResultsLoop',
		'plpgsqlRaiseLevel',
		'plpgsqlClassicDeclaration',
		'plpgsqlNullStatement',
		'plpgsqlWhileLoop',
		'plpgsqlBody',
		'plpgsqlLoop',
		'plpgsqlIndexParameter',
		'plpgsqlStatement',
		'plpgsqlExecuteStatement',
		'plpgsqlReturnForm2',
		'plpgsqlExitStatement',
		'plpgsqlCurrentResultValueStatement',
		'plpgsqlBlock',
		'plpgsqlCursorForLoop',
		'plpgsqlDeclareExceptionHandler',
		'plpgsqlDefaultClassicDeclaration',
		'plpgsqlRaiseStatement1',
		'plpgsqlDeclarationItem',
		'plpgsqlRaiseUsingOptions',
		'plpgsqlReturnForm3',
		'plpgsqlMoveCursorDirection',
		'plpgsqlBeginLabel',
		'plpgsqlCursorFetch',
		'plpgsqlRaiseStatement',
		'plpgsqlFetchCursorDirection',
		'plpgsqlReturnForm4',
		'plpgsqlContinueStatement',
		'plpgsqlOpenCursorForExecute',
		'plpgsqlCursorStatement',
		'plpgsqlRaiseStatement3',
		'plpgsqlLabel',
		'plpgsqlDeclareBlock',
		'plpgsqlConditional',
		'plpgsqlOpenCursorBounded',
		'plpgsqlUnhandledStatement',
		'plpgsqlDefaultDeclarationType',
		'plpgsqlForLoop',
		'plpgsqlReturnForm5',
		'plpgsqlIfThen',
		'plpgsqlRowTypeDeclaration',
		'plpgsqlDeclarations',
		'plpgsqlResultValueStatement',
		'plpgsqlDeclarationCollate',
		'plpgsqlRaiseStatement5',
		'plpgsqlCursorMove',
		'plpgsqlRaiseStatement2',
		'plpgsqlAliasDeclaration',
		'plpgsqlControlStructure',
		'plpgsqlOpenCursorForQuery',
		'plpgsqlArrayLoop',
		'plpgsqlCopyTypeDeclaration',
		'plpgsqlPerformStatement',
		'plpgsqlIfThenElsif',
		'plpgsqlSimpleCase',
		'plpgsqlLoopLoop',
		'plpgsqlDeclarationType',
		'kw',
		'identifier',
		'numericConstant',
		'comma',
		'semicolon',
		'openParenthesis',
		'identifierOrKeyword',
		'closeParenthesis',
		'quotedIdentifier',
		'openBracket',
		'closeBracket',
		'simpleStringConstant',
		'stringConstant',
		'colon',
		'constant',
		'argument',
		'exceptionCase',
		'plpgsqlCursorDeclarationParameters',
		'plpgsqlCursorDeclarationParameter',
		'plpgsqlCursorDeclarationParameterType'
	],
	#category : #'PostgreSQL-Parser-Grammars-PLpgSQL'
}

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> crudQueryParser [
	^ PSQLCRUDQueryGrammar
]

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> dependencies [
	^ { self expressionParser . self crudQueryParser . self selectQueryParser . self tokenParser }
]

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> selectQueryParser [
	^ PSQLSelectQueryGrammar
]

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> startSymbol [
	^ #startEnd
]

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> tokenParser [
	^ PSQLTokenizer
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> argument [
	^ (identifier trim , ':=' asParser) trim optional , expression trim
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> closeBracket [
	^ (self dependencyAt: self class tokenParser) closeBracket
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> closeParenthesis [
	^ (self dependencyAt: self class tokenParser) closeParenthesis
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> colon [
	^ (self dependencyAt: self class tokenParser) colon
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> comma [
	^ (self dependencyAt: self class tokenParser) comma
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> constant [
	^ (self dependencyAt: self class tokenParser) constant
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> deleteCommand [
	^ (self dependencyAt: self class crudQueryParser) deleteCommand
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> escapeStringConstant [
	^ (self dependencyAt: self class tokenParser) escapeStringConstant
]

{ #category : #'control structure' }
PSQLPlpgSQLGrammar >> exceptionCase [
	"WHEN condition [ OR condition ... ] THEN
        	handler_statements
    	"

	^ self whenExpression , kw then trim , plpgsqlStatements
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> expression [
	^ (self expressionParser) expression
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> identifier [
	^ (self dependencyAt: self class tokenParser) identifier
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> identifierOrKeyword [
	^ (self dependencyAt: self class tokenParser) identifierOrKeyword
]

{ #category : #initialization }
PSQLPlpgSQLGrammar >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> insertCommand [
	^ (self dependencyAt: self class crudQueryParser) insertCommand
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> numericConstant [
	^ (self dependencyAt: self class tokenParser) numericConstant
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> openBracket [
	^ (self dependencyAt: self class tokenParser) openBracket
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> openParenthesis [
	^ (self dependencyAt: self class tokenParser) openParenthesis
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlAliasDeclaration [
	^ identifier trim , identifier trim , kw for trim , (plpgsqlIndexParameter trim / identifier trim)
]

{ #category : #loop }
PSQLPlpgSQLGrammar >> plpgsqlArrayLoop [
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

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlAssertStatement [
	"ASSERT condition [ , message ]"
	^ kw assert trim , expression trim , (comma trim , expression) optional
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlAssignmentLeftPart [
	^ (identifier , ($. asParser , identifier) star) , (self subscriptWith: expression) star
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlAssignmentStatement [
	^ plpgsqlAssignmentLeftPart trim , (':=' asParser / $= asParser) trim , expression
]

{ #category : #label }
PSQLPlpgSQLGrammar >> plpgsqlBeginLabel [
	^ '<<' asParser trim , plpgsqlLabel , '>>' asParser trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlBlock [
	^ plpgsqlBeginLabel trim optional ,
	(kw declare trim , plpgsqlDeclarations trim optional) optional ,
	kw begin trim ,
	plpgsqlStatements trim ,
	kw endKeyword trim ,
	plpgsqlEndLabel trim optional , semicolon trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlBody [
	^ plpgsqlBlock
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlClassicDeclaration [
	^ identifier trim ,
	kw constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(kw notKeyword trim , kw null trim) optional ,
	((kw default trim / ':=' asParser trim / $= asParser trim) , expression) optional
]

{ #category : #conditional }
PSQLPlpgSQLGrammar >> plpgsqlConditional [
	^ plpgsqlIfThen / plpgsqlIfThenElse / plpgsqlIfThenElsif / plpgsqlSimpleCase / plpgsqlSearchedCase
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlContinueStatement [
	"CONTINUE [ label ] [ WHEN boolean-expression ]"
	^ kw continue trim , plpgsqlLabel trim optional , self whenExpression trim optional
]

{ #category : #'control structure' }
PSQLPlpgSQLGrammar >> plpgsqlControlStructure [
	^ plpgsqlReturn / plpgsqlConditional / plpgsqlLoop / plpgsqlExceptionHandler
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlCopyTypeDeclaration [
	^ identifier trim , identifier , $. asParser , identifier , '%TYPE' asParser caseInsensitive
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlCurrentResultValueStatement [
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ kw get trim , kw current trim optional , kw diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorClose [
	"CLOSE cursor"
	^ kw close trim , identifier
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorDeclaration [
	"name [ [ NO ] SCROLL ] CURSOR [ ( arguments ) ] FOR query"
	^ identifier trim , (kw no trim optional , kw scroll) trim optional , kw cursor trim ,
	(openParenthesis trim , 
		plpgsqlCursorDeclarationParameters , 
	closeParenthesis trim) trim optional ,
	kw for trim , selectCommand
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorDeclarationParameter [
	^ identifier trim , plpgsqlCursorDeclarationParameterType
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorDeclarationParameterType [
	^ identifierOrKeyword trim plus
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorDeclarationParameters [
	^ plpgsqlCursorDeclarationParameter plus separatedBy: comma trim
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorDelete [
	"DELETE FROM table WHERE CURRENT OF cursor"
	^ kw delete trim , kw from trim , identifier trim , kw whereKeyword trim , kw current trim , kw of trim , identifier
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorFetch [
	"FETCH [ direction { FROM | IN } ] cursor INTO target"
	^ kw fetch trim , 
	(plpgsqlFetchCursorDirection trim , (kw from / kw in)) trim optional ,
	identifier trim , kw into trim , (expression separatedBy: comma trim)
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorForLoop [
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

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorMove [
	"MOVE [ direction { FROM | IN } ] cursor"
	^ kw move trim ,
	(plpgsqlMoveCursorDirection trim , (kw from / kw in)) trim optional ,
	identifier
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorStatement [
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

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlCursorUpdate [
	"UPDATE table SET ... WHERE CURRENT OF cursor"
	^ kw update trim , identifier trim , kw set trim , 
	((identifier trim , $= asParser trim , expression) plus separatedBy: comma trim) ,
	kw whereKeyword trim , kw current trim , kw of trim , identifier
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlDeclarationCollate [
	^ kw collate trim , quotedIdentifier trim
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlDeclarationItem [
	^ plpgsqlCursorDeclaration / plpgsqlRowTypeDeclaration / plpgsqlCopyTypeDeclaration / plpgsqlAliasDeclaration / plpgsqlClassicDeclaration / plpgsqlRecordDeclaration
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlDeclarationType [
	^ kw collate not , kw notKeyword not , kw default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , 
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) optional ,
	(openBracket trim , closeBracket trim) plus optional
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlDeclarations [
	^ (plpgsqlDeclarationItem trim separatedBy: semicolon trim) , semicolon trim
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlDeclareBlock [
	^ plpgsqlBeginLabel trim optional ,
	(kw declare trim , plpgsqlDeclarations trim) optional ,
	kw begin trim ,
	plpgsqlStatements trim ,
	kw endKeyword trim ,
	plpgsqlEndLabel trim optional , semicolon trim
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlDeclareExceptionHandler [
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
		(self whenExpression , kw then trim , plpgsqlStatements) plus ,
	kw endKeyword trim
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlDefaultClassicDeclaration [
	^ identifier trim ,
	kw constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(kw notKeyword trim , kw null trim) optional ,
	((kw default trim / ':=' asParser trim / $= asParser trim) , expression) optional
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlDefaultDeclarationType [
	^ kw collate not , kw notKeyword not , kw default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , (
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) /
	(openBracket trim , closeBracket trim) plus) optional
]

{ #category : #label }
PSQLPlpgSQLGrammar >> plpgsqlEndLabel [
	^ plpgsqlLabel
]

{ #category : #'control structure' }
PSQLPlpgSQLGrammar >> plpgsqlExceptionHandler [
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
		exceptionCase plus ,
	kw endKeyword trim
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlExecuteStatement [
	"EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ]"
	^ kw execute trim , expression trim ,
	(kw into trim , kw strict trim optional , identifier) trim optional ,
	(kw using trim, (expression plus separatedBy: comma trim))
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlExitStatement [
	"EXIT [ label ] [ WHEN boolean-expression ]"

	^ kw exit trim , plpgsqlLabel trim optional , self whenExpression trim optional
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlFetchCursorDirection [
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

{ #category : #loop }
PSQLPlpgSQLGrammar >> plpgsqlForLoop [
	^ plpgsqlBeginLabel trim optional ,
	kw for trim , identifier trim , kw in trim , kw reverse trim optional , 
	(identifier / constant / expression) , "This is a bit hacky. It should be an expression but the expression parser does not handle well to parse an expression followed by '..'."
	'..' asParser trim , expression , 
	(kw by trim , expression) trim optional , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlEndLabel trim optional
]

{ #category : #conditional }
PSQLPlpgSQLGrammar >> plpgsqlIfThen [
	"IF boolean-expression THEN
    	statements
	END IF"
	^ kw if trim , expression trim , kw then trim ,
		plpgsqlStatements trim ,
	kw endKeyword trim , kw if trim
]

{ #category : #conditional }
PSQLPlpgSQLGrammar >> plpgsqlIfThenElse [
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

{ #category : #conditional }
PSQLPlpgSQLGrammar >> plpgsqlIfThenElsif [
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
PSQLPlpgSQLGrammar >> plpgsqlIndexParameter [
	^ $$ asParser , #digit asParser plus
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlIntoQueryStatement [
	^ selectIntoCommand
]

{ #category : #label }
PSQLPlpgSQLGrammar >> plpgsqlLabel [
	^ identifier
]

{ #category : #loop }
PSQLPlpgSQLGrammar >> plpgsqlLoop [
	^ plpgsqlLoopLoop / plpgsqlWhileLoop / plpgsqlForLoop / plpgsqlQueryResultsLoop / plpgsqlArrayLoop
]

{ #category : #loop }
PSQLPlpgSQLGrammar >> plpgsqlLoopLoop [
	"[ <<label>> ]
	LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	kw loop trim , plpgsqlStatements ,
	kw endKeyword trim , kw loop trim ,
	plpgsqlEndLabel trim optional
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlMoveCursorDirection [
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

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlNullStatement [
	^ kw null trim / kw endKeyword not not trim
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlOpenCursorBounded [
	"OPEN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ]"
	^ kw open trim , identifier trim , 
	( openParenthesis trim , 
		(argument separatedBy: comma trim) ,
	closeParenthesis trim ) optional
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlOpenCursorForExecute [
	"OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR EXECUTE query_string [ USING expression [, ... ] ]"
	^ kw open trim , identifier trim ,
		(kw no trim optional , kw scroll trim) trim optional ,
		kw for trim , kw execute trim , expression trim , "This expression has to lead to a String"
		(kw using trim , (expression plus separatedBy: comma trim)) optional
]

{ #category : #cursor }
PSQLPlpgSQLGrammar >> plpgsqlOpenCursorForQuery [
	"OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR query"
	^ kw open trim , identifier trim , 
		(kw no trim optional , kw scroll trim) trim optional ,
		kw for trim , 
		selectCommand trim
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlPerformStatement [
	^ kw perform trim , (semicolon not , #any asParser) plus flatten
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlQuery [
	^ selectCommand / insertCommand / updateCommand / deleteCommand
]

{ #category : #loop }
PSQLPlpgSQLGrammar >> plpgsqlQueryResultsLoop [
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

{ #category : #raise }
PSQLPlpgSQLGrammar >> plpgsqlRaiseLevel [
	^ kw debug / kw log / kw info / kw notice / kw warning / kw exception
]

{ #category : #raise }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement [
	"RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ]
	RAISE [ level ] condition_name [ USING option = expression [, ... ] ]
	RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]
	RAISE [ level ] USING option = expression [, ... ]
	RAISE "
	^ plpgsqlRaiseStatement1 / plpgsqlRaiseStatement2 /plpgsqlRaiseStatement3 / plpgsqlRaiseStatement4 / plpgsqlRaiseStatement5
]

{ #category : #raise }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement1 [
	"RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , simpleStringConstant trim , (expression star separatedBy: comma trim) , plpgsqlRaiseUsingOptions optional
]

{ #category : #raise }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement2 [
	"RAISE [ level ] condition_name [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , identifier trim , plpgsqlRaiseUsingOptions optional
]

{ #category : #raise }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement3 [
	"RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , 'SQLSTATE' asParser trim , simpleStringConstant trim ,
	plpgsqlRaiseUsingOptions optional
]

{ #category : #raise }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement4 [
	"RAISE [ level ] USING option = expression [, ... ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional ,
		plpgsqlRaiseUsingOptions
]

{ #category : #raise }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement5 [
	"RAISE"
	^ kw raise trim
]

{ #category : #raise }
PSQLPlpgSQLGrammar >> plpgsqlRaiseUsingOptions [
	^  kw using trim , ((identifier trim , $= asParser trim , expression) plus separatedBy: comma trim)
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlRecordDeclaration [
	^ identifier trim , kw record
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlResultValueStatement [
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ kw get trim , kw current trim optional , kw diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)
]

{ #category : #return }
PSQLPlpgSQLGrammar >> plpgsqlReturn [
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

{ #category : #return }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm1 [
	^ kw return trim  , expression
]

{ #category : #return }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm2 [
	^ kw return trim , kw next trim , expression
]

{ #category : #return }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm3 [
	^ kw return trim , kw query trim , plpgsqlQuery
]

{ #category : #return }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm4 [
	^ kw return trim , kw query trim , kw execute trim , stringConstant trim , (kw using trim , (expression plus separatedBy: comma trim)) optional
]

{ #category : #return }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm5 [
	^ kw return
]

{ #category : #declaration }
PSQLPlpgSQLGrammar >> plpgsqlRowTypeDeclaration [
	^ identifier trim , identifier , '%ROWTYPE' asParser caseInsensitive
]

{ #category : #conditional }
PSQLPlpgSQLGrammar >> plpgsqlSearchedCase [
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

{ #category : #conditional }
PSQLPlpgSQLGrammar >> plpgsqlSimpleCase [
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
		(self whenExpression , kw then trim ,
			plpgsqlStatements) plus ,
		(kw else trim , plpgsqlStatements) optional ,
		kw endKeyword trim , kw case trim
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlStatement [
	^ plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlExitStatement / plpgsqlContinueStatement / plpgsqlRaiseStatement / plpgsqlAssertStatement / plpgsqlCursorStatement / plpgsqlControlStructure / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlNullStatement / plpgsqlQuery / expression
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlStatements [
	^ plpgsqlStatement trim , (semicolon trim , kw endKeyword not , plpgsqlStatement) trim star , semicolon trim optional
]

{ #category : #statement }
PSQLPlpgSQLGrammar >> plpgsqlUnhandledStatement [
	^ PPFailingParser new
]

{ #category : #loop }
PSQLPlpgSQLGrammar >> plpgsqlWhileLoop [
	^ plpgsqlBeginLabel trim optional ,
	kw while trim , expression , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlLabel trim optional
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> positionalParameter [
	^ (self expressionParser) positionalParameter
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> quotedIdentifier [
	^ (self dependencyAt: self class tokenParser) quotedIdentifier
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> selectCommand [
	^ (self dependencyAt: self class crudQueryParser) selectCommand
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> selectIntoCommand [
	^ (self dependencyAt: self class selectQueryParser) selectIntoCommand
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> semicolon [
	^ (self dependencyAt: self class tokenParser) semicolon
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> simpleStringConstant [
	^ (self dependencyAt: self class tokenParser) simpleStringConstant
]

{ #category : #accessing }
PSQLPlpgSQLGrammar >> start [
	^ plpgsqlBody trim
]

{ #category : #accessing }
PSQLPlpgSQLGrammar >> startEnd [
	^ self start end
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> stringConstant [
	^ (self dependencyAt: self class tokenParser) stringConstant
]

{ #category : #duplicated }
PSQLPlpgSQLGrammar >> subscriptWith: expressionParser [
	^ openBracket , expressionParser , (colon , expressionParser) optional , closeBracket
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> updateCommand [
	^ (self dependencyAt: self class crudQueryParser) updateCommand
]
