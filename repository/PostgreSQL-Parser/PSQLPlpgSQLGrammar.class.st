"
I parse PL/pgSQL source code. 
"
Class {
	#name : #PSQLPlpgSQLGrammar,
	#superclass : #PSQLTokenizer,
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
		'plpgsqlDeclarationType'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> dependencies [
	^ { self sqlParser . self insertQueryParser }
]

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> insertQueryParser [
	^ PSQLInsertQueryGrammar
]

{ #category : #accessing }
PSQLPlpgSQLGrammar class >> sqlParser [
	^ PSQLGrammar
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> deleteCommand [
	^ (self dependencyAt: self class sqlParser) deleteCommand
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> escapeStringConstant [
	^ (self dependencyAt: self class sqlParser) escapeStringConstant
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> expression [
	^ (self dependencyAt: self class sqlParser) expression
]

{ #category : #helpers }
PSQLPlpgSQLGrammar >> identifier [
	^ (self dependencyAt: self class sqlParser) identifier
]

{ #category : #helpers }
PSQLPlpgSQLGrammar >> identifierOrKeyword [
	^ (self dependencyAt: self class sqlParser) identifierOrKeyword
]

{ #category : #helpers }
PSQLPlpgSQLGrammar >> identifierWithOptionalFieldAccess [
	^ (self dependencyAt: self class sqlParser) identifierWithOptionalFieldAccess
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> insertCommand [
	^ (self dependencyAt: self class insertQueryParser) insertCommand
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> numericConstant [
	^ (self dependencyAt: self class sqlParser) numericConstant
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlAliasDeclaration [
	^ identifier trim , identifier trim , kw for trim , (plpgsqlIndexParameter trim / identifier trim)
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlAssertStatement [
	"ASSERT condition [ , message ]"
	^ kw assert trim , expression trim , (comma trim , expression) optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlAssignmentLeftPart [
	^ (identifier , ($. asParser , identifier) star) , (self subscriptWith: expression) star
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlAssignmentStatement [
	^ plpgsqlAssignmentLeftPart trim , (':=' asParser / $= asParser) trim , expression
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlClassicDeclaration [
	^ identifier trim ,
	kw constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(kw notKeyword trim , kw null trim) optional ,
	((kw default trim / ':=' asParser trim / $= asParser trim) , expression) optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlConditional [
	^ plpgsqlIfThen / plpgsqlIfThenElse / plpgsqlIfThenElsif / plpgsqlSimpleCase / plpgsqlSearchedCase
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlContinueStatement [
	"CONTINUE [ label ] [ WHEN boolean-expression ]"
	^ kw continue trim , plpgsqlLabel trim optional , (kw when trim , expression) trim optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlControlStructure [
	^ plpgsqlReturn / plpgsqlConditional / plpgsqlLoop / plpgsqlExceptionHandler
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlCopyTypeDeclaration [
	^ identifier trim , identifier , $. asParser , identifier , '%TYPE' asParser caseInsensitive
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlCurrentResultValueStatement [
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ kw get trim , kw current trim optional , kw diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlCursorClose [
	"CLOSE cursor"
	^ kw close trim , identifier
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlCursorDeclaration [
	"name [ [ NO ] SCROLL ] CURSOR [ ( arguments ) ] FOR query"
	^ identifier trim , (kw no trim optional , kw scroll) trim optional , kw cursor trim ,
	(openParenthesis trim , 
		((identifier trim , identifierOrKeyword trim plus) plus separatedBy: comma trim) , 
	closeParenthesis trim) trim optional ,
	kw for trim , selectCommand
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlCursorDelete [
	"DELETE FROM table WHERE CURRENT OF cursor"
	^ kw delete trim , kw from trim , identifier trim , kw whereKeyword trim , kw current trim , kw of trim , identifier
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlCursorFetch [
	"FETCH [ direction { FROM | IN } ] cursor INTO target"
	^ kw fetch trim , 
	(plpgsqlFetchCursorDirection trim , (kw from / kw in)) trim optional ,
	identifier trim , kw into trim , (expression plus separatedBy: comma trim)
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlCursorMove [
	"MOVE [ direction { FROM | IN } ] cursor"
	^ kw move trim ,
	(plpgsqlMoveCursorDirection trim , (kw from / kw in)) trim optional ,
	identifier
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlCursorUpdate [
	"UPDATE table SET ... WHERE CURRENT OF cursor"
	^ kw update trim , identifier trim , kw set trim , 
	((identifier trim , $= asParser trim , expression) plus separatedBy: comma trim) ,
	kw whereKeyword trim , kw current trim , kw of trim , identifier
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlDeclarationCollate [
	^ kw collate trim , quotedIdentifier trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlDeclarationItem [
	^ plpgsqlCursorDeclaration / plpgsqlRowTypeDeclaration / plpgsqlCopyTypeDeclaration / plpgsqlAliasDeclaration / plpgsqlClassicDeclaration / plpgsqlRecordDeclaration
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlDeclarationType [
	^ kw collate not , kw notKeyword not , kw default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , 
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) optional ,
	(openBracket trim , closeBracket trim) plus optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlDeclarations [
	^ (plpgsqlDeclarationItem trim separatedBy: semicolon trim) , semicolon trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlDeclareBlock [
	^ plpgsqlBeginLabel trim optional ,
	(kw declare trim , plpgsqlDeclarations trim) optional ,
	kw begin trim ,
	plpgsqlStatements trim ,
	kw endKeyword trim ,
	plpgsqlEndLabel trim optional , semicolon trim
]

{ #category : #plpgsql }
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
		(kw when trim , expression , kw then trim , plpgsqlStatements) plus ,
	kw endKeyword trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlDefaultClassicDeclaration [
	^ identifier trim ,
	kw constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(kw notKeyword trim , kw null trim) optional ,
	((kw default trim / ':=' asParser trim / $= asParser trim) , expression) optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlDefaultDeclarationType [
	^ kw collate not , kw notKeyword not , kw default not , ':=' asParser not , '=' asParser not , identifierOrKeyword trim plus , (
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) /
	(openBracket trim , closeBracket trim) plus) optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlEndLabel [
	^ plpgsqlLabel
]

{ #category : #plpgsql }
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
		(kw when trim , expression , kw then trim , plpgsqlStatements) plus ,
	kw endKeyword trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlExecuteStatement [
	"EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ]"
	^ kw execute trim , expression trim ,
	(kw into trim , kw strict trim optional , identifier) trim optional ,
	(kw using trim, (expression plus separatedBy: comma trim))
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlExitStatement [
	"EXIT [ label ] [ WHEN boolean-expression ]"
	^ kw exit trim , plpgsqlLabel trim optional , (kw when trim , expression) trim optional
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlForLoop [
	^ plpgsqlBeginLabel trim optional ,
	kw for trim , identifier trim , kw in trim , kw reverse trim optional , expression , '..' asParser trim , expression , (kw by trim , expression) trim optional , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlEndLabel trim optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlIfThen [
	"IF boolean-expression THEN
    	statements
	END IF"
	^ kw if trim , expression trim , kw then trim ,
		plpgsqlStatements trim ,
	kw endKeyword trim , kw if trim
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlIntoQueryStatement [
	^ selectIntoCommand
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlLabel [
	^ identifier
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlLoop [
	^ plpgsqlLoopLoop / plpgsqlWhileLoop / plpgsqlForLoop / plpgsqlQueryResultsLoop / plpgsqlArrayLoop
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlNullStatement [
	^ kw null trim / kw endKeyword not not trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlOpenCursorBounded [
	"OPEN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ]"
	^ kw open trim , identifier trim , 
	( openParenthesis trim , 
		(((identifier trim , ':=' asParser) trim optional , expression trim) plus separatedBy: comma trim) ,
	closeParenthesis trim ) optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlOpenCursorForExecute [
	"OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR EXECUTE query_string [ USING expression [, ... ] ]"
	^ kw open trim , identifier trim ,
		(kw no trim optional , kw scroll trim) trim optional ,
		kw for trim , kw execute trim , expression trim , "This expression has to lead to a String"
		(kw using trim , (expression plus separatedBy: comma trim)) optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlOpenCursorForQuery [
	"OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR query"
	^ kw open trim , identifier trim , 
		(kw no trim optional , kw scroll trim) trim optional ,
		kw for trim , 
		selectCommand trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlPerformStatement [
	^ kw perform trim , (semicolon not , #any asParser) plus
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlQuery [
	^ selectCommand / insertCommand / updateCommand / deleteCommand
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRaiseLevel [
	^ kw debug / kw log / kw info / kw notice / kw warning / kw exception
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement [
	"RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ]
	RAISE [ level ] condition_name [ USING option = expression [, ... ] ]
	RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]
	RAISE [ level ] USING option = expression [, ... ]
	RAISE "
	^ plpgsqlRaiseStatement1 / plpgsqlRaiseStatement2 /plpgsqlRaiseStatement3 / plpgsqlRaiseStatement4 / plpgsqlRaiseStatement5
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement1 [
	"RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , simpleStringConstant trim , (expression star separatedBy: comma trim) , plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement2 [
	"RAISE [ level ] condition_name [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , identifier trim , plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement3 [
	"RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , 'SQLSTATE' asParser trim , simpleStringConstant trim ,
	plpgsqlRaiseUsingOptions optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement4 [
	"RAISE [ level ] USING option = expression [, ... ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional ,
		plpgsqlRaiseUsingOptions
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRaiseStatement5 [
	"RAISE"
	^ kw raise trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRaiseUsingOptions [
	^  kw using trim , ((identifier trim , $= asParser trim , expression) plus separatedBy: comma trim)
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRecordDeclaration [
	^ identifier trim , kw record
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlResultValueStatement [
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ kw get trim , kw current trim optional , kw diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm1 [
	^ kw return trim  , expression
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm2 [
	^ kw return trim , kw next trim , expression
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm3 [
	^ kw return trim , kw query trim , plpgsqlQuery
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm4 [
	^ kw return trim , kw query trim , kw execute trim , stringConstant trim , (kw using trim , (expression plus separatedBy: comma trim)) optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlReturnForm5 [
	^ kw return
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlRowTypeDeclaration [
	^ identifier trim , identifier , '%ROWTYPE' asParser caseInsensitive
]

{ #category : #plpgsql }
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

{ #category : #plpgsql }
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
		(kw when trim , expression , kw then trim ,
			plpgsqlStatements) plus ,
		(kw else trim , plpgsqlStatements) optional ,
		kw endKeyword trim , kw case trim
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlStatement [
	^ plpgsqlPerformStatement / plpgsqlExecuteStatement / plpgsqlExitStatement / plpgsqlContinueStatement / plpgsqlRaiseStatement / plpgsqlAssertStatement / plpgsqlCursorStatement / plpgsqlControlStructure / plpgsqlAssignmentStatement / plpgsqlIntoQueryStatement / plpgsqlResultValueStatement / plpgsqlNullStatement / plpgsqlQuery / expression
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlStatements [
	^ plpgsqlStatement trim , (semicolon trim , kw endKeyword not , plpgsqlStatement) trim star , semicolon trim optional
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlUnhandledStatement [
	^ PPFailingParser new
]

{ #category : #plpgsql }
PSQLPlpgSQLGrammar >> plpgsqlWhileLoop [
	^ plpgsqlBeginLabel trim optional ,
	kw while trim , expression , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlLabel trim optional
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> positionalParameter [
	^ (self dependencyAt: self class sqlParser) positionalParameter
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> selectCommand [
	^ (self dependencyAt: self class sqlParser) selectCommand
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> selectIntoCommand [
	^ (self dependencyAt: self class sqlParser) selectIntoCommand
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> simpleStringConstant [
	^ (self dependencyAt: self class sqlParser) simpleStringConstant
]

{ #category : #accessing }
PSQLPlpgSQLGrammar >> start [
	^ plpgsqlBody trim end
]

{ #category : #duplicated }
PSQLPlpgSQLGrammar >> subscriptWith: expressionParser [
	^ openBracket , expressionParser , (colon , expressionParser) optional , closeBracket
]

{ #category : #dependencies }
PSQLPlpgSQLGrammar >> updateCommand [
	^ (self dependencyAt: self class sqlParser) updateCommand
]
