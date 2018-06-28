Class {
	#name : #PSQLPlpgSQLGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #'PostgreSQL-Parser-Tests'
}

{ #category : #accessing }
PSQLPlpgSQLGrammarTest >> parserClass [
	^ PSQLPlpgSQLGrammar
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlAliasDeclaration [
	self
		parse: 'subtotal ALIAS FOR $1' rule: #plpgsqlAliasDeclaration;
		parse: 'v_string ALIAS FOR $1' rule: #plpgsqlAliasDeclaration;
		parse: 'index ALIAS FOR $2' rule: #plpgsqlAliasDeclaration;
		parse: 'prior ALIAS FOR old' rule: #plpgsqlAliasDeclaration;
		parse: 'updated ALIAS FOR new' rule: #plpgsqlAliasDeclaration
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlArrayLoop [
	self
		parse: 'FOREACH x IN ARRAY $1
  LOOP
    s := s + x;
  END LOOP' rule: #plpgsqlArrayLoop
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlAssertStatement [
	self
		parse: 'ASSERT 1 + 1 = 2' rule: #plpgsqlAssertStatement;
		parse: 'ASSERT 1 + 1 = 2, ''KO''' rule: #plpgsqlAssertStatement;
		parse: 'ASSERT 1 + 1 = 2, ''Should'' || notBeRaised()' rule: #plpgsqlAssertStatement
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlAssignmentStatement [
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
        )::"link_strength"' rule: #plpgsqlAssignmentStatement;
	parse: 'date2 := date1 - interval ''1'' day' rule: #plpgsqlAssignmentStatement
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlBeginLabel [
	self
		parse: '<< outerblock >>' rule: #plpgsqlBeginLabel
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlBody [
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

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlContinuetatement [
	self
		parse: 'CONTINUE WHEN count < 50' rule: #plpgsqlContinueStatement
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlCopyTypeDeclaration [
	self
		parse: 'id table.id%TYPE' rule: #plpgsqlCopyTypeDeclaration
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlCursorClose [
	self
		parse: 'CLOSE curs1' rule: #plpgsqlCursorClose
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlCursorDeclaration [
	self
		parse: 'curs2 SCROLL CURSOR FOR SELECT * FROM tenk1' rule: #plpgsqlCursorDeclaration;
		parse: 'curs3 CURSOR (key integer) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlCursorDeclaration;
		parse: 'curs3 NO SCROLL CURSOR (key integer, key2 char , key3 varchar) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlCursorDeclaration
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlCursorDelete [
	self
		parse: 'DELETE FROM table WHERE CURRENT OF cursor' rule: #plpgsqlCursorDelete
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlCursorFetch [
	self
		parse: 'FETCH curs1 INTO rowvar' rule: #plpgsqlCursorFetch;
		parse: 'FETCH curs2 INTO foo, bar, baz' rule: #plpgsqlCursorFetch;
		parse: 'FETCH LAST FROM curs3 INTO x, y' rule: #plpgsqlCursorFetch;
		parse: 'FETCH RELATIVE -2 FROM curs4 INTO x' rule: #plpgsqlCursorFetch
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlCursorForLoop [
	self
		parse: 'FOR record_var in curs1 (key1 := 1, key2 := 42) LOOP
	var := record;
END LOOP' rule: #plpgsqlCursorForLoop
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlCursorMove [
	self
		parse: 'MOVE curs1' rule: #plpgsqlCursorMove;
		parse: 'MOVE LAST FROM curs3' rule: #plpgsqlCursorMove;
		parse: 'MOVE RELATIVE -2 FROM curs4' rule: #plpgsqlCursorMove;
		parse: 'MOVE FORWARD 2 FROM curs4' rule: #plpgsqlCursorMove
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlCursorUpdate [
	self
		parse: 'UPDATE foo SET dataval = myval WHERE CURRENT OF curs1' rule: #plpgsqlCursorUpdate
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlDeclarationCollate [
	self
		parse: 'COLLATE "en_US"' rule: #plpgsqlDeclarationCollate;
		parse: 'COLLATE "C"' rule: #plpgsqlDeclarationCollate
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlDeclarationItem [
	self
		parse: 'user_id integer' rule: #plpgsqlDeclarationItem;
		parse: 'quantity numeric(5)' rule: #plpgsqlDeclarationItem;
		parse: 'url varchar' rule: #plpgsqlDeclarationItem;
		parse: 'myrow tablename%ROWTYPE' rule: #plpgsqlDeclarationItem;
		parse: 'myfield tablename.columnname%TYPE' rule: #plpgsqlDeclarationItem;
		parse: 'arow RECORD' rule: #plpgsqlDeclarationItem;
		parse: 'curs1 refcursor' rule: #plpgsqlDeclarationItem;
		parse: 'curs2 SCROLL CURSOR FOR SELECT * FROM tenk1' rule: #plpgsqlDeclarationItem;
		parse: 'curs3 CURSOR (key integer) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlDeclarationItem;
		parse: 'curs3 NO SCROLL CURSOR (key integer, key2 char , key3 varchar) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlDeclarationItem
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlDeclarationType [
	self
		parse: 'integer' rule: #plpgsqlDeclarationType;
		parse: 'varchar' rule: #plpgsqlDeclarationType;
		parse: 'varchar(16)' rule: #plpgsqlDeclarationType;
		parse: 'char(5)[][]' rule: #plpgsqlDeclarationType;
		parse: 'varying char(16)[][]' rule: #plpgsqlDeclarationType
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlDeclarations [
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

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlExceptionHandler [
	self
		parse: 'BEGIN
    x := x + 1;
    y := x / 0;
EXCEPTION
    WHEN division_by_zero THEN
        RETURN x;
END' rule: #plpgsqlExceptionHandler
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlExecuteStatement [
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

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlExitStatement [
	self
		parse: 'EXIT' rule: #plpgsqlExitStatement;
		parse: 'EXIT WHEN count > 0' rule: #plpgsqlExitStatement;
		parse: 'EXIT ablock' rule: #plpgsqlExitStatement;
		parse: 'EXIT ablock WHEN count > 0' rule: #plpgsqlExitStatement
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlForLoop [
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
END LOOP label' rule: #plpgsqlForLoop;
		parse: 'FOR i IN k..nbrspechar LOOP
			resultat := regexp_replace(resultat,spechar[i],lettres[i],''g'');
		END LOOP' rule: #plpgsqlForLoop
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlIfThen [
	self
		parse: 'IF v_user_id <> 0 THEN
    v_user_id := 42;
END IF' rule: #plpgsqlIfThen;
		parse: 'IF "policy_row"."tie_breaking" != ''simple''::"tie_breaking" THEN
	NULL;
END IF' rule: #plpgsqlIfThen
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlIfThenElse [
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

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlIfThenElsif [
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
END IF' rule: #plpgsqlIfThenElsif;
	parse: 'IF x = 1 THEN
	stmt := 1;
ELSE IF x = 2 THEN
	stmt := 2;
ELSIF x = 3 THEN
	stmt := 3;
ELSE
	stmt := stmt +1;
END IF' rule: #plpgsqlIfThenElsif
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlIndexParameter [
	self
		parse: '$1' rule: #plpgsqlIndexParameter;
		parse: '$42' rule: #plpgsqlIndexParameter
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlLoopLoop [
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

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlNullStatement [
	self
		parse: 'NULL' rule: #plpgsqlNullStatement";
		parse: '    
' rule: #plpgsqlNullStatement"
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlOpenCursorBounded [
	self
		parse: 'OPEN curs2' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(42)' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(key := 42)' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(key := 42, key2 := ''test'')' rule: #plpgsqlOpenCursorBounded
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlOpenCursorForExecute [
	self
		parse: 'OPEN curs1 FOR EXECUTE format(''SELECT * FROM %I WHERE col1 = $1'',tabname) USING keyvalue' rule: #plpgsqlOpenCursorForExecute
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlOpenCursorForQuery [
	self
		parse: 'OPEN curs1 FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery;
		parse: 'OPEN curs1 NO SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery;
		parse: 'OPEN curs1 SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlPerformStatement [
	self
		parse: 'PERFORM "require_transaction_isolation"()' rule: #plpgsqlPerformStatement
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlQueryResultsLoop [
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
	END LOOP' rule: #plpgsqlQueryResultsLoop
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlRaiseStatement [
	self
		parse: 'RAISE NOTICE ''Calling cs_create_job(%)'', v_job_id' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE EXCEPTION ''Nonexistent ID --> %'', user_id
      USING HINT = ''Please check your user ID''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE ''Duplicate user ID: %'', user_id USING ERRCODE = ''unique_violation''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE ''Duplicate user ID: %'', user_id USING ERRCODE = ''23505''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE division_by_zero' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE unique_violation USING MESSAGE = ''Duplicate user ID: '' || user_id' rule: #plpgsqlRaiseStatement
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlRaiseStatement1 [
	self
		parse: 'RAISE EXCEPTION ''Nonexistent ID --> %'', user_id
      USING HINT = ''Please check your user ID''' rule: #plpgsqlRaiseStatement1
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlRaiseStatement2 [
	self
		parse: 'RAISE division_by_zero' rule: #plpgsqlRaiseStatement2;
		parse: 'RAISE division_by_zero USING ERRCODE = ''1234''' rule: #plpgsqlRaiseStatement2
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlRaiseStatement3 [
	self
		parse: 'RAISE INFO SQLSTATE ''22012''' rule: #plpgsqlRaiseStatement3;
		parse: 'RAISE INFO SQLSTATE ''22012'' USING ERRCODE = ''err''' rule: #plpgsqlRaiseStatement3
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlRaiseStatement4 [
	self
		parse: 'RAISE INFO USING ERRCODE = ''23505''' rule: #plpgsqlRaiseStatement4;
		parse: 'RAISE INFO USING ERRCODE = ''23505'' , OTHER = ''test''' rule: #plpgsqlRaiseStatement4
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlRaiseStatement5 [
	self
		parse: 'RAISE' rule: #plpgsqlRaiseStatement5
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlRecordDeclaration [
	self
		parse: 'identifier RECORD' rule: #plpgsqlRecordDeclaration
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlResultValueStatement [
	self
		parse: 'GET DIAGNOSTICS integer_var = ROW_COUNT' rule: #plpgsqlResultValueStatement
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlReturn [
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
                    AND flightdate < ($1 + 1)''' rule: #plpgsqlReturn;
		parse: 'RETURN (1, 2, ''three''::text)' rule: #plpgsqlReturn;
		parse: 'RETURN' rule: #plpgsqlReturn;
		parse: 'RETURN ts_headline(''pg_catalog.simple'', replace(replace("body_p", e''\\'', e''\\\\''), ''*'', e''\\*''), "text_search_query"("query_text_p"), ''StartSel=* StopSel=* HighlightAll=TRUE'' )' rule: #plpgsqlReturn
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlRowTypeDeclaration [
	self
		parse: 't2_row table2%ROWTYPE' rule: #plpgsqlRowTypeDeclaration
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlSearchedCase [
	self
		parse: 'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
    ELSE
        msg := ''other value than one or two'';
END CASE' rule: #plpgsqlSearchedCase;
		parse: 'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
	WHEN 3, 4 THEN
        msg := ''three or four'';
END CASE' rule: #plpgsqlSearchedCase
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlSimpleCase [
	self
		parse: 'CASE
    WHEN x < 10 THEN
        msg := ''value is smaller than ten'';
    WHEN x < 20 THEN
        msg := ''value is smaller tham twenty'';
END CASE' rule: #plpgsqlSimpleCase;
		parse: 'CASE
    WHEN x < 10 THEN
        msg := ''value is smaller than ten'';
    ELSE
        msg := ''KO'';
END CASE' rule: #plpgsqlSimpleCase;
		parse: 'CASE
                     WHEN "matrix_f"["i"]["j"]
                     THEN ((-1::INT8) << 63, 0)::"link_strength"
                     ELSE "matrix_d"["i"]["j"] END CASE' rule: #plpgsqlSimpleCase
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlStatement [
	self
		parse: 'v_user_id := 42' rule: #plpgsqlStatement;
		parse: '((-1::INT8) << 63, 0)::"link_strength"' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 FOR EXECUTE format(''SELECT * FROM %I WHERE col1 = $1'',tabname) USING keyvalue' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 NO SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlStatement;
		parse: 'OPEN curs2' rule: #plpgsqlStatement;
		parse: 'OPEN curs3(42)' rule: #plpgsqlStatement;
		parse: 'OPEN curs3(key := 42)' rule: #plpgsqlStatement;
		parse: 'OPEN curs3(key := 42, key2 := ''test'')' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 FOR EXECUTE format(''SELECT * FROM %I WHERE col1 = $1'',tabname) USING keyvalue' rule: #plpgsqlStatement;
		parse: 'FETCH curs1 INTO rowvar' rule: #plpgsqlStatement;
		parse: 'FETCH curs2 INTO foo, bar, baz' rule: #plpgsqlStatement;
		parse: 'FETCH LAST FROM curs3 INTO x, y' rule: #plpgsqlStatement;
		parse: 'FETCH RELATIVE -2 FROM curs4 INTO x' rule: #plpgsqlStatement;
		parse: 'MOVE curs1' rule: #plpgsqlStatement;
		parse: 'MOVE LAST FROM curs3' rule: #plpgsqlStatement;
		parse: 'MOVE RELATIVE -2 FROM curs4' rule: #plpgsqlStatement;
		parse: 'MOVE FORWARD 2 FROM curs4' rule: #plpgsqlStatement;
		parse: 'DELETE FROM table WHERE CURRENT OF cursor' rule: #plpgsqlStatement;
		parse: 'UPDATE foo SET dataval = myval WHERE CURRENT OF curs1' rule: #plpgsqlStatement;
		parse: 'CLOSE curs1' rule: #plpgsqlStatement;
		parse: 'FOR record_var in curs1 (key1 := 1, key2 := 42) LOOP
	var := record;
END LOOP' rule: #plpgsqlStatement;
		parse: 'FOR "output_row" IN
            SELECT * FROM
            "delegation_chain_for_closed_issue"("member_id_p", "issue_id_p")
          LOOP
            RETURN NEXT "output_row";
          END LOOP' rule: #plpgsqlStatement
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlStatements [
	self
		parse: 'v_user_id := 42 ; v_user_id := 42 ;' rule: #plpgsqlStatements;
		parse: 'resultat := str;
		FOR i IN 1 .. nbrspechar LOOP
			resultat := regexp_replace(resultat,spechar[i],lettres[i],''g'');
		END LOOP;' rule: #plpgsqlStatements;
		parse: 'PERFORM "require_transaction_isolation"();
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
  RETURN;' rule: #plpgsqlStatements
]

{ #category : #'tests-plpgsql' }
PSQLPlpgSQLGrammarTest >> testPlpgsqlWhileLoop [
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
