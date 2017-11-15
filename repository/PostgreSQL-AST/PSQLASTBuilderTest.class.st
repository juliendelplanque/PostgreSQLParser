"
A PSQLASTBuilderTest is a test class for testing the behavior of PSQLASTBuilder
"
Class {
	#name : #PSQLASTBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : 'PostgreSQL-AST-Tests'
}

{ #category : #initialization }
PSQLASTBuilderTest >> setUp [
	builder := PSQLASTBuilder new
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testColumnDefinition [
		| node |
	node := builder columnDefinition parse: 'c VARYING CHAR'.
	self
		assert: node class equals: PSQLASTColumnDefinition;
		assert: node columnName class equals: PSQLASTIdentifier;
		assert: node columnName identifier equals: 'c';
		assert: node type class equals: PSQLASTIdentifier;
		assert: node type identifier equals: 'VARYING CHAR'
]

{ #category : #tests-expression }
PSQLASTBuilderTest >> testCompositeValueWith [
	| node |
	node := builder expression parse: '(1, id*3, table.attribute)'.
	self
		assert: node class equals: PSQLASTCompositeValue;
		assert: node items size equals: 3;
		assert: node items first class equals: PSQLASTNumericConstant;
		assert: node items second class equals: PSQLASTBinaryOperator;
		assert: node items third class equals: PSQLASTAttributeAccess.
		
	node := builder expression parse: '((-1::INT8) << 63, 0)::"link_strength"'.
	self
		assert: node class equals: PSQLASTBinaryOperator;
		assert: node left class equals: PSQLASTCompositeValue;
		assert: node left items size equals: 2;
		assert: node operator equals: '::';
		assert: node right class equals: PSQLASTIdentifier.
]

{ #category : #tests-expression }
PSQLASTBuilderTest >> testConditionalExpression [
	| node |
	node := builder expression parse: 'CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END'.
	self
		assert: node class equals: PSQLASTConditionalExpression;
		assert: node conditionsToExpressions size equals: 1;
		assert: node conditionsToExpressions first head class equals: PSQLASTParenthesedExpression;
		assert: node conditionsToExpressions first tail class equals: PSQLASTAttributeAccess;
		assert: node elseExpression class equals: PSQLASTAttributeAccess
]

{ #category : #'tests-insert command' }
PSQLASTBuilderTest >> testConflictAction [
	| node |
	node := builder conflictAction parse: 'DO NOTHING'.
	self
		assert: node class equals: PSQLASTConflictAction;
		assert: node isDoNothing;
		deny: node isDoUpdateSet.
		
	node := builder conflictAction parse: 'DO UPDATE SET id = 1, foo=''bar'', default=DEFAULT'.
	self
		assert: node class equals: PSQLASTConflictAction;
		deny: node isDoNothing;
		assert: node isDoUpdateSet;
		assert: node setClause class equals: PSQLASTSetClause
]

{ #category : #'tests-delete command' }
PSQLASTBuilderTest >> testDeleteCommand [
	| node |
	node := builder deleteCommand parse: 'DELETE FROM films'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'films';
		deny: node hasWithClause;
		deny: node hasAlias;
		deny: node hasReturningClause;
		deny: node hasUsingList;
		deny: node hasWhereClause;
		deny: node areDescendantTablesIncluded.
		
	node := builder deleteCommand parse: 'DELETE FROM films * AS filmsalias'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'films';
		deny: node hasWithClause;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node alias identifier equals: 'filmsalias';
		deny: node hasReturningClause;
		deny: node hasUsingList;
		deny: node hasWhereClause;
		assert: node areDescendantTablesIncluded.
		
	node := builder deleteCommand parse: 'WITH t AS (
    DELETE FROM foo
)
DELETE FROM bar'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'bar';
		assert: node hasWithClause;
		assert: node withClause class equals: PSQLASTWithClause;
		deny: node hasAlias;
		deny: node hasReturningClause;
		deny: node hasUsingList;
		deny: node hasWhereClause;
		deny: node areDescendantTablesIncluded.
		
	node := builder deleteCommand parse: 'DELETE FROM tasks WHERE status = ''DONE'' RETURNING *'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'tasks';
		deny: node hasWithClause;
		deny: node hasAlias;
		assert: node hasReturningClause;
		assert: node returningClause class equals: PSQLASTReturningClause;
		deny: node hasUsingList;
		assert: node hasWhereClause;
		assert: node whereClause class equals: PSQLASTUpdateDeleteWhereClause;
		deny: node areDescendantTablesIncluded.
		
	node := builder deleteCommand parse: 'DELETE FROM tasks USING test WHERE status = ''DONE'' RETURNING *'.
	self
		assert: node class equals: PSQLASTDeleteQuery;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'tasks';
		deny: node hasWithClause;
		deny: node hasAlias;
		assert: node hasReturningClause;
		assert: node returningClause class equals: PSQLASTReturningClause;
		assert: node hasUsingList;
		assert: node usingList size equals: 1;
		assert: node hasWhereClause;
		assert: node whereClause class equals: PSQLASTUpdateDeleteWhereClause;
		deny: node areDescendantTablesIncluded.
]

{ #category : #tests-expression }
PSQLASTBuilderTest >> testExpressionParserTermFor [
	| node |
	node := builder expression parse: '''a String'''.
	self
		assert: node class equals: PSQLASTStringConstant.
		
	node := builder expression parse: '''a String''::text varying'.
	self
		assert: node class equals: PSQLASTBinaryOperator;
		assert: node left class equals: PSQLASTStringConstant;
		assert: node operator equals: '::';
		assert: node right class equals: PSQLASTIdentifier.
		
	node := builder expression parse: 'fct()'.
	self
		assert: node class equals: PSQLASTFunctionCall;
		assert: node argumentsList isEmpty;
		assert: node argumentsDictionary isEmpty
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems [
	| node |
	node :=  builder fromItems parse: '(((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle)))'.
	
	self
		assert: node class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem leftFromItem class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem leftFromItem leftFromItem class equals: PSQLASTFromClauseItemType1
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems1 [
	| node |
	node := builder fromItems1 parse: 'ONLY table * AS alias (c1, c2,C3)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType1;
		assert: node hasOnly;
		assert: node areDescendantTablesIncluded;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node hasColumnAliases;
		assert: node columnAliases class equals: Array;
		assert: node columnAliases size equals: 3.
		
	node := builder fromItems1 parse: 'table'.
	self
		assert: node class equals: PSQLASTFromClauseItemType1;
		deny: node hasOnly;
		deny: node areDescendantTablesIncluded;
		assert: node tableName class equals: PSQLASTIdentifier;
		deny: node hasAlias;
		deny: node hasColumnAliases
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems2 [
	| node |
	node := builder fromItems2 parse: '(SELECT * FROM foo) AS t (c1,c2,c3)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType2;
		deny: node hasLateral;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node hasColumnAliases;
		assert: node columnAliases class equals: Array;
		assert: node columnAliases size equals: 3;
		assert: node valuesOrSelect class equals: PSQLASTSelectQuery
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems3 [
	| node |
	node := builder fromItems3 parse: 'queryName queryAlias (c1,c2,c3)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType3;
		assert: node withQueryName class equals: PSQLASTIdentifier;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node hasColumnAliases;
		assert: node columnAliases class equals: Array;
		assert: node columnAliases size equals: 3
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems4 [
	| node |
	node := builder fromItems4 parse: 'LATERAL fct() AS t (c1 integer, c2 char)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType4;
		assert: node hasLateral;
		assert: node functionCall class equals: PSQLASTFunctionCall;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node columnDefinitions class equals: Array;
		assert: node columnDefinitions size equals: 2.
		
	node columnDefinitions do: [ :columnDefinition |
		self assert: columnDefinition class equals: PSQLASTColumnDefinition ]
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems5 [
	| node |
	node := builder fromItems5 parse: 'LATERAL fct() AS (c1 integer, c2 char)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType5;
		assert: node hasLateral;
		assert: node functionCall class equals: PSQLASTFunctionCall;
		assert: node columnDefinitions class equals: Array;
		assert: node columnDefinitions size equals: 2.
		
	node columnDefinitions do: [ :columnDefinition |
		self assert: columnDefinition class equals: PSQLASTColumnDefinition ]
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems6 [
	| node |
	node := builder fromItems6 parse: 'JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"'.
	self
		assert: node class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem isNil; "This is normal at this step"
		assert: node joinType equals: 'JOIN';
		assert: node rightFromItem class equals: PSQLASTFromClauseItemType1;
		assert: node hasJoinCondition;
		assert: node joinCondition class equals: PSQLASTBinaryOperator;
		deny: node hasNatural;
		deny: node hasUsingList.
		
	node := builder fromItems6 parse: 'NATURAL INNER JOIN test USING (foo)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType6;
		assert: node leftFromItem isNil; "This is normal at this step"
		assert: node joinType equals: 'INNER JOIN';
		assert: node rightFromItem class equals: PSQLASTFromClauseItemType1;
		deny: node hasJoinCondition;
		assert: node hasNatural;
		assert: node hasUsingList;
		assert: node usingList class equals: Array;
		assert: node usingList size equals: 1
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testFromItems7 [
	| node |
	node := builder fromItems7 parse: 'LATERAL fct() WITH ORDINALITY AS t (c1, c2)'.
	self
		assert: node class equals: PSQLASTFromClauseItemType7;
		assert: node hasLateral;
		assert: node functionCall class equals: PSQLASTFunctionCall;
		assert: node hasWithOrdinality;
		assert: node hasAlias;
		assert: node alias class equals: PSQLASTIdentifier;
		assert: node hasColumnAliases;
		assert: node columnAliases class equals: Array;
		assert: node columnAliases size equals: 2.
		
	node columnAliases do: [ :columnAlias |
		self assert: columnAlias class equals: PSQLASTIdentifier ]
]

{ #category : #tests-expression }
PSQLASTBuilderTest >> testFunctionCallParserWith [
	| node |
	node := builder expression parse: 'fct(1, id, arg := ''argument'', 41 + 1)'.
	self
		assert: node class equals: PSQLASTFunctionCall;
		assert: node functionIdentifier class equals: PSQLASTIdentifier;
		assert: node functionIdentifier identifier equals: 'fct';
		assert: node argumentsList size equals: 3;
		assert: node argumentsList first class equals: PSQLASTNumericConstant;
		assert: node argumentsList second class equals: PSQLASTIdentifier;
		assert: node argumentsList third class equals: PSQLASTBinaryOperator;
		assert: node argumentsDictionary size equals: 1;
		assert: node argumentsDictionary associations first head class equals: PSQLASTIdentifier;
		assert: node argumentsDictionary associations first tail class equals: PSQLASTStringConstant
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testIdentifier [
	| node |
	node := builder identifier parse: 'id'.
	
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: 'id'
]

{ #category : #tests }
PSQLASTBuilderTest >> testIdentifierWithOptionalFieldAccess [
	| node |
	node := builder identifierWithOptionalFieldAccess parse: 'id'.
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: 'id'.
		
	node := builder identifierWithOptionalFieldAccess parse: 'id.attribute'.
	self
		assert: node class equals: PSQLASTAttributeAccess;
		assert: node accessed identifier equals: 'id';
		assert: node attributeIdentifier identifier equals: 'attribute'.
]

{ #category : #'tests-insert command' }
PSQLASTBuilderTest >> testInsertCommand [
	| node |
	node := builder insertCommand parse: 'INSERT INTO table (id, name) VALUES (DEFAULT, ''john'')'.
	self
		assert: node class equals: PSQLASTInsertQuery;
		deny: node hasWithClause;
		deny: node hasAlias;
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'table';
		assert: node hasColumns;
		assert: node columns size equals: 2;
		assert: node valuesClause class equals: Array;
		deny: node hasOnConflictClause;
		deny: node hasReturningClause.
		
	node := builder insertCommand parse: 'INSERT INTO table AS t (id, name) VALUES (DEFAULT, ''john''), (SELECT * FROM foo) ON CONFLICT DO NOTHING RETURNING *'.
	self
		assert: node class equals: PSQLASTInsertQuery;
		deny: node hasWithClause;
		assert: node hasAlias;
		assert: node alias identifier equals: 't';
		assert: node tableName class equals: PSQLASTIdentifier;
		assert: node tableName identifier equals: 'table';
		assert: node hasColumns;
		assert: node columns size equals: 2;
		assert: node valuesClause class equals: Array;
		assert: node hasOnConflictClause;
		assert: node onConflictClause class equals: PSQLASTOnConflictClause;
		assert: node hasReturningClause;
		assert: node returningClause class equals: PSQLASTReturningClause
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testNumericConstant [
	| node |
	node := builder numericConstant parse: '1.21'.
	
	self
		assert: node class equals: PSQLASTNumericConstant;
		assert: node content equals: '1.21'
]

{ #category : #'tests-insert command' }
PSQLASTBuilderTest >> testOnConflictClause [
	| node |
	node := builder onConflictClause parse: 'ON CONFLICT DO NOTHING'.
	self
		assert: node class equals: PSQLASTOnConflictClause;
		deny: node hasTarget;
		assert: node action class equals: PSQLASTConflictAction.
		
	node := builder onConflictClause parse: 'ON CONFLICT DO UPDATE SET id = 1, foo=''bar'', default=DEFAULT'.
	self
		assert: node class equals: PSQLASTOnConflictClause;
		deny: node hasTarget;
		assert: node action class equals: PSQLASTConflictAction
]

{ #category : #tests-expression }
PSQLASTBuilderTest >> testParenthesedExpressionParserWith [
	| node |
	node := builder expression parse: '(id+1)'.
	self
		assert: node class equals: PSQLASTParenthesedExpression;
		assert: node expression class equals: PSQLASTBinaryOperator
]

{ #category : #tests-plpgsql }
PSQLASTBuilderTest >> testPlpgsqlAliasDeclaration [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlArrayLoop [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlAssignmentLeftPart [
	| node |
	node := builder plpgsqlAssignmentLeftPart parse: 'truc.machin[id][3]'.
	self
		assert: node class equals: PSQLASTSubscript;
		assert: node target class equals: PSQLASTSubscript;
		assert: node target target class equals: PSQLASTAttributeAccess;
		assert: node target target accessed class equals: PSQLASTIdentifier
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlAssignmentStatement [
	| node |
	node := builder plpgsqlAssignmentStatement parse: 'truc.machin[id][3] := 42'.
	self
		assert: node class equals: PSQLPlpgSQLASTAssignment;
		assert: node operator equals: ':=';
		assert: node target class equals: PSQLASTSubscript;
		assert: node toAssign class equals: PSQLASTNumericConstant
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlBeginLabel [
	| node |
	node := builder plpgsqlBeginLabel parse: '<<label>>'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node labelContent equals: 'label'
]

{ #category : #tests-plpgsql }
PSQLASTBuilderTest >> testPlpgsqlBlock [
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

{ #category : #tests-plpgsql }
PSQLASTBuilderTest >> testPlpgsqlClassicDeclaration [
	| node |
	node := builder plpgsqlClassicDeclaration parse: 'id integer'.
	self
		assert: node class equals: PSQLPlpgSQLASTClassicDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node type identifier identifier equals: 'integer'
]

{ #category : #tests-plpgsql }
PSQLASTBuilderTest >> testPlpgsqlContinueStatement [
	| node |
	node := builder plpgsqlContinueStatement parse: 'CONTINUE WHEN count < 50'.
	self
		assert: node class equals: PSQLPlpgSQLASTContinue;
		assert: node label isNil;
		assert: node whenExpression class equals: PSQLASTBinaryOperator
]

{ #category : #tests-plpgsql }
PSQLASTBuilderTest >> testPlpgsqlCopyTypeDeclaration [
	| node |
	node := builder plpgsqlCopyTypeDeclaration parse: 'user_id users.user_id%TYPE'.
	self
		assert: node class equals: PSQLPlpgSQLASTCopyTypeDeclaration;
		assert: node accessToCopyType attributeIdentifier identifier equals: 'users';
		assert: node accessToCopyType accessed identifier equals: 'user_id'
]

{ #category : #tests-plpgsql }
PSQLASTBuilderTest >> testPlpgsqlDeclarationType [
	| node |
	node := builder plpgsqlDeclarationType parse: 'varying char(16)[][]'.
	self
		assert: node class equals: PSQLPlpgSQLASTType;
		assert: node identifier identifier equals: 'varying char';
		assert: node size equals: 16;
		assert: node dimensions equals: 2
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlForLoop [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlIfThen [
	| node |
	node := builder plpgsqlIfThen parse: 'IF x = 1 THEN
	stmt := 1;
	stmt := stmt +1;
END IF'.
	self
		assert: node class equals: PSQLPlpgSQLASTIf;
		assert: node conditionToStatements size equals: 1;
		assert: node conditionToStatements first head class equals: PSQLASTBinaryOperator;
		assert: node conditionToStatements first tail size equals: 2
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlIfThenElse [
	| node |
	node := builder plpgsqlIfThenElse parse: 'IF x = 1 THEN
	stmt := 1;
ELSE
	stmt := stmt +1;
END IF'.
	self
		assert: node class equals: PSQLPlpgSQLASTIf;
		assert: node conditionToStatements size equals: 1;
		assert: node conditionToStatements first head class equals: PSQLASTBinaryOperator;
		assert: node conditionToStatements first tail size equals: 1;
		assert: node elseStatements size equals: 1
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlIfThenElsif [
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
		assert: node elseStatements size equals: 1
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlIndexParameter [
	| node |
	node := builder plpgsqlIndexParameter parse: '$1'.
	
	self
		assert: node class equals: PSQLASTIdentifier;
		assert: node identifier equals: '$1'
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlLabel [
	| node |
	node := builder plpgsqlLabel parse: 'label'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTBlockLabel;
		assert: node labelContent equals: 'label'
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlLoopLoop [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlQueryResultsLoop [
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
		flag: #'TODO test the query'
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlRaiseStatement1 [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlRaiseStatement2 [
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlRaiseStatement3 [
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlRaiseStatement4 [
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlRaiseStatement5 [
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlRaiseUsingOptions [
	| assocs |
	assocs := builder plpgsqlRaiseUsingOptions parse: 'USING opt = 1 + 1, opt2 = ''test'''.
	
	self
		assert: assocs size equals: 2;
		assert: assocs first head class equals: PSQLASTIdentifier;
		assert: assocs first tail class equals: PSQLASTBinaryOperator;
		assert: assocs second head class equals: PSQLASTIdentifier;
		assert: assocs second tail class equals: PSQLASTStringConstant
]

{ #category : #tests-plpgsql }
PSQLASTBuilderTest >> testPlpgsqlRecordDeclaration [
	| node |
	node := builder plpgsqlRecordDeclaration parse: 'identifier RECORD'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRecordDeclaration;
		assert: node identifier identifier equals: 'identifier'
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlReturnForm1 [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlReturnForm2 [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlReturnForm3 [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlReturnForm4 [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlReturnForm4Bis [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlReturnForm5 [
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

{ #category : #tests-plpgsql }
PSQLASTBuilderTest >> testPlpgsqlRowTypeDeclaration [
	| node |
	node := builder plpgsqlRowTypeDeclaration parse: 'id table%ROWTYPE'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTRowTypeDeclaration;
		assert: node identifier identifier equals: 'id';
		assert: node tableIdentifier identifier equals: 'table'
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlSearchedCase [
	| node |
	node := builder plpgsqlSearchedCase parse: 'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
	WHEN 3, 4 THEN
        msg := ''three or four'';
END CASE'.
	self
		assert: node class equals: PSQLPlpgSQLASTSearchedCase;
		assert: node searchedExpression class equals: PSQLASTIdentifier;
		assert: node conditionsToStatements size equals: 2;
		assert: node conditionsToStatements first head size equals: 2;
		assert: node conditionsToStatements first tail size equals: 1;
		assert: node conditionsToStatements second head size equals: 2;
		assert: node conditionsToStatements second tail size equals: 1;
		assert: node elseStatements isNil
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlSimpleCase [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPlpgsqlWhileLoop [
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

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testPositionalParameter [
	| node |
	node := builder positionalParameter parse: '$1'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTPositionalParameter;
		assert: node index equals: 1
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testReturningClause [
	| node |
	node := builder returningClause parse: 'RETURNING *,id'.
	self
		assert: node class equals: PSQLASTReturningClause;
		assert: node returnedList size equals: 2
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testSetClause [
	| node |
	node := builder setClause parse: 'SET column = 1+1, (column1, column2, column3) = (SELECT c1,c2,c3 FROM foo), (column1, column2, column3) = (SELECT c1,c2,c3 FROM foo)'.
	self
		assert: node class equals: PSQLASTSetClause;
		assert: node items class equals: Array;
		assert: node items size equals: 3
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testSetItem1 [
	| node |
	node := builder setItem1 parse: 'column = 1+1'.
	self
		assert: node class equals: PSQLASTSetClauseItemType1;
		assert: node left class equals: PSQLASTIdentifier;
		assert: node right class equals: PSQLASTBinaryOperator
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testSetItem2 [
	| node |
	node := builder setItem2 parse: '(column1, column2, column3) = (1+1, DEFAULT, 42)'.
	self
		assert: node class equals: PSQLASTSetClauseItemType2;
		assert: node left class equals: Array;
		assert: node left size equals: 3;
		assert: node right class equals: Array;
		assert: node right size equals: 3;
		assert: node right first class equals: PSQLASTBinaryOperator;
		assert: node right second class equals: PSQLASTDefaultValue;
		assert: node right third class equals: PSQLASTNumericConstant.
		
	node left do: [ :leftItem |
		self assert: leftItem class equals: PSQLASTIdentifier ].
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testSetItem3 [
	| node |
	node := builder setItem3 parse: '(column1, column2, column3) = (SELECT c1,c2,c3 FROM foo)'.
	self
		assert: node class equals: PSQLASTSetClauseItemType3;
		assert: node left class equals: Array;
		assert: node left size equals: 3;
		assert: node right class equals: PSQLASTSelectQuery.
		
	node left do: [ :leftItem |
		self assert: leftItem class equals: PSQLASTIdentifier ].
]

{ #category : #tests-accessing }
PSQLASTBuilderTest >> testSimpleStringConstant [
	| node |
	node := builder simpleStringConstant parse: '''test'''.
	
	self
		assert: node class equals: PSQLASTStringConstant;
		assert: node content equals: 'test'
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testUpdateDeleteWhereClause [
	| node |
	node := builder updateDeleteWhereClause parse: 'WHERE id = 1'.
	self
		assert: node class equals: PSQLASTUpdateDeleteWhereClause;
		deny: node hasCursor;
		assert: node hasCondition;
		assert: node condition class equals: PSQLASTBinaryOperator.
		
	node := builder updateDeleteWhereClause parse: 'WHERE CURRENT OF cursor'.
	self
		assert: node class equals: PSQLASTUpdateDeleteWhereClause;
		assert: node hasCursor;
		deny: node hasCondition;
		assert: node currentOfCursor class equals: PSQLASTIdentifier
]

{ #category : #'tests-insert command' }
PSQLASTBuilderTest >> testValuesClause [
	| node |
	node := builder valuesClause parse: 'VALUES (1, DEFAULT, var+1)'.
	self
		assert: node class equals: Array.
		
	node := builder valuesClause parse: 'DEFAULT VALUES'.
	self
		assert: node class equals: PSQLASTDefaultValues.
		
	node := builder valuesClause parse: 'SELECT * FROM foo'.
	self
		assert: node class equals: PSQLASTSelectQuery.
]

{ #category : #'tests-values command' }
PSQLASTBuilderTest >> testValuesCommand [
	| node |
	node := builder valuesCommand parse: 'VALUES (1, DEFAULT, var+1)'.
	self
		assert: node class equals: Array;
		assert: node size equals: 1;
		assert: node first class equals: Array;
		assert: node first size equals: 3;
		assert: node first first class equals: PSQLASTNumericConstant;
		assert: node first second class equals: PSQLASTDefaultValue;
		assert: node first third class equals: PSQLASTBinaryOperator.
		
	node := builder valuesCommand parse: 'VALUES (1, 2, 3), (4,5,6), (7,8,9)'.
	self
		assert: node class equals: Array;
		assert: node size equals: 3.
	node do: [ :row |
		self
			assert: row class equals: Array;
			assert: row size equals: 3 ]
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testWithClause [
	| node |
	node := builder withClause parse: 'WITH table AS (SELECT * FROM foo), table2(id,text) AS (SELECT * FROM bar)'.
	self
		assert: node class equals: PSQLASTWithClause;
		deny: node isRecursive;
		assert: node queries size equals: 2.
		
	node := builder withClause parse: 'WITH RECURSIVE table AS (SELECT * FROM foo), table2(id,text) AS (SELECT * FROM bar)'.
	self
		assert: node class equals: PSQLASTWithClause;
		assert: node isRecursive;
		assert: node queries size equals: 2.
]

{ #category : #tests-shared }
PSQLASTBuilderTest >> testWithQuery [
	| node |
	node := builder withQuery parse: 'table AS (SELECT * FROM foo)'.
	self
		assert: node class equals: Association;
		assert: node head class equals: PSQLASTTableAlias;
		assert: node head identifier identifier equals: 'table';
		assert: node head columnAliases size equals: 0.
		
	node := builder withQuery parse: 'table(id,bar) AS (SELECT * FROM foo)'.
	self
		assert: node class equals: Association;
		assert: node head class equals: PSQLASTTableAlias;
		assert: node head identifier identifier equals: 'table';
		assert: node head columnAliases size equals: 2;
		assert: (node head columnAliases allSatisfy: [ :item | item class = PSQLASTIdentifier ])
]
