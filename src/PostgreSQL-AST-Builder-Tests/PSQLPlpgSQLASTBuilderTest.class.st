Class {
	#name : #PSQLPlpgSQLASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'PostgreSQL-AST-Builder-Tests'
}

{ #category : #running }
PSQLPlpgSQLASTBuilderTest >> setUp [
	builder := PSQLPlpgSQLASTBuilder new
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlAliasDeclaration [
	| node |
	node := builder plpgsqlAliasDeclaration parse: 'id ALIAS FOR $1'.
	self
		assert: node class equals: PSQLPlpgSQLASTAliasDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node aliased identifier equals: '$1'.
		
	node := builder plpgsqlAliasDeclaration parse: 'id ALIAS FOR identifier'.
	self
		assert: node class equals: PSQLPlpgSQLASTAliasDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node aliased identifier equals: 'identifier'
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlArrayLoop [
	| node |
	node := builder plpgsqlArrayLoop parse: 'FOREACH x IN ARRAY $1
  LOOP
    s := s + x;
    t := s;
  END LOOP'.
	self
		assert: node class equals: PSQLPlpgSQLASTArrayLoop;
		assert: node beginLabel isNil;
		assert: node endLabel isNil;
		assert: node statements size equals: 2;
		assert: node target class equals: PSQLASTIdentifier;
		assert: node arrayExpression class equals: PSQLPlpgSQLASTPositionalParameter;
		assert: node sliceNumber isNil
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlAssignmentLeftPart [
	| node |
	node := builder plpgsqlAssignmentLeftPart parse: 'truc.machin[id][3]'.
	self
		assert: node class equals: PSQLASTSubscript;
		assert: node target class equals: PSQLASTSubscript;
		assert: node target target class equals: PSQLASTAttributeAccess;
		assert: node target target accessed class equals: PSQLASTIdentifier
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlAssignmentStatement [
	| node |
	node := builder plpgsqlAssignmentStatement parse: 'truc.machin[id][3] := 42'.
	self
		assert: node class equals: PSQLPlpgSQLASTAssignment;
		assert: node operator equals: ':=';
		assert: node target class equals: PSQLASTSubscript;
		assert: node toAssign class equals: PSQLASTNumericConstant
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlBeginLabel [
	| node |
	node := builder plpgsqlBeginLabel parse: '<<label>>'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node labelContent equals: 'label'
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlBlock [
	| node |
	node := builder plpgsqlBlock parse: '<<label>>
DECLARE
	id ALIAS FOR $1;
	var INTEGER;
BEGIN
	var := id + 1;
END
label;'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTBlock;
		assert: node declarations size equals: 2;
		assert: node statements size equals: 1;
		assert: node label class equals: PSQLPlpgSQLASTBlockLabel
		
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlClassicDeclaration [
	| node |
	node := builder plpgsqlClassicDeclaration parse: 'id integer'.
	self
		assert: node class equals: PSQLPlpgSQLASTClassicDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node type identifier identifier equals: 'integer'
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlContinueStatement [
	| node |
	node := builder plpgsqlContinueStatement parse: 'CONTINUE WHEN count < 50'.
	self
		assert: node class equals: PSQLPlpgSQLASTContinue;
		assert: node label isNil;
		assert: node whenExpression class equals: PSQLASTWhenExpression 
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlCopyTypeDeclaration [
	| node |
	node := builder plpgsqlCopyTypeDeclaration parse: 'user_id users.user_id%TYPE'.
	self
		assert: node class equals: PSQLPlpgSQLASTCopyTypeDeclaration;
		assert: node accessToCopyType accessed identifier equals: 'users';
		assert: node accessToCopyType attributeIdentifier identifier equals: 'user_id'
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlCursorClose [
	| node |
	node := builder plpgsqlCursorClose parse: 'CLOSE cursor'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorClose;
		assert: node cursorIdentifier class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier identifier equals: 'cursor'
]

{ #category : #'tests-cursor' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlCursorDeclaration [
	| node |
	node := builder plpgsqlCursorDeclaration parse: 'curs CURSOR FOR SELECT * FROM t'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorDeclaration;
		assert: node identifier class equals: PSQLASTIdentifier;
		assert: node identifier identifier equals: 'curs';
		assert: node scroll;
		assert: node arguments class equals: Array;
		assert: node arguments size equals: 0;
		assert: node selectQuery class equals: PSQLASTSelectQuery.
		
	node := builder plpgsqlCursorDeclaration parse: 'curs SCROLL CURSOR FOR SELECT * FROM t'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorDeclaration;
		assert: node identifier class equals: PSQLASTIdentifier;
		assert: node identifier identifier equals: 'curs';
		assert: node scroll;
		assert: node arguments class equals: Array;
		assert: node arguments size equals: 0;
		assert: node selectQuery class equals: PSQLASTSelectQuery.
		
	node := builder plpgsqlCursorDeclaration parse: 'curs NO SCROLL CURSOR (key integer, key2 varchar) FOR SELECT * FROM t'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorDeclaration;
		assert: node identifier class equals: PSQLASTIdentifier;
		assert: node identifier identifier equals: 'curs';
		deny: node scroll;
		assert: node arguments class equals: Array;
		assert: node arguments size equals: 2;
		assert: (node arguments allSatisfy: [ :any | any class = PSQLASTCursorParameter ]);
		assert: node selectQuery class equals: PSQLASTSelectQuery
]

{ #category : #'tests-cursor' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlCursorDelete [
	| node |
	node := builder plpgsqlCursorDelete parse: 'DELETE FROM table WHERE CURRENT OF curs'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorDelete;
		assert: node tableIdentifier class equals: PSQLASTIdentifier;
		assert: node tableIdentifier identifier equals: 'table';
		assert: node cursorIdentifier class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier identifier equals: 'curs'
]

{ #category : #'tests-cursor' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlCursorFetch [
	| node |
	node := builder plpgsqlCursorFetch parse: 'FETCH curs INTO x,y,z'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorFetch;
		assert: node direction isNil;
		assert: node isFrom isNil;
		deny: node hasDirection;
		assert: node cursorIdentifier class equals: PSQLASTAttributeAccess;
		assert: node cursorIdentifier accessed class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier accessed identifier equals: 'curs';
		assert: node targets class equals: Array;
		assert: node targets size equals: 3.
		
	node := builder plpgsqlCursorFetch parse: 'FETCH NEXT IN curs INTO x'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorFetch;
		assert: node direction class equals: PSQLPlpgSQLASTCursorFetchDirection;
		deny: node isFrom;
		assert: node isIn;
		assert: node hasDirection;
		assert: node cursorIdentifier class equals: PSQLASTAttributeAccess;
		assert: node cursorIdentifier accessed class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier accessed identifier equals: 'curs';
		assert: node targets class equals: Array;
		assert: node targets size equals: 1.
]

{ #category : #'tests-cursor' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlCursorMove [
	| node |
	node := builder plpgsqlCursorMove parse: 'MOVE curs'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorMove;
		deny: node hasDirection;
		assert: node direction isNil;
		assert: node isFrom isNil;
		assert: node cursorIdentifier class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier identifier equals: 'curs'.
		
	node := builder plpgsqlCursorMove parse: 'MOVE FORWARD ALL IN curs'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorMove;
		assert: node hasDirection;
		assert: node direction class equals: PSQLPlpgSQLASTCursorMoveDirection;
		deny: node isFrom;
		assert: node isIn;
		assert: node cursorIdentifier class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier identifier equals: 'curs'.
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlDeclarationType [
	| node |
	node := builder plpgsqlDeclarationType parse: 'varying char(16)[][]'.
	self
		assert: node class equals: PSQLPlpgSQLASTType;
		assert: node identifier identifier equals: 'varying char';
		assert: node size equals: 16;
		assert: node dimensions equals: 2
]

{ #category : #'tests-cursor' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlFetchCursorDirection [
	| node |
	node := builder plpgsqlFetchCursorDirection parse: 'NEXT'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorFetchDirection;
		assert: node name equals: 'NEXT';
		assert: node count isNil;
		deny: node hasCount.
		
	node := builder plpgsqlFetchCursorDirection parse: 'ABSOLUTE 42'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorFetchDirection;
		assert: node name equals: 'ABSOLUTE';
		assert: node hasCount;
		assert: node count equals: 42.
		
	node := builder plpgsqlFetchCursorDirection parse: 'RELATIVE -42'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorFetchDirection;
		assert: node name equals: 'RELATIVE';
		assert: node hasCount;
		assert: node count equals: -42
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlForLoop [
	| node |
	node := builder plpgsqlForLoop parse: '<<forlabel>>
FOR i IN 1 .. 10 LOOP
    NULL;
END LOOP forlabel'.
	self
		assert: node class equals: PSQLPlpgSQLASTForLoop;
		assert: node beginLabel class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node endLabel class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node statements size equals: 1;
		assert: node target class equals: PSQLASTIdentifier;
		assert: node fromExpression class equals: PSQLASTNumericConstant;
		assert: node toExpression class equals: PSQLASTNumericConstant
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlIfThen [
	| node |
	node := builder plpgsqlIfThen parse: 'IF x = 1 THEN
	stmt := 1;
	stmt := stmt +1;
END IF'.
	self
		assert: node class equals: PSQLPlpgSQLASTIf;
		assert: node conditionToStatements size equals: 1;
		assert: node conditionToStatements first condition class equals: PSQLASTBinaryOperator;
		assert: node conditionToStatements first statements size equals: 2
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlIfThenElse [
	| node |
	node := builder plpgsqlIfThenElse parse: 'IF x = 1 THEN
	stmt := 1;
ELSE
	stmt := stmt +1;
END IF'.
	self
		assert: node class equals: PSQLPlpgSQLASTIf;
		assert: node conditionToStatements size equals: 1;
		assert: node conditionToStatements first condition class equals: PSQLASTBinaryOperator;
		assert: node conditionToStatements first statements size equals: 1;
		assert: node elseStatements size equals: 1
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlIfThenElsif [
	| node |
	node := builder plpgsqlIfThenElsif parse: 'IF x = 1 THEN
	stmt := 1;
ELSE IF x = 2 THEN
	stmt := 2;
ELSIF x = 3 THEN
	stmt := 3;
ELSE
	stmt := stmt +1;
END IF'.
	self
		assert: node class equals: PSQLPlpgSQLASTIf;
		assert: node conditionToStatements size equals: 3;
		assert: node conditionToStatements first condition class equals: PSQLASTBinaryOperator;
		assert: node conditionToStatements first statements size equals: 1;
		assert: node conditionToStatements second condition class equals: PSQLASTBinaryOperator;
		assert: node conditionToStatements second statements size equals: 1;
		assert: node conditionToStatements third condition class equals: PSQLASTBinaryOperator;
		assert: node conditionToStatements third statements size equals: 1;
		assert: node elseStatements size equals: 1
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlIndexParameter [
	| node |
	node := builder plpgsqlIndexParameter parse: '$1'.
	
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: '$1'
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlLabel [
	| node |
	node := builder plpgsqlLabel parse: 'label'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node labelContent equals: 'label'
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlLoopLoop [
	| node |
	node := builder plpgsqlLoopLoop parse: 'LOOP
    amount_owed := amount_owed + 1;
END LOOP'.
	self
		assert: node class equals: PSQLPlpgSQLASTLoop;
		assert: node beginLabel isNil;
		assert: node endLabel isNil;
		assert: node statements size equals: 1
]

{ #category : #'tests-cursor' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlMoveCursorDirection [
	| node |
	node := builder plpgsqlMoveCursorDirection parse: 'NEXT'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorMoveDirection;
		assert: node name equals: 'NEXT';
		assert: node count isNil;
		deny: node hasCount.
		
	node := builder plpgsqlMoveCursorDirection parse: 'ABSOLUTE 42'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorMoveDirection;
		assert: node name equals: 'ABSOLUTE';
		assert: node hasCount;
		assert: node count equals: 42.
		
	node := builder plpgsqlMoveCursorDirection parse: 'RELATIVE -42'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorMoveDirection;
		assert: node name equals: 'RELATIVE';
		assert: node hasCount;
		assert: node count equals: -42.
		
	node := builder plpgsqlMoveCursorDirection parse: 'FORWARD -42'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorMoveDirection;
		assert: node name equals: 'FORWARD';
		assert: node hasCount;
		assert: node count equals: -42;
		deny: node isCountAll.
		
	node := builder plpgsqlMoveCursorDirection parse: 'FORWARD ALL'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorMoveDirection;
		assert: node name equals: 'FORWARD';
		assert: node hasCount;
		assert: node count equals: 'ALL';
		assert: node isCountAll
]

{ #category : #'tests-cursor' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlOpenCursorForQuery [
	| node |
	node := builder plpgsqlOpenCursorForQuery parse: 'OPEN curs FOR SELECT * FROM t'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorOpenForQuery;
		assert: node cursorIdentifier class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier identifier equals: 'curs';
		assert: node scroll;
		assert: node selectQuery class equals: PSQLASTSelectQuery.
		
	node := builder plpgsqlOpenCursorForQuery parse: 'OPEN curs NO SCROLL FOR SELECT * FROM t'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorOpenForQuery;
		assert: node cursorIdentifier class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier identifier equals: 'curs';
		deny: node scroll;
		assert: node selectQuery class equals: PSQLASTSelectQuery.
		
	node := builder plpgsqlOpenCursorForQuery parse: 'OPEN curs SCROLL FOR SELECT * FROM t'.
	self
		assert: node class equals: PSQLPlpgSQLASTCursorOpenForQuery;
		assert: node cursorIdentifier class equals: PSQLASTIdentifier;
		assert: node cursorIdentifier identifier equals: 'curs';
		assert: node scroll;
		assert: node selectQuery class equals: PSQLASTSelectQuery.
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlQueryResultsLoop [
	| node |
	node := builder plpgsqlQueryResultsLoop parse: 'FOR mviews IN SELECT * FROM cs_materialized_views ORDER BY sort_key LOOP
	var := mviews;
END LOOP'.
	self
		assert: node class equals: PSQLPlpgSQLASTQueryResultsLoop;
		assert: node beginLabel isNil;
		assert: node endLabel isNil;
		assert: node target class equals: PSQLASTIdentifier;
		assert: node statements size equals: 1;
		assert: node query class equals: PSQLASTSelectQuery
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlRaiseStatement1 [
	| node |
	node := builder plpgsqlRaiseStatement1 parse: 'RAISE EXCEPTION ''Nonexistent ID --> %'', user_id
      USING HINT = ''Please check your user ID'''.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRaiseStatement;
		assert: node level equals: 'EXCEPTION';
		assert: node formatString class equals: PSQLASTStringConstant;
		assert: node formatString content equals: 'Nonexistent ID --> %';
		assert: node formatExpressions size equals: 1;
		assert: node usingAssocs size equals: 1
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlRaiseStatement2 [
	| node |
	node := builder plpgsqlRaiseStatement2 parse: 'RAISE EXCEPTION my_condition_name USING one = 1, string = ''str'''.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRaiseStatement;
		assert: node level equals: 'EXCEPTION';
		assert: node conditionName class equals: PSQLASTIdentifier;
		assert: node conditionName identifier equals: 'my_condition_name';
		assert: node usingAssocs isArray;
		assert: node usingAssocs size equals: 2;
		assert: node usingAssocs first class equals: Association;
		assert: node usingAssocs first key identifier equals: 'one';
		assert: node usingAssocs first value content equals: '1';
		assert: node usingAssocs second class equals: Association;
		assert: node usingAssocs second key identifier equals: 'string';
		assert: node usingAssocs second value content equals: 'str';
		assert: node formatExpressions isNil;
		assert: node formatString isNil;
		assert: node sqlState isNil
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlRaiseStatement3 [
	| node |
	node := builder plpgsqlRaiseStatement3 parse: 'RAISE EXCEPTION SQLSTATE ''sqlstate'' USING one = 1, string = ''str'''.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRaiseStatement;
		assert: node level equals: 'EXCEPTION';
		assert: node sqlState content equals: 'sqlstate';
		assert: node usingAssocs isArray;
		assert: node usingAssocs size equals: 2;
		assert: node usingAssocs first class equals: Association;
		assert: node usingAssocs first key identifier equals: 'one';
		assert: node usingAssocs first value content equals: '1';
		assert: node usingAssocs second class equals: Association;
		assert: node usingAssocs second key identifier equals: 'string';
		assert: node usingAssocs second value content equals: 'str';
		assert: node formatExpressions isNil;
		assert: node formatString isNil;
		assert: node conditionName isNil
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlRaiseStatement4 [
	| node |
	node := builder plpgsqlRaiseStatement4 parse: 'RAISE EXCEPTION USING one = 1, string = ''str'''.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRaiseStatement;
		assert: node level equals: 'EXCEPTION';
		assert: node usingAssocs isArray;
		assert: node usingAssocs size equals: 2;
		assert: node usingAssocs first class equals: Association;
		assert: node usingAssocs first key identifier equals: 'one';
		assert: node usingAssocs first value content equals: '1';
		assert: node usingAssocs second class equals: Association;
		assert: node usingAssocs second key identifier equals: 'string';
		assert: node usingAssocs second value content equals: 'str';
		assert: node formatExpressions isNil;
		assert: node formatString isNil;
		assert: node conditionName isNil;
		assert: node sqlState isNil
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlRaiseStatement5 [
	| node |
	node := builder plpgsqlRaiseStatement5 parse: 'RAISE'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRaiseStatement;
		assert: node conditionName isNil;
		assert: node formatExpressions isNil;
		assert: node formatString isNil;
		assert: node level isNil;
		assert: node sqlState isNil;
		assert: node usingAssocs isNil
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlRaiseUsingOptions [
	| assocs |
	assocs := builder plpgsqlRaiseUsingOptions parse: 'USING opt = 1 + 1, opt2 = ''test'''.
	
	self
		assert: assocs size equals: 2;
		assert: assocs first key class equals: PSQLASTIdentifier;
		assert: assocs first value class equals: PSQLASTBinaryOperator;
		assert: assocs second key class equals: PSQLASTIdentifier;
		assert: assocs second value class equals: PSQLASTStringConstant
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlRecordDeclaration [
	| node |
	node := builder plpgsqlRecordDeclaration parse: 'identifier RECORD'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRecordDeclaration;
		assert: node identifier identifier equals: 'identifier'
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlReturnForm1 [
	| node |
	node := builder plpgsqlReturnForm1 parse: 'RETURN 1+1'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnExpression;
		deny: node hasUsingExpressions;
		deny: node isEmptyReturn;
		deny: node isReturnQuery;
		deny: node isReturnQueryExecute;
		deny: node isReturnNext;
		assert: node expression class equals: PSQLASTBinaryOperator
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlReturnForm2 [
	| node |
	node := builder plpgsqlReturnForm2 parse: 'RETURN NEXT 1+1'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnNext;
		deny: node hasUsingExpressions;
		deny: node isEmptyReturn;
		deny: node isReturnQuery;
		deny: node isReturnQueryExecute;
		deny: node isReturnExpression;
		assert: node expression class equals: PSQLASTBinaryOperator
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlReturnForm3 [
	| node |
	node := builder plpgsqlReturnForm3 parse: 'RETURN QUERY SELECT * FROM table'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnQuery;
		deny: node hasUsingExpressions;
		deny: node isEmptyReturn;
		deny: node isReturnNext;
		deny: node isReturnQueryExecute;
		deny: node isReturnExpression;flag:#todo"
		assert: node query class equals: "
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlReturnForm4 [
	| node |
	node := builder plpgsqlReturnForm4 parse: 'RETURN QUERY EXECUTE ''SELECT flightid
                   FROM flight
                  WHERE flightdate >= $1
                    AND flightdate < ($1 + 1)'''.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnQueryExecute;
		assert: node queryExecute class equals: PSQLASTStringConstant;
		assert: node queryExecute content equals: 'SELECT flightid
                   FROM flight
                  WHERE flightdate >= $1
                    AND flightdate < ($1 + 1)';
		deny: node hasUsingExpressions;
		deny: node isEmptyReturn;
		deny: node isReturnNext;
		deny: node isReturnQuery;
		deny: node isReturnExpression
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlReturnForm4Bis [
	| node |
	node := builder plpgsqlReturnForm4 parse: 'RETURN QUERY EXECUTE ''SELECT flightid
                   FROM flight
                  WHERE % >=  %'' USING id, 2'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isReturnQueryExecute;
		assert: node queryExecute class equals: PSQLASTStringConstant;
		assert: node queryExecute content equals: 'SELECT flightid
                   FROM flight
                  WHERE % >=  %';
		assert: node hasUsingExpressions;
		assert: node usingExpressions size equals: 2;
		deny: node isEmptyReturn;
		deny: node isReturnNext;
		deny: node isReturnQuery;
		deny: node isReturnExpression
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlReturnForm5 [
	| node |
	node := builder plpgsqlReturnForm5 parse: 'RETURN'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTReturnStatement;
		assert: node isEmptyReturn;
		deny: node hasUsingExpressions;
		deny: node isReturnExpression;
		deny: node isReturnQuery;
		deny: node isReturnQueryExecute;
		deny: node isReturnNext
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlRowTypeDeclaration [
	| node |
	node := builder plpgsqlRowTypeDeclaration parse: 'id table%ROWTYPE'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRowTypeDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node tableIdentifier identifier equals: 'table'
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlSearchedCase [
	| node |
	node := builder plpgsqlSearchedCase
		parse:
			'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
	WHEN 3, 4 THEN
        msg := ''three or four'';
END CASE'.
	self
		assert: node class equals: PSQLPlpgSQLASTSearchedCase;
		assert: node searchedExpression class equals: PSQLASTAttributeAccess;
		assert: node conditionsToStatements size equals: 2;
		assert: node conditionsToStatements first cases size equals: 2;
		assert: node conditionsToStatements first statements size equals: 1;
		assert: node conditionsToStatements second cases size equals: 2;
		assert: node conditionsToStatements second statements size equals: 1;
		assert: node elseStatements isNil
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlSimpleCase [
	| node |
	node := builder plpgsqlSimpleCase parse: 'CASE
    WHEN x < 10 THEN
        msg := ''value is smaller than ten'';
    ELSE
        msg := ''KO'';
END CASE'.
	self
		assert: node class equals: PSQLPlpgSQLASTSimpleCase;
		assert: node conditionToStatements size equals: 1;
		assert: node elseStatements size equals: 1
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLASTBuilderTest >> testPlpgsqlWhileLoop [
	| node |
	node := builder plpgsqlWhileLoop parse: 'WHILE amount_owed < 42 LOOP
    amount_owed := amount_owed + 1;
END LOOP'.
	self
		assert: node class equals: PSQLPlpgSQLASTWhileLoop;
		assert: node beginLabel isNil;
		assert: node endLabel isNil;
		assert: node condition class equals: PSQLASTBinaryOperator;
		assert: node statements size equals: 1
]
