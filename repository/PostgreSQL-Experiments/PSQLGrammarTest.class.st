Class {
	#name : #PSQLGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : 'PostgreSQL-Experiments'
}

{ #category : #accessing }
PSQLGrammarTest >> parserClass [
	^ PSQLGrammar
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testAggregateExpression [
	self
		parse: 'array_agg(a ORDER BY b DESC)' rule: #expression;
		parse: 'string_agg(a, '','' ORDER BY a)' rule: #expression;
		parse: 'string_agg(a ORDER BY a, '','')' rule: #expression
]

{ #category : #tests }
PSQLGrammarTest >> testAllOrDistinctClause [
	self
		parse: 'ALL' rule: #allOrDistinctClause;
		parse: 'DISTINCT' rule: #allOrDistinctClause;
		parse: 'DISTINCT ON (id)' rule: #allOrDistinctClause;
		parse: 'DISTINCT ON (id , name,company)' rule: #allOrDistinctClause
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testBinaryLogicalOperator [
	self
		parse: 'AND ' rule: #binaryLogicalOperator;
		parse: 'OR ' rule: #binaryLogicalOperator
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testBinaryOperator [
	self
		parse: '2*2' rule: #expression;
		parse: '2*$3*4' rule: #expression;
		parse: '2*(3+value)' rule: #expression;
		parse: '(3+value)/2' rule: #expression
]

{ #category : #tests }
PSQLGrammarTest >> testColumnDefinition [
	self
		parse: 'clepersonne INTEGER' rule: #columnDefinition;
		parse: 'datearrivee DATE' rule: #columnDefinition;
		parse: 'sexe VARCHAR' rule: #columnDefinition
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testColumnReference [
	self
		parse: 'column' rule: #columnReference
]

{ #category : #tests }
PSQLGrammarTest >> testColumnsAndAliasesSelected [
	self
		parse: 'kind, sum(len) AS total' rule: #columnsAndAliasesSelected;
		parse: 'actors.name' rule: #columnsAndAliasesSelected
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testCommaSubscript [
	self
		parse: 'ARRAY[4,59,1]' rule: #expression
]

{ #category : #tests-expression }
PSQLGrammarTest >> testConditionalExpression [
	self parse: 'CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END' rule: #conditionalExpression;
	parse: 'CASE WHEN 1 = 1 THEN ''Ok'' ELSE CASE WHEN 1 = 2 THEN ''Ooops''::text END END' rule: #conditionalExpression
]

{ #category : #'tests-create view command' }
PSQLGrammarTest >> testCreateViewCommand [
	self
		parse: 'CREATE VIEW test_view AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE OR REPLACE VIEW test_view AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE TEMPORARY VIEW test_view AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE TEMP VIEW test_view AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE VIEW test_view (a ,b, c) AS SELECT a,b,c FROM table' rule: #createViewCommand;
		parse: 'CREATE VIEW test_view WITH (option=value, option2 , option3 = value3) AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE OR REPLACE TEMPORARY VIEW test_view (a ,b, c) WITH (option=value, option2 , option3 = value3) AS SELECT * FROM table' rule: #createViewCommand
]

{ #category : #tests-expression }
PSQLGrammarTest >> testExpression [
	self
		parse: 'fct()' rule: #expression;
		parse: '++1' rule: #expression;
		parse: '1+1' rule: #expression;
		parse: '1++' rule: #expression;
		parse: '(fct(fct1(variable[1:$2],2),fct2(42)))' rule: #expression;
		parse: '"initiative"."issue_id" = "interest"."issue_id"' rule: #expression;
		parse: '(id)' rule: #expression;
		parse: '(rowfunction(a,b))' rule: #expression;
		parse: 'affectation.cle_support = support.cle AND support.cle_personne = personne.cle AND personne.cle = clepersonne AND	affectation.cle_equipe = cleequipe AND affectation.fin <= finperiode' rule: #expression;
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE)' rule: #expression;
		parse: 'personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL' rule: #expression;
		parse: '(personne.cle IN (SELECT these.cle_coencadrant FROM these))' rule: #expression;
		parse: '''IG''::character varying' rule: #expression;
		parse: '1 = - 1' rule: #expression;
		parse: 'ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text])' rule: #expression;
		parse: '((grade.cle_catgrade)::text = ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text]))' rule: #expression;
		parse: '''a'' || ''b''' rule: #expression;
		parse: 'parentid IS NULL OR parentid = ''''' rule: #expression;
		parse: 'x BETWEEN 0 AND 10' rule: #expression;
		parse: 'x NOT BETWEEN 0 AND 10' rule: #expression;
		parse: '(x BETWEEN 0 AND 10) OR (x NOT BETWEEN 15 AND 20)' rule: #expression;
		parse: 'x IS DISTINCT FROM y' rule: #expression;
		parse: 'x IS NOT DISTINCT FROM y' rule: #expression;
		parse: 'x IS TRUE' rule: #expression;
		parse: 'x IS NOT TRUE' rule: #expression;
		parse: 'x IS FALSE' rule: #expression;
		parse: 'x IS NOT FALSE' rule: #expression;
		parse: 'x IS UNKNOWN' rule: #expression;
		parse: 'x IS NOT UNKNOWN' rule: #expression;
		parse: 'x BETWEEN SYMMETRIC 0 AND 10' rule: #expression;
		parse: 'x NOT BETWEEN SYMMETRIC 0 AND 10' rule: #expression;
		parse: '"matrix_p"["i"]["j"] > "matrix_p"["j"]["i"]'  rule: #expression;
		parse: '((-1::INT8) << 63, 0)::"link_strength"' rule: #expression
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testFetchClause [
	self
		parse: 'FETCH FIRST ROW ONLY' rule: #fetchClause;
		parse: 'FETCH FIRST 42 ROWS ONLY' rule: #fetchClause;
		parse: 'FETCH NEXT ROW ONLY' rule: #fetchClause;
		parse: 'FETCH NEXT 42 ROWS ONLY' rule: #fetchClause
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testFieldSelection [
	self
		parse: 'mytable.mycolumn' rule: #expression;
		parse: '$1.somecolumn' rule: #expression;
		parse: '(rowfunction(a,b)).col3' rule: #expression;
		parse: '(compositecol).somefield' rule: #expression;
		parse: '(mytable.compositecol).somefield' rule: #expression;
		parse: '(compositecol).*' rule: #expression
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testForClause [
	self
		parse: 'FOR UPDATE' rule: #forClause;
		parse: 'FOR SHARE' rule: #forClause;
		parse: 'FOR UPDATE OF table1,table2 , table3' rule: #forClause;
		parse: 'FOR UPDATE NOWAIT' rule: #forClause;
		parse: 'FOR UPDATE OF table1,table2 , table3 NOWAIT' rule: #forClause;
		parse: 'FOR SHARE OF table1,table2 , table3' rule: #forClause;
		parse: 'FOR SHARE NOWAIT' rule: #forClause;
		parse: 'FOR SHARE OF table1,table2 , table3 NOWAIT' rule: #forClause
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testFromClause [
	"A smoke test with multiple FROM clauses extracted from existing open-source schemas."
	self
		parse: 'FROM "initiative"' rule: #fromClause;
		parse: 'FROM "area_delegation" LEFT JOIN "membership"' rule: #fromClause;
		parse: 'FROM affectation,support,personne' rule: #fromClause;
		parse: 'FROM (((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle))), grade, typesupport, employeur' rule: #fromClause
]

{ #category : #tests }
PSQLGrammarTest >> testFromItems [
	self
		parse: 'ONLY table * AS alias (c1, c2,C3)' rule: #fromItems;
		parse: 'table * AS alias (c1, c2,C3)' rule: #fromItems;
		parse: 'ONLY table AS alias (c1, c2,C3)' rule: #fromItems;
		parse: 'ONLY table *' rule: #fromItems;
		parse: '(SELECT * FROM table) AS alias' rule: #fromItems;
		parse: '(SELECT * FROM table) AS alias (c1,c2,C3)' rule: #fromItems;
		parse: 'queryName' rule: #fromItems;
		parse: 'queryName as aliasName' rule: #fromItems;
		parse: 'queryName AS aliasName (c1,C2, c3   )' rule: #fromItems;
		parse: 'function(1, "a") AS aliasName (c1, C2, "C3")' rule: #fromItems;
		parse: 'function(1, "a") aliasName (c1, C2, "C3")' rule: #fromItems;
		parse: 'function(1, "a") AS aliasName' rule: #fromItems;
		parse: 'function(1, "a") aliasName' rule: #fromItems;
		parse: '"initiative" JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"' rule: #fromItems;
		parse: '"area_delegation" LEFT JOIN "membership"' rule: #fromItems;
		parse: '("area_delegation" LEFT JOIN "membership")' rule: #fromItems;
		parse: 'personne LEFT JOIN these ON ((personne.cle = these.cle_personne))' rule: #fromItems;
		parse: '(((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle)))' rule: #fromItems
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testFromItems1 [
	self
		parse: 'ONLY table * AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'table * AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'ONLY table AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'ONLY table *' rule: #fromItems1
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testFromItems2 [
	self
		parse: '(SELECT * FROM table) AS alias' rule: #fromItems2;
		parse: '(SELECT * FROM table) AS alias (c1,c2,C3)' rule: #fromItems2
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testFromItems3 [
	self
		parse: 'queryName' rule: #fromItems3;
		parse: 'queryName as aliasName' rule: #fromItems3;
		parse: 'queryName AS aliasName (c1,C2, c3   )' rule: #fromItems3
]

{ #category : #tests }
PSQLGrammarTest >> testFromItems4 [
	self
		parse: 'function(1, "a") AS aliasName (c1, C2, "C3")' rule: #fromItems4;
		parse: 'function(1, "a") aliasName (c1, C2, "C3")' rule: #fromItems4;
		parse: 'function(1, "a") AS aliasName' rule: #fromItems4;
		parse: 'function(1, "a") aliasName' rule: #fromItems4;
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE) AS mbrs( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #fromItems4
]

{ #category : #tests }
PSQLGrammarTest >> testFromItems5 [
	self
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE) AS ( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #fromItems5
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testFromItems6 [
	self
		parse: 'JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"' rule: #fromItems6;
		parse: 'LEFT JOIN "membership"' rule: #fromItems6
]

{ #category : #tests }
PSQLGrammarTest >> testFunctionCall [
	self
		parse: 'fct()' rule: #expression;
		parse: 'sqrt(2)' rule: #expression;
		parse: 'fct(''test'')' rule: #expression;
		parse: 'fct(table)' rule: #expression;
		parse: 'fct(table.column)' rule: #expression;
		parse: 'fct(1,2)' rule: #expression;
		parse: 'fct(fct1(1,2), fct2(42))' rule: #expression;
		parse: 'fct(a := 1, b := hello)' rule: #expression;
		parse: '"defeat_strength"(
            "matrix_a"["i"]["j"],
            "matrix_a"["j"]["i"],
            "policy_row"."defeat_strength"
          )' rule: #expression
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testGroupByClause [
	self
		parse: 'GROUP BY table."column_name"' rule: #groupByClause;
		parse: 'GROUP BY table."column_name", table."column_name2",table.column_name3' rule: #groupByClause
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testHavingClause [
	self
		parse: 'HAVING count(name) < 2' rule: #havingClause
]

{ #category : #tests-keywords }
PSQLGrammarTest >> testJoinType [
	self
		parse: 'INNER JOIN' rule: #joinType;
		parse: 'LEFT OUTER JOIN' rule: #joinType;
		parse: 'LEFT JOIN' rule: #joinType;
		parse: 'RIGHT OUTER JOIN' rule: #joinType;
		parse: 'RIGHT JOIN' rule: #joinType;
		parse: 'FULL OUTER JOIN' rule: #joinType;
		parse: 'FULL JOIN' rule: #joinType;
		parse: 'CROSS JOIN' rule: #joinType;
		parse: 'JOIN' rule: #joinType
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testLimitClause [
	self
		parse: 'LIMIT 42' rule: #limitClause;
		parse: 'LIMIT ALL' rule: #limitClause
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testOffsetClause [
	self
		parse: 'OFFSET 25' rule: #offsetClause
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testOrderByClause [
	self
		parse: 'ORDER BY a + b, c' rule: #orderByClause;
		parse: 'ORDER BY sum' rule: #orderByClause;
		parse: 'ORDER BY 1 ASC NULLS LAST' rule: #orderByClause
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testParenthesedExpression [
	self
		parse: '(1+$1)' rule: #expression;
		parse: '(fct())' rule: #expression;
		parse: '(fct(table.column)[1])' rule: #expression;
		parse: '(++fct(table,42))' rule: #expression;
		parse: '(fct(fct2(table),42))' rule: #expression
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlAliasDeclaration [
	self
		parse: 'subtotal ALIAS FOR $1' rule: #plpgsqlAliasDeclaration;
		parse: 'v_string ALIAS FOR $1' rule: #plpgsqlAliasDeclaration;
		parse: 'index ALIAS FOR $2' rule: #plpgsqlAliasDeclaration;
		parse: 'prior ALIAS FOR old' rule: #plpgsqlAliasDeclaration;
		parse: 'updated ALIAS FOR new' rule: #plpgsqlAliasDeclaration
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlArrayLoop [
	self
		parse: 'FOREACH x IN ARRAY $1
  LOOP
    s := s + x;
  END LOOP' rule: #plpgsqlArrayLoop
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlAssertStatement [
	self
		parse: 'ASSERT 1 + 1 = 2' rule: #plpgsqlAssertStatement;
		parse: 'ASSERT 1 + 1 = 2, ''KO''' rule: #plpgsqlAssertStatement;
		parse: 'ASSERT 1 + 1 = 2, ''Should'' || notBeRaised()' rule: #plpgsqlAssertStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlAssignmentStatement [
	self
		parse: 'tax := subtotal * 0.06' rule: #plpgsqlAssignmentStatement;
		parse: 'my_record.user_id := 20' rule: #plpgsqlAssignmentStatement;
		parse: 'my_record.user_id = 20' rule: #plpgsqlAssignmentStatement;
		parse: '"matrix_a"["i"]["j"] := "battle_row"."count"' rule: #plpgsqlAssignmentStatement;
		parse: '"matrix_d"["i"]["j"] := (
          "defeat_strength"(
            "matrix_a"["i"]["j"],
            "matrix_a"["j"]["i"],
            "policy_row"."defeat_strength"
          ),
          "secondary_link_strength"(
            "i",
            "j",
            "policy_row"."tie_breaking"
          )
        )::"link_strength"' rule: #plpgsqlAssignmentStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlBeginLabel [
	self
		parse: '<< outerblock >>' rule: #plpgsqlBeginLabel
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlBody [
	self
		parse: 'BEGIN
IF TG_OP = ''INSERT'' THEN
  NEW.textvector = to_tsvector(NEW.old_text);
ELSIF NEW.old_text != OLD.old_text THEN
  NEW.textvector := to_tsvector(NEW.old_text);
END IF;
RETURN NEW;
END;' rule: #plpgsqlBody;
	parse: 'BEGIN
	if (photo IS NULL) THEN
		RETURN ''photos/membreSansPhoto.jpg'';
	ELSE
		return photo;
	END IF;
END;' rule: #plpgsqlBody;
	parse: 'DECLARE
	clepersonne int4;

BEGIN
	SELECT cle INTO clepersonne
	FROM
		personne
	WHERE
		uidpersonne = uid;

	RETURN clepersonne;
END;' rule: #plpgsqlBody;
	parse: 'BEGIN
	RETURN join(str1,str2,'' / '');
END;' rule: #plpgsqlBody;
	parse: 'DECLARE
	nbrjours int4;
	dateexpiration date;

BEGIN
	SELECT
		typesupport.expiration INTO nbrjours
	FROM
		typesupport
	WHERE
		typesupport.cle = cletypesupport;

	IF (datefin IS NOT NULL) AND (nbrjours IS NOT NULL) THEN
		dateexpiration = datefin + nbrjours;
	END IF;

	RETURN dateexpiration;
END;' rule: #plpgsqlBody;
	parse: 'DECLARE
	nbrsupportscotutelle int := 0;
BEGIN
	SELECT count(support.cle) INTO nbrsupportscotutelle
	FROM
		support
	WHERE
		support.cle_personne = clepersonne::INT4
	AND	support.cle_typesupport = 12
	AND est_dans_interval(debutobservation::DATE,finobservation::date,support.debut,support.fin) = TRUE;

	return (nbrsupportscotutelle > 0);
END;' rule: #plpgsqlBody
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlContinuetatement [
	self
		parse: 'CONTINUE WHEN count < 50' rule: #plpgsqlContinueStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlDeclarationCollate [
	self
		parse: 'COLLATE "en_US"' rule: #plpgsqlDeclarationCollate;
		parse: 'COLLATE "C"' rule: #plpgsqlDeclarationCollate
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlDeclarationItem [
	self
		parse: 'user_id integer' rule: #plpgsqlDeclarationItem;
		parse: 'quantity numeric(5)' rule: #plpgsqlDeclarationItem;
		parse: 'url varchar' rule: #plpgsqlDeclarationItem;
		parse: 'myrow tablename%ROWTYPE' rule: #plpgsqlDeclarationItem;
		parse: 'myfield tablename.columnname%TYPE' rule: #plpgsqlDeclarationItem;
		parse: 'arow RECORD' rule: #plpgsqlDeclarationItem
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlDeclarationType [
	self
		parse: 'integer' rule: #plpgsqlDeclarationType;
		parse: 'varchar' rule: #plpgsqlDeclarationType;
		parse: 'varchar(16)' rule: #plpgsqlDeclarationType
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlDeclarations [
	self
		parse: 'local_a text := a;
    local_b text := b;' rule: #plpgsqlDeclarations;
		parse: 'prior ALIAS FOR old;
  updated ALIAS FOR new;' rule: #plpgsqlDeclarations;
		parse: 'user_id integer;
quantity numeric(5);
url varchar;
myrow tablename%ROWTYPE;
myfield tablename.columnname%TYPE;
arow RECORD;' rule: #plpgsqlDeclarations;
		parse: '"issue_row"       "issue"%ROWTYPE;
      "policy_row"      "policy"%ROWTYPE;
      "dimension_v"     INT4;
      "matrix_a"        INT4[][];
      "matrix_d"        "link_strength"[][];
      "matrix_p"        "link_strength"[][];
      "matrix_t"        "link_strength"[][];
      "matrix_f"        BOOLEAN[][];
      "matrix_b"        BOOLEAN[][];
      "i"               INT4;
      "j"               INT4;
      "m"               INT4;
      "n"               INT4;
      "battle_row"      "battle"%ROWTYPE;
      "rank_ary"        INT4[];
      "rank_v"          INT4;
      "initiative_id_v" "initiative"."id"%TYPE;' rule: #plpgsqlDeclarations
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlExceptionHandler [
	self
		parse: 'BEGIN
    x := x + 1;
    y := x / 0;
EXCEPTION
    WHEN division_by_zero THEN
        RETURN x;
END' rule: #plpgsqlExceptionHandler
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlExecuteStatement [
	self
		parse: 'EXECUTE ''SELECT count(*) FROM mytable WHERE inserted_by = $1 AND inserted <= $2''
   INTO c
   USING checked_user, checked_date' rule: #plpgsqlExecuteStatement;
	parse: 'EXECUTE ''SELECT count(*) FROM ''
    || quote_ident(tabname)
    || '' WHERE inserted_by = $1 AND inserted <= $2''
   INTO c
   USING checked_user, checked_date' rule: #plpgsqlExecuteStatement;
	parse: 'EXECUTE format(''SELECT count(*) FROM %I WHERE inserted_by = $1 AND inserted <= $2'', tabname)
   INTO c
   USING checked_user, checked_date' rule: #plpgsqlExecuteStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlExitStatement [
	self
		parse: 'EXIT' rule: #plpgsqlExitStatement;
		parse: 'EXIT WHEN count > 0' rule: #plpgsqlExitStatement;
		parse: 'EXIT ablock' rule: #plpgsqlExitStatement;
		parse: 'EXIT ablock WHEN count > 0' rule: #plpgsqlExitStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlForLoop [
	self
		parse: 'FOR i IN 1 .. 10 LOOP
    NULL;
END LOOP' rule: #plpgsqlForLoop;
		parse: 'FOR i IN REVERSE 10 .. 1 LOOP
    NULL;
END LOOP' rule: #plpgsqlForLoop;
		parse: 'FOR i IN REVERSE 10 .. 1 BY 2 LOOP
    NULL;
END LOOP' rule: #plpgsqlForLoop;
		parse: '<<label>>
FOR i IN REVERSE 10 .. 1 BY 2 LOOP
    NULL;
END LOOP label' rule: #plpgsqlForLoop
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlIfThen [
	self
		parse: 'IF v_user_id <> 0 THEN
    v_user_id := 42;
END IF' rule: #plpgsqlIfThen;
		parse: 'IF "policy_row"."tie_breaking" != ''simple''::"tie_breaking" THEN
	NULL;
END IF' rule: #plpgsqlIfThen
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlIfThenElse [
	self
		parse: 'IF parentid = 1 OR parentid = ''''
THEN
    RETURN fullname;
ELSE
    RETURN hp_true_filename(parentid) || ''/'' || fullname;
END IF' rule: #plpgsqlIfThenElse;
		parse: 'IF v_count > 0 THEN
    RETURN ''t'';
ELSE
    RETURN ''f'';
END IF' rule: #plpgsqlIfThenElse;
		parse: 'IF demo_row.sex = ''m'' THEN
    pretty_sex := ''man'';
ELSE
    IF demo_row.sex = ''f'' THEN
        pretty_sex := ''woman'';
    END IF;
END IF' rule: #plpgsqlIfThenElse
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlIfThenElsif [
	self
		parse: 'IF number = 0 THEN
    result := ''zero'';
ELSIF number > 0 THEN
    result := ''positive'';
ELSIF number < 0 THEN
    result := ''negative'';
ELSE
    result := ''NULL'';
END IF' rule: #plpgsqlIfThenElsif;
	parse: 'IF TG_OP = ''INSERT'' THEN
  NEW.textvector = to_tsvector(NEW.old_text);
ELSIF NEW.old_text != OLD.old_text THEN
  NEW.textvector := to_tsvector(NEW.old_text);
END IF' rule: #plpgsqlIfThenElsif
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlLoopLoop [
	self
		parse: 'LOOP
    IF count > 0 THEN
        EXIT;
    END IF;
END LOOP' rule: #plpgsqlLoopLoop;
		parse: 'LOOP
    EXIT WHEN count > 0;
END LOOP' rule: #plpgsqlLoopLoop
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlNullStatement [
	self
		parse: 'NULL' rule: #plpgsqlNullStatement";
		parse: '    
' rule: #plpgsqlNullStatement"
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlPerformStatement [
	self
		parse: 'PERFORM "require_transaction_isolation"()' rule: #plpgsqlPerformStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlQueryResultsLoop [
	self
		parse: 'FOR mviews IN SELECT * FROM cs_materialized_views ORDER BY sort_key LOOP
	var := mviews;
END LOOP' rule: #plpgsqlQueryResultsLoop;
		parse: '<<label>>
FOR mviews IN SELECT * FROM cs_materialized_views ORDER BY sort_key LOOP
	var := mviews;
END LOOP label' rule: #plpgsqlQueryResultsLoop;
		parse: 'FOR "initiative_id_v" IN
    SELECT "id" FROM "initiative"
    WHERE "issue_id" = "issue_id_p" AND "admitted"
    ORDER BY "id"
  LOOP
	NULL;
	END LOOP'
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlRaiseStatement [
	self
		parse: 'RAISE NOTICE ''Calling cs_create_job(%)'', v_job_id' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE EXCEPTION ''Nonexistent ID --> %'', user_id
      USING HINT = ''Please check your user ID''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE ''Duplicate user ID: %'', user_id USING ERRCODE = ''unique_violation''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE ''Duplicate user ID: %'', user_id USING ERRCODE = ''23505''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE division_by_zero' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE unique_violation USING MESSAGE = ''Duplicate user ID: '' || user_id' rule: #plpgsqlRaiseStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlRaiseStatement1 [
	self
		parse: 'RAISE EXCEPTION ''Nonexistent ID --> %'', user_id
      USING HINT = ''Please check your user ID''' rule: #plpgsqlRaiseStatement1
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlRaiseStatement2 [
	self
		parse: 'RAISE division_by_zero' rule: #plpgsqlRaiseStatement2;
		parse: 'RAISE division_by_zero USING ERRCODE = ''1234''' rule: #plpgsqlRaiseStatement2
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlRaiseStatement3 [
	self
		parse: 'RAISE INFO SQLSTATE ''22012''' rule: #plpgsqlRaiseStatement3;
		parse: 'RAISE INFO SQLSTATE ''22012'' USING ERRCODE = ''err''' rule: #plpgsqlRaiseStatement3
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlRaiseStatement4 [
	self
		parse: 'RAISE INFO USING ERRCODE = ''23505''' rule: #plpgsqlRaiseStatement4;
		parse: 'RAISE INFO USING ERRCODE = ''23505'' , OTHER = ''test''' rule: #plpgsqlRaiseStatement4
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlRaiseStatement5 [
	self
		parse: 'RAISE' rule: #plpgsqlRaiseStatement5
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlResultValueStatement [
	self
		parse: 'GET DIAGNOSTICS integer_var = ROW_COUNT' rule: #plpgsqlResultValueStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlReturn [
	self
		parse: 'RETURN 1 + 2' rule: #plpgsqlReturn;
		parse: 'RETURN scalar_var' rule: #plpgsqlReturn;
		parse: 'RETURN composite_type_var' rule: #plpgsqlReturn;
		parse: 'RETURN NEXT r' rule: #plpgsqlReturn;
		parse: 'RETURN' rule: #plpgsqlReturn;
		parse: 'RETURN QUERY SELECT flightid
                   FROM flight
                  WHERE flightdate >= $1
                    AND flightdate < ($1 + 1)' rule: #plpgsqlReturn;
		parse: 'RETURN QUERY EXECUTE ''SELECT flightid
                   FROM flight
                  WHERE flightdate >= $1
                    AND flightdate < ($1 + 1)''' rule: #plpgsqlReturn
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlSearchedCase [
	self
		parse: 'CASE
    WHEN x < 10 THEN
        msg := ''value is smaller than ten'';
    WHEN x < 20 THEN
        msg := ''value is smaller tham twenty'';
END CASE' rule: #plpgsqlSearchedCase;
		parse: 'CASE
    WHEN x < 10 THEN
        msg := ''value is smaller than ten'';
    ELSE
        msg := ''KO'';
END CASE' rule: #plpgsqlSearchedCase;
		parse: 'CASE
                     WHEN "matrix_f"["i"]["j"]
                     THEN ((-1::INT8) << 63, 0)::"link_strength"
                     ELSE "matrix_d"["i"]["j"] END CASE' rule: #plpgsqlSearchedCase
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlSimpleCase [
	self
		parse: 'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
    ELSE
        msg := ''other value than one or two'';
END CASE' rule: #plpgsqlSimpleCase;
		parse: 'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
	WHEN 3, 4 THEN
        msg := ''three or four'';
END CASE' rule: #plpgsqlSimpleCase
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlStatement [
	self
		parse: 'v_user_id := 42' rule: #plpgsqlStatement;
		parse: '((-1::INT8) << 63, 0)::"link_strength"' rule: #plpgsqlStatement
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlStatements [
	self
		parse: 'v_user_id := 42 ; v_user_id := 42 ;' rule: #plpgsqlStatements;
		parse: 'BEGIN
  PERFORM "require_transaction_isolation"();
  SELECT * INTO "issue_row"
    FROM "issue" WHERE "id" = "issue_id_p";
  SELECT * INTO "policy_row"
    FROM "policy" WHERE "id" = "issue_row"."policy_id";
  SELECT count(1) INTO "dimension_v"
    FROM "battle_participant" WHERE "issue_id" = "issue_id_p";
  
  
  "matrix_a" := array_fill(NULL::INT4, ARRAY["dimension_v", "dimension_v"]);
  "i" := 1;
  "j" := 2;
  FOR "battle_row" IN
    SELECT * FROM "battle" WHERE "issue_id" = "issue_id_p"
    ORDER BY
    "winning_initiative_id" NULLS FIRST,
    "losing_initiative_id" NULLS FIRST
  LOOP
    "matrix_a"["i"]["j"] := "battle_row"."count";
    IF "j" = "dimension_v" THEN
      "i" := "i" + 1;
      "j" := 1;
    ELSE
      "j" := "j" + 1;
      IF "j" = "i" THEN
        "j" := "j" + 1;
      END IF;
    END IF;
  END LOOP;
  IF "i" != "dimension_v" OR "j" != "dimension_v" + 1 THEN
    RAISE EXCEPTION ''Wrong battle count (should not happen)'';
  END IF;
  
  "matrix_d" := array_fill(NULL::INT8, ARRAY["dimension_v", "dimension_v"]);
  "i" := 1;
  LOOP
    "j" := 1;
    LOOP
      IF "i" != "j" THEN
        "matrix_d"["i"]["j"] := (
          "defeat_strength"(
            "matrix_a"["i"]["j"],
            "matrix_a"["j"]["i"],
            "policy_row"."defeat_strength"
          ),
          "secondary_link_strength"(
            "i",
            "j",
            "policy_row"."tie_breaking"
          )
        )::"link_strength";
      END IF;
      EXIT WHEN "j" = "dimension_v";
      "j" := "j" + 1;
    END LOOP;
    EXIT WHEN "i" = "dimension_v";
    "i" := "i" + 1;
  END LOOP;
  "matrix_p" := "find_best_paths"("matrix_d");
  "matrix_b" := array_fill(NULL::BOOLEAN, ARRAY["dimension_v", "dimension_v"]);
  "i" := 1;
  LOOP
    "j" := "i" + 1;
    LOOP
      IF "i" != "j" THEN
        IF "matrix_p"["i"]["j"] > "matrix_p"["j"]["i"] THEN
          "matrix_b"["i"]["j"] := TRUE;
          "matrix_b"["j"]["i"] := FALSE;
        ELSIF "matrix_p"["i"]["j"] < "matrix_p"["j"]["i"] THEN
          "matrix_b"["i"]["j"] := FALSE;
          "matrix_b"["j"]["i"] := TRUE;
        END IF;
      END IF;
      EXIT WHEN "j" = "dimension_v";
      "j" := "j" + 1;
    END LOOP;
    EXIT WHEN "i" = "dimension_v" - 1;
    "i" := "i" + 1;
  END LOOP;
  IF "policy_row"."tie_breaking" != ''simple''::"tie_breaking" THEN
    "m" := 1;
    LOOP
      "n" := "m" + 1;
      LOOP
        IF "matrix_b"["m"]["n"] ISNULL THEN
          "matrix_t" := "matrix_p";
          "matrix_f" := array_fill(FALSE, ARRAY["dimension_v", "dimension_v"]);
          LOOP
            "i" := 1;
            <<forbid_one_link>>
            LOOP
              "j" := 1;
              LOOP
                IF "i" != "j" THEN
                  IF "matrix_d"["i"]["j"] = "matrix_t"["m"]["n"] THEN
                    "matrix_f"["i"]["j"] := TRUE;
                    EXIT forbid_one_link;
                  END IF;
                END IF;
                EXIT WHEN "j" = "dimension_v";
                "j" := "j" + 1;
              END LOOP;
              IF "i" = "dimension_v" THEN
                RAISE EXCEPTION ''Did not find shared weakest link for tie-breaking (should not happen)'';
              END IF;
              "i" := "i" + 1;
            END LOOP;
            "i" := 1;
            LOOP
              "j" := 1;
              LOOP
                IF "i" != "j" THEN
                  "matrix_t"["i"]["j"] := CASE
                     WHEN "matrix_f"["i"]["j"]
                     THEN ((-1::INT8) << 63, 0)::"link_strength"  
                     ELSE "matrix_d"["i"]["j"] END;
                END IF;
                EXIT WHEN "j" = "dimension_v";
                "j" := "j" + 1;
              END LOOP;
              EXIT WHEN "i" = "dimension_v";
              "i" := "i" + 1;
            END LOOP;
            "matrix_t" := "find_best_paths"("matrix_t");
            
            IF "matrix_t"["m"]["n"] > "matrix_t"["n"]["m"] THEN
              "matrix_b"["m"]["n"] := TRUE;
              "matrix_b"["n"]["m"] := FALSE;
              EXIT;
            ELSIF "matrix_t"["m"]["n"] < "matrix_t"["n"]["m"] THEN
              "matrix_b"["m"]["n"] := FALSE;
              "matrix_b"["n"]["m"] := TRUE;
              EXIT;
            END IF;
          END LOOP;
        END IF;
        EXIT WHEN "n" = "dimension_v";
        "n" := "n" + 1;
      END LOOP;
      EXIT WHEN "m" = "dimension_v" - 1;
      "m" := "m" + 1;
    END LOOP;
  END IF;
  
  "rank_ary" := array_fill(NULL::INT4, ARRAY["dimension_v"]);
  "rank_v" := 1;
  LOOP
    "i" := 1;
    <<assign_next_rank>>
    LOOP
      IF "rank_ary"["i"] ISNULL THEN
        "j" := 1;
        LOOP
          IF
            "i" != "j" AND
            "rank_ary"["j"] ISNULL AND
            ( "matrix_b"["j"]["i"] OR
              
              ( "matrix_b"["j"]["i"] ISNULL AND
                "j" < "i" ) )
          THEN
            
            EXIT;
          END IF;
          IF "j" = "dimension_v" THEN
            
            "rank_ary"["i"] := "rank_v";
            EXIT assign_next_rank;
          END IF;
          "j" := "j" + 1;
        END LOOP;
      END IF;
      "i" := "i" + 1;
      IF "i" > "dimension_v" THEN
        RAISE EXCEPTION ''Schulze ranking does not compute (should not happen)'';
      END IF;
    END LOOP;
    EXIT WHEN "rank_v" = "dimension_v";
    "rank_v" := "rank_v" + 1;
  END LOOP;
  
  "i" := 2;  
  FOR "initiative_id_v" IN
    SELECT "id" FROM "initiative"
    WHERE "issue_id" = "issue_id_p" AND "admitted"
    ORDER BY "id"
  LOOP
    UPDATE "initiative" SET
      "direct_majority" =
        CASE WHEN "policy_row"."direct_majority_strict" THEN
          "positive_votes" * "policy_row"."direct_majority_den" >
          "policy_row"."direct_majority_num" * ("positive_votes"+"negative_votes")
        ELSE
          "positive_votes" * "policy_row"."direct_majority_den" >=
          "policy_row"."direct_majority_num" * ("positive_votes"+"negative_votes")
        END
        AND "positive_votes" >= "policy_row"."direct_majority_positive"
        AND "issue_row"."voter_count"-"negative_votes" >=
            "policy_row"."direct_majority_non_negative",
        "indirect_majority" =
        CASE WHEN "policy_row"."indirect_majority_strict" THEN
          "positive_votes" * "policy_row"."indirect_majority_den" >
          "policy_row"."indirect_majority_num" * ("positive_votes"+"negative_votes")
        ELSE
          "positive_votes" * "policy_row"."indirect_majority_den" >=
          "policy_row"."indirect_majority_num" * ("positive_votes"+"negative_votes")
        END
        AND "positive_votes" >= "policy_row"."indirect_majority_positive"
        AND "issue_row"."voter_count"-"negative_votes" >=
            "policy_row"."indirect_majority_non_negative",
      "schulze_rank"           = "rank_ary"["i"],
      "better_than_status_quo" = "rank_ary"["i"] < "rank_ary"[1],
      "worse_than_status_quo"  = "rank_ary"["i"] > "rank_ary"[1],
      "multistage_majority"    = "rank_ary"["i"] >= "rank_ary"[1],
      "reverse_beat_path"      = CASE WHEN "policy_row"."defeat_strength" = ''simple''::"defeat_strength"
                                 THEN NULL
                                 ELSE "matrix_p"[1]["i"]."primary" >= 0 END,
      "eligible"               = FALSE,
      "winner"                 = FALSE,
      "rank"                   = NULL  
      WHERE "id" = "initiative_id_v";
    "i" := "i" + 1;
  END LOOP;
  IF "i" != "dimension_v" + 1 THEN
    RAISE EXCEPTION ''Wrong winner count (should not happen)'';
  END IF;
  
  LOOP
    UPDATE "initiative" SET "indirect_majority" = TRUE
      FROM (
        SELECT "new_initiative"."id" AS "initiative_id"
        FROM "initiative" "old_initiative"
        JOIN "initiative" "new_initiative"
          ON "new_initiative"."issue_id" = "issue_id_p"
          AND "new_initiative"."indirect_majority" = FALSE
        JOIN "battle" "battle_win"
          ON "battle_win"."issue_id" = "issue_id_p"
          AND "battle_win"."winning_initiative_id" = "new_initiative"."id"
          AND "battle_win"."losing_initiative_id" = "old_initiative"."id"
        JOIN "battle" "battle_lose"
          ON "battle_lose"."issue_id" = "issue_id_p"
          AND "battle_lose"."losing_initiative_id" = "new_initiative"."id"
          AND "battle_lose"."winning_initiative_id" = "old_initiative"."id"
        WHERE "old_initiative"."issue_id" = "issue_id_p"
        AND "old_initiative"."indirect_majority" = TRUE
        AND CASE WHEN "policy_row"."indirect_majority_strict" THEN
          "battle_win"."count" * "policy_row"."indirect_majority_den" >
          "policy_row"."indirect_majority_num" *
          ("battle_win"."count"+"battle_lose"."count")
        ELSE
          "battle_win"."count" * "policy_row"."indirect_majority_den" >=
          "policy_row"."indirect_majority_num" *
          ("battle_win"."count"+"battle_lose"."count")
        END
        AND "battle_win"."count" >= "policy_row"."indirect_majority_positive"
        AND "issue_row"."voter_count"-"battle_lose"."count" >=
            "policy_row"."indirect_majority_non_negative"
      ) AS "subquery"
      WHERE "id" = "subquery"."initiative_id";
    EXIT WHEN NOT FOUND;
  END LOOP;
  
  UPDATE "initiative" SET "multistage_majority" = TRUE
    FROM (
      SELECT "losing_initiative"."id" AS "initiative_id"
      FROM "initiative" "losing_initiative"
      JOIN "initiative" "winning_initiative"
        ON "winning_initiative"."issue_id" = "issue_id_p"
        AND "winning_initiative"."admitted"
      JOIN "battle" "battle_win"
        ON "battle_win"."issue_id" = "issue_id_p"
        AND "battle_win"."winning_initiative_id" = "winning_initiative"."id"
        AND "battle_win"."losing_initiative_id" = "losing_initiative"."id"
      JOIN "battle" "battle_lose"
        ON "battle_lose"."issue_id" = "issue_id_p"
        AND "battle_lose"."losing_initiative_id" = "winning_initiative"."id"
        AND "battle_lose"."winning_initiative_id" = "losing_initiative"."id"
      WHERE "losing_initiative"."issue_id" = "issue_id_p"
      AND "losing_initiative"."admitted"
      AND "winning_initiative"."schulze_rank" <
          "losing_initiative"."schulze_rank"
      AND "battle_win"."count" > "battle_lose"."count"
      AND (
        "battle_win"."count" > "winning_initiative"."positive_votes" OR
        "battle_lose"."count" < "losing_initiative"."negative_votes" )
    ) AS "subquery"
    WHERE "id" = "subquery"."initiative_id";
  
  UPDATE "initiative" SET "eligible" = TRUE
    WHERE "issue_id" = "issue_id_p"
    AND "initiative"."direct_majority"
    AND "initiative"."indirect_majority"
    AND "initiative"."better_than_status_quo"
    AND (
      "policy_row"."no_multistage_majority" = FALSE OR
      "initiative"."multistage_majority" = FALSE )
    AND (
      "policy_row"."no_reverse_beat_path" = FALSE OR
      coalesce("initiative"."reverse_beat_path", FALSE) = FALSE );
  
  UPDATE "initiative" SET "winner" = TRUE
    FROM (
      SELECT "id" AS "initiative_id"
      FROM "initiative"
      WHERE "issue_id" = "issue_id_p" AND "eligible"
      ORDER BY
        "schulze_rank",
        "id"
      LIMIT 1
    ) AS "subquery"
    WHERE "id" = "subquery"."initiative_id";
  
  "rank_v" := 1;
  FOR "initiative_id_v" IN
    SELECT "id"
    FROM "initiative"
    WHERE "issue_id" = "issue_id_p" AND "admitted"
    ORDER BY
      "winner" DESC,
      "eligible" DESC,
      "schulze_rank",
      "id"
  LOOP
    UPDATE "initiative" SET "rank" = "rank_v"
      WHERE "id" = "initiative_id_v";
    "rank_v" := "rank_v" + 1;
  END LOOP;
  
  UPDATE "issue" SET
    "status_quo_schulze_rank" = "rank_ary"[1],
    "state" =
      CASE WHEN EXISTS (
        SELECT NULL FROM "initiative"
        WHERE "issue_id" = "issue_id_p" AND "winner"
      ) THEN
        ''finished_with_winner''::"issue_state"
      ELSE
        ''finished_without_winner''::"issue_state"
      END,
    "closed" = "phase_finished",
    "phase_finished" = NULL
    WHERE "id" = "issue_id_p";
  RETURN;
END' rule: #plpgsqlStatements
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlWhileLoop [
	self
		parse: 'WHILE amount_owed < 42 LOOP
    amount_owed := amount_owed + 1;
END LOOP' rule: #plpgsqlWhileLoop;
		parse: 'WHILE amount_owed < 42 LOOP
    NULL;
END LOOP' rule: #plpgsqlWhileLoop;
		parse: '<<label>>
WHILE amount_owed < 42 LOOP
    NULL;
END LOOP label' rule: #plpgsqlWhileLoop
]

{ #category : #tests }
PSQLGrammarTest >> testSelectCommand [
	self
		parse: 'SELECT 1 + 1' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) *' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) result, other, onemore' rule: #selectCommand;
		parse: 'SELECT ALL id, name, test AS result, other, onemore' rule: #selectCommand;
		parse: 'SELECT count(id) FROM table1' rule: #selectCommand
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testSelectIntoCommand [
	self
		parse: 'SELECT equipe.cle INTO cleequipe FROM personne,affectation,support,equipe WHERE personne.cle = clepersonne::int4 AND clepersonne::int4 = personne.cle AND	abandon::bool = FALSE AND support.cle_personne = personne.cle AND affectation.cle_support = support.cle AND affectation.cle_equipe = equipe.cle AND (dateobservation::date > affectation.debut AND (dateobservation::date <= affectation.fin OR dateobservation::date <= (affectation.fin + ''1 YEAR''::INTERVAL)))' rule: #selectIntoCommand;
		parse: 'SELECT cle INTO clepersonne FROM personne WHERE uidpersonne = uid' rule: #selectIntoCommand
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testSubscript [
	self
		parse: 'identifier[1]' rule: #expression;
		parse: 'identifier[4:59]' rule: #expression;
		parse: 'mytable.arraycolumn[4]' rule: #expression;
		parse: 'mytable.two_d_column[17][34]' rule: #expression;
		parse: '$1[10:42]' rule: #expression;
		parse: '(arrayfunction(a,b))[42]' rule: #expression
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testUnaryPostfixOperator [
	self
		parse: '42++' rule: #expression;
		parse: 'id--' rule: #expression;
		parse: '1++--' rule: #expression;
		parse: '$1++' rule: #expression
]

{ #category : #tests-accessing }
PSQLGrammarTest >> testUnaryPrefixOperator [
	self
		parse: '++42' rule: #expression;
		parse: '--id' rule: #expression;
		parse: '++(--1)' rule: #expression;
		parse: '++$1' rule: #expression
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testUnionIntersectExceptClause [
	self
		parse: 'UNION SELECT * FROM sales2007q2' rule: #unionIntersectExceptClause;
		parse: 'UNION ALL SELECT * FROM sales2007q2' rule: #unionIntersectExceptClause;
		parse: 'UNION ALL SELECT * FROM sales2007q2 ORDER BY name ASC, amount DESC' rule: #unionIntersectExceptClause;
		parse: 'EXCEPT SELECT DISTINCT inventory.film_id, title FROM inventory INNER JOIN film ON film.film_id = inventory.film_id ORDER BY title' rule: #unionIntersectExceptClause;
		parse: 'INTERSECT SELECT employee_id FROM hipos' rule: #unionIntersectExceptClause;
		parse: 'INTERSECT SELECT employee_id FROM hipos ORDER BY employee_id' rule: #unionIntersectExceptClause
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testWhereClause [
	self
		parse: 'WHERE 1 + 1 = 2' rule: #whereClause;
		parse: 'WHERE table.id = 42' rule: #whereClause;
		parse: 'WHERE fct(table)  = ''test''' rule: #whereClause;
		parse: 'WHERE personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL' rule: #whereClause;
		parse: 'WHERE ((((support.cle_grade = grade.cle) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND ((grade.cle = 27) OR (grade.cle = 17)))' rule: #whereClause;
		parse: 'WHERE (((((((personne.cle = support.cle_personne) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND ((categorie.categorie)::text = ''PERMANENT''::text)) AND (support.cle_employeur = employeur.cle)) AND (((((support.cle_employeur = 1) OR (support.cle_employeur = 15)) OR (support.cle_employeur = 2)) OR (support.cle_employeur = 3)) OR (support.cle_employeur = 107))) AND ((grade.cle_catgrade)::text = ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text])))' rule: #whereClause
]
