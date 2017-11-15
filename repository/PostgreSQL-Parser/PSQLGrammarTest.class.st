Class {
	#name : #PSQLGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
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
	self
		parse: 'CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END' rule: #conditionalExpression;
		parse: 'CASE WHEN 1 = 1 THEN ''Ok'' ELSE CASE WHEN 1 = 2 THEN ''Ooops''::text END END' rule: #conditionalExpression;
		parse: 'CASE WHEN "policy_row"."defeat_strength" = ''simple''::"defeat_strength" THEN NULL ELSE "matrix_p"[1]["i"]."primary" >= 0 END' rule: #conditionalExpression
]

{ #category : #'tests-insert command' }
PSQLGrammarTest >> testConflictTarget [
	self
		parse: '(did)' rule: #conflictTarget
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

{ #category : #'tests-delete command' }
PSQLGrammarTest >> testDeleteCommand [
	self
		parse: 'DELETE FROM films USING producers WHERE producer_id = producers.id AND producers.name = ''foo''' rule: #deleteCommand;
		parse: 'DELETE FROM films WHERE producer_id IN (SELECT id FROM producers WHERE name = ''foo'')' rule: #deleteCommand;
		parse: 'DELETE FROM films WHERE kind <> ''Musical''' rule: #deleteCommand;
		parse: 'DELETE FROM films' rule: #deleteCommand;
		parse: 'DELETE FROM tasks WHERE status = ''DONE'' RETURNING *' rule: #deleteCommand;
		parse: 'DELETE FROM tasks WHERE CURRENT OF c_tasks' rule: #deleteCommand;
		parse: 'WITH t AS (
    DELETE FROM foo
)
DELETE FROM bar' rule: #deleteCommand
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
		parse: '((-1::INT8) << 63, 0)::"link_strength"' rule: #expression;
		fail: 'a..nbrspechar' rule: #expression;
		parse: '''{{" "," "," "},{" "," "," "},{" "," "," "}}''' rule: #expression;
		parse: '"matrix_p"[1]["i"]."primary" >= 0' rule: #expression;
		parse: '(SELECT * FROM table) AS subquery' rule: #expression;
		parse: 'e''\\''' rule: #expression;
		parse: 'ts_headline(''pg_catalog.simple'', replace(replace("body_p", e''\\'', e''\\\\''), ''*'', e''\\*''), "text_search_query"("query_text_p"), ''StartSel=* StopSel=* HighlightAll=TRUE'' )' rule: #expression;
		parse: '"weight_ary"["i"]::INTEGER' rule: #expression;
		parse: '"weight_ary"["i"]::NUMERIC(18,19)' rule: #expression;
		parse: '"weight_ary"["i"]::NUMERIC(18,9)::NUMERIC(12,3)' rule: #expression
]

{ #category : #tests-expression }
PSQLGrammarTest >> testExtractFunctionCall [
	self
		parse: 'EXTRACT(MONTH FROM dateobservation)' rule: #extractFunctionCall;
		parse: 'EXTRACT(DAY FROM origine)' rule: #extractFunctionCall;
		parse: 'EXTRACT(MONTH FROM origine)' rule: #extractFunctionCall
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

{ #category : #tests-shared }
PSQLGrammarTest >> testFromClause [
	"A smoke test with multiple FROM clauses extracted from existing open-source schemas."
	self
		parse: 'FROM "initiative"' rule: #fromClause;
		parse: 'FROM "area_delegation" LEFT JOIN "membership"' rule: #fromClause;
		parse: 'FROM affectation,support,personne' rule: #fromClause;
		parse: 'FROM (((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle))), grade, typesupport, employeur' rule: #fromClause
]

{ #category : #tests-shared }
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

{ #category : #tests-shared }
PSQLGrammarTest >> testFromItems1 [
	self
		parse: 'ONLY table * AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'table * AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'ONLY table AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'ONLY table *' rule: #fromItems1
]

{ #category : #tests-shared }
PSQLGrammarTest >> testFromItems2 [
	self
		parse: '(SELECT * FROM table) AS alias' rule: #fromItems2;
		parse: '(SELECT * FROM table) AS alias (c1,c2,C3)' rule: #fromItems2;
		parse: '(VALUES (1, ''one''), (2, ''two''), (3, ''three'')) alias (c1 , c2)' rule: #fromItems2;
		parse: '(
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
      ) AS "subquery"' rule: #fromItems2
]

{ #category : #tests-shared }
PSQLGrammarTest >> testFromItems3 [
	self
		parse: 'queryName' rule: #fromItems3;
		parse: 'queryName as aliasName' rule: #fromItems3;
		parse: 'queryName AS aliasName (c1,C2, c3   )' rule: #fromItems3
]

{ #category : #tests-shared }
PSQLGrammarTest >> testFromItems4 [
	self
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE) AS mbrs( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #fromItems4;
		parse: 'membres(1, (now())::date) membres(clepersonne integer, datearrivee date, sexe character varying, nompersonne character varying, prenompersonne character varying, datenaissance date, paysorigine character varying, nomcategorie character varying, corps character varying, typedusupport character varying, numsection smallint, numcmu smallint, debutsupport date, finsupport date, nomequipes text, nomemployeur character varying, nomenseignement character varying, typefinancement character varying, financeurs text, reffinancement character varying, responsablethese text)' rule: #fromItems4
]

{ #category : #tests-shared }
PSQLGrammarTest >> testFromItems5 [
	self
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE) AS ( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #fromItems5
]

{ #category : #tests-shared }
PSQLGrammarTest >> testFromItems6 [
	self
		parse: 'JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"' rule: #fromItems6;
		parse: 'LEFT JOIN "membership"' rule: #fromItems6
]

{ #category : #tests-shared }
PSQLGrammarTest >> testFromItems7 [
	self
		parse: 'function(1, "a") aliasName' rule: #fromItems7;
		parse: 'function(1, "a") AS aliasName (c1, C2, "C3")' rule: #fromItems7;
		parse: 'function(1, "a") aliasName (c1, C2, "C3")' rule: #fromItems7
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

{ #category : #'tests-insert command' }
PSQLGrammarTest >> testInsertCommand [
	self
		parse: 'INSERT INTO films VALUES
    (''UA502'', ''Bananas'', 105, ''1971-07-13'', ''Comedy'', ''82 minutes'')' rule: #insertCommand;
		parse: 'INSERT INTO films (code, title, did, date_prod, kind) VALUES (''T_601'', ''Yojimbo'', 106, ''1961-06-16'', ''Drama'')' rule: #insertCommand;
		parse: 'INSERT INTO films VALUES (''UA502'', ''Bananas'', 105, DEFAULT, ''Comedy'', ''82 minutes'')' rule: #insertCommand;
		parse: 'INSERT INTO films (code, title, did, date_prod, kind) VALUES (''T_601'', ''Yojimbo'', 106, DEFAULT, ''Drama'')' rule: #insertCommand;
		parse: 'INSERT INTO films DEFAULT VALUES' rule: #insertCommand;
		parse: 'INSERT INTO films (code, title, did, date_prod, kind) VALUES (''B6717'', ''Tampopo'', 110, ''1985-02-10'', ''Comedy''), (''HG120'', ''The Dinner Game'', 140, DEFAULT, ''Comedy'')' rule: #insertCommand;
		parse: 'INSERT INTO films SELECT * FROM tmp_films WHERE date_prod < ''2004-05-07''' rule: #insertCommand;
		parse: 'INSERT INTO tictactoe (game, board[1:3][1:3]) VALUES (1, ''{{" "," "," "},{" "," "," "},{" "," "," "}}'')' rule: #insertCommand;
		parse: 'INSERT INTO tictactoe (game, board) VALUES (2, ''{{X," "," "},{" ",O," "},{" ",X," "}}'')' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (DEFAULT, ''XYZ Widgets'') RETURNING did' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (5, ''Gizmo Transglobal''), (6, ''Associated Computing, Inc'') ON CONFLICT (did) DO UPDATE SET dname = EXCLUDED.dname' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (7, ''Redline GmbH'') ON CONFLICT (did) DO NOTHING' rule: #insertCommand;
		parse: 'INSERT INTO distributors AS d (did, dname) VALUES (8, ''Anvil Distribution'') ON CONFLICT (did) DO UPDATE SET dname = EXCLUDED.dname || '' (formerly '' || d.dname || '')'' WHERE d.zipcode <> ''21201''' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (9, ''Antwerp Design'') ON CONFLICT ON CONSTRAINT distributors_pkey DO NOTHING' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (10, ''Conrad International'') ON CONFLICT (did) WHERE is_active DO NOTHING' rule: #insertCommand;
		parse: 'WITH upd AS (
  UPDATE employees SET sales_count = sales_count + 1 WHERE id =
    (SELECT sales_person FROM accounts WHERE name = ''Acme Corporation'')
    RETURNING *
)
INSERT INTO employees_log SELECT *, current_timestamp FROM upd' rule: #insertCommand
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
PSQLGrammarTest >> testPlpgsqlCopyTypeDeclaration [
	self
		parse: 'id table.id%TYPE' rule: #plpgsqlCopyTypeDeclaration
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlCursorClose [
	self
		parse: 'CLOSE curs1' rule: #plpgsqlCursorClose
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlCursorDeclaration [
	self
		parse: 'curs2 SCROLL CURSOR FOR SELECT * FROM tenk1' rule: #plpgsqlCursorDeclaration;
		parse: 'curs3 CURSOR (key integer) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlCursorDeclaration;
		parse: 'curs3 NO SCROLL CURSOR (key integer, key2 char , key3 varchar) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlCursorDeclaration
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlCursorDelete [
	self
		parse: 'DELETE FROM table WHERE CURRENT OF cursor' rule: #plpgsqlCursorDelete
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlCursorFetch [
	self
		parse: 'FETCH curs1 INTO rowvar' rule: #plpgsqlCursorFetch;
		parse: 'FETCH curs2 INTO foo, bar, baz' rule: #plpgsqlCursorFetch;
		parse: 'FETCH LAST FROM curs3 INTO x, y' rule: #plpgsqlCursorFetch;
		parse: 'FETCH RELATIVE -2 FROM curs4 INTO x' rule: #plpgsqlCursorFetch
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlCursorForLoop [
	self
		parse: 'FOR record_var in curs1 (key1 := 1, key2 := 42) LOOP
	var := record;
END LOOP' rule: #plpgsqlCursorForLoop
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlCursorMove [
	self
		parse: 'MOVE curs1' rule: #plpgsqlCursorMove;
		parse: 'MOVE LAST FROM curs3' rule: #plpgsqlCursorMove;
		parse: 'MOVE RELATIVE -2 FROM curs4' rule: #plpgsqlCursorMove;
		parse: 'MOVE FORWARD 2 FROM curs4' rule: #plpgsqlCursorMove
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlCursorUpdate [
	self
		parse: 'UPDATE foo SET dataval = myval WHERE CURRENT OF curs1' rule: #plpgsqlCursorUpdate
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
		parse: 'arow RECORD' rule: #plpgsqlDeclarationItem;
		parse: 'curs1 refcursor' rule: #plpgsqlDeclarationItem;
		parse: 'curs2 SCROLL CURSOR FOR SELECT * FROM tenk1' rule: #plpgsqlDeclarationItem;
		parse: 'curs3 CURSOR (key integer) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlDeclarationItem;
		parse: 'curs3 NO SCROLL CURSOR (key integer, key2 char , key3 varchar) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlDeclarationItem
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlDeclarationType [
	self
		parse: 'integer' rule: #plpgsqlDeclarationType;
		parse: 'varchar' rule: #plpgsqlDeclarationType;
		parse: 'varchar(16)' rule: #plpgsqlDeclarationType;
		parse: 'char(5)[][]' rule: #plpgsqlDeclarationType;
		parse: 'varying char(16)[][]' rule: #plpgsqlDeclarationType
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
END LOOP label' rule: #plpgsqlForLoop;
		parse: 'FOR i IN k..nbrspechar LOOP
			resultat := regexp_replace(resultat,spechar[i],lettres[i],''g'');
		END LOOP'
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

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlIndexParameter [
	self
		parse: '$1' rule: #plpgsqlIndexParameter;
		parse: '$42' rule: #plpgsqlIndexParameter
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
PSQLGrammarTest >> testPlpgsqlOpenCursorBounded [
	self
		parse: 'OPEN curs2' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(42)' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(key := 42)' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(key := 42, key2 := ''test'')' rule: #plpgsqlOpenCursorBounded
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlOpenCursorForExecute [
	self
		parse: 'OPEN curs1 FOR EXECUTE format(''SELECT * FROM %I WHERE col1 = $1'',tabname) USING keyvalue' rule: #plpgsqlOpenCursorForExecute
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlOpenCursorForQuery [
	self
		parse: 'OPEN curs1 FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery;
		parse: 'OPEN curs1 NO SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery;
		parse: 'OPEN curs1 SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery
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
PSQLGrammarTest >> testPlpgsqlRecordDeclaration [
	self
		parse: 'identifier RECORD' rule: #plpgsqlRecordDeclaration
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
                    AND flightdate < ($1 + 1)''' rule: #plpgsqlReturn;
		parse: 'RETURN (1, 2, ''three''::text)' rule: #plpgsqlReturn;
		parse: 'RETURN' rule: #plpgsqlReturn;
		parse: 'RETURN ts_headline(''pg_catalog.simple'', replace(replace("body_p", e''\\'', e''\\\\''), ''*'', e''\\*''), "text_search_query"("query_text_p"), ''StartSel=* StopSel=* HighlightAll=TRUE'' )' rule: #plpgsqlReturn
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlRowTypeDeclaration [
	self
		parse: 't2_row table2%ROWTYPE' rule: #plpgsqlRowTypeDeclaration
]

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlSearchedCase [
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

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlSimpleCase [
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

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlStatement [
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

{ #category : #tests-plpgsql }
PSQLGrammarTest >> testPlpgsqlStatements [
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

{ #category : #tests-shared }
PSQLGrammarTest >> testReturningClause [
	self
		parse: 'RETURNING *' rule: #returningClause;
		parse: 'RETURNING id, name' rule: #returningClause;
		parse: 'RETURNING *,id' rule: #returningClause
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testSelectCommand [
	self
		parse: 'SELECT 1 + 1' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) *' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) result, other, onemore' rule: #selectCommand;
		parse: 'SELECT ALL id, name, test AS result, other, onemore' rule: #selectCommand;
		parse: 'SELECT count(id) FROM table1' rule: #selectCommand;
		parse: 'SELECT "new_initiative"."id" AS "initiative_id"
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
            "policy_row"."indirect_majority_non_negative"' rule: #selectCommand;
		parse: 'SELECT * FROM
            "delegation_chain_for_closed_issue"("member_id_p", "issue_id_p")' rule: #selectCommand;
		parse: 'SELECT *, current_timestamp FROM upd' rule: #selectCommand;
		parse: 'WITH regional_sales AS (
        SELECT region, SUM(amount) AS total_sales
        FROM orders
        GROUP BY region
     ), top_regions AS (
        SELECT region
        FROM regional_sales
        WHERE total_sales > (SELECT SUM(total_sales)/10 FROM regional_sales)
     )
SELECT region,
       product,
       SUM(quantity) AS product_units,
       SUM(amount) AS product_sales
FROM orders
WHERE region IN (SELECT region FROM top_regions)
GROUP BY region, product' rule: #selectCommand
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testSelectIntoCommand [
	self
		parse: 'SELECT equipe.cle INTO cleequipe FROM personne,affectation,support,equipe WHERE personne.cle = clepersonne::int4 AND clepersonne::int4 = personne.cle AND	abandon::bool = FALSE AND support.cle_personne = personne.cle AND affectation.cle_support = support.cle AND affectation.cle_equipe = equipe.cle AND (dateobservation::date > affectation.debut AND (dateobservation::date <= affectation.fin OR dateobservation::date <= (affectation.fin + ''1 YEAR''::INTERVAL)))' rule: #selectIntoCommand;
		parse: 'SELECT cle INTO clepersonne FROM personne WHERE uidpersonne = uid' rule: #selectIntoCommand;
		parse: 'SELECT INTO "issue_row" * FROM "issue" WHERE "id" = "issue_id_p"' rule: #selectIntoCommand
]

{ #category : #'tests-select command' }
PSQLGrammarTest >> testSelectIntoCommandAlternative [
	self
		parse: 'SELECT INTO "issue_row" * FROM "issue" WHERE "id" = "issue_id_p"' rule: #selectIntoCommandAlternative
]

{ #category : #tests-shared }
PSQLGrammarTest >> testSetClause [
	self
		parse: 'SET "reverse_beat_path" = CASE WHEN "policy_row"."defeat_strength" = ''simple''::"defeat_strength" THEN NULL ELSE "matrix_p"[1]["i"]."primary" >= 0 END' rule: #setClause
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

{ #category : #tests-expression }
PSQLGrammarTest >> testTypeCastConstruct [
	self
		parse: '::NUMERIC(18,9)' rule: #typeCastConstruct
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

{ #category : #'tests-update command' }
PSQLGrammarTest >> testUpdateCommand [
	self
		parse: 'UPDATE films SET kind = ''Dramatic'' WHERE kind = ''Drama''' rule: #updateCommand;
		parse: 'UPDATE weather SET temp_lo = temp_lo+1, temp_hi = temp_lo+15, prcp = DEFAULT WHERE city = ''San Francisco'' AND date = ''2003-07-03''' rule: #updateCommand;
		parse: 'UPDATE weather SET temp_lo = temp_lo+1, temp_hi = temp_lo+15, prcp = DEFAULT WHERE city = ''San Francisco'' AND date = ''2003-07-03'' RETURNING temp_lo, temp_hi, prcp' rule: #updateCommand;
		parse: 'UPDATE weather SET (temp_lo, temp_hi, prcp) = (temp_lo+1, temp_lo+15, DEFAULT) WHERE city = ''San Francisco'' AND date = ''2003-07-03''' rule: #updateCommand;
		parse: 'UPDATE employees SET sales_count = sales_count + 1 FROM accounts WHERE accounts.name = ''Acme Corporation'' AND employees.id = accounts.sales_person' rule: #updateCommand;
		parse: 'UPDATE employees SET sales_count = sales_count + 1 WHERE id = (SELECT sales_person FROM accounts WHERE name = ''Acme Corporation'')' rule: #updateCommand;
		parse: 'UPDATE accounts SET (contact_first_name, contact_last_name) = (SELECT first_name, last_name FROM salesmen WHERE salesmen.id = accounts.sales_id)' rule: #updateCommand;
		parse: 'UPDATE accounts SET contact_first_name = first_name, contact_last_name = last_name FROM salesmen WHERE salesmen.id = accounts.sales_id' rule: #updateCommand;
		parse: 'UPDATE summary s SET (sum_x, sum_y, avg_x, avg_y) = (SELECT sum(x), sum(y), avg(x), avg(y) FROM data d WHERE d.group_id = s.group_id)' rule: #updateCommand;
		parse: 'UPDATE wines SET stock = stock + 24 WHERE winename = ''Chateau Lafite 2003''' rule: #updateCommand;
		parse: 'UPDATE films SET kind = ''Dramatic'' WHERE CURRENT OF c_films' rule: #updateCommand;
		parse: 'UPDATE "initiative" SET
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
      WHERE "id" = "initiative_id_v"' rule: #updateCommand;
	parse: 'UPDATE "initiative" SET "indirect_majority" = TRUE
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
      WHERE "id" = "subquery"."initiative_id"' rule: #updateCommand
]

{ #category : #'tests-update command' }
PSQLGrammarTest >> testUpdateDeleteWhereClause [
	self
		parse: 'WHERE id = 5' rule: #updateDeleteWhereClause;
		parse: 'WHERE CURRENT OF curs1' rule: #updateDeleteWhereClause
]

{ #category : #'tests-values command' }
PSQLGrammarTest >> testValuesCommand [
	self
		parse: 'VALUES (1, ''one''), (2, ''two''), (3, ''three'')' rule: #valuesCommand;
		parse: 'VALUES (1, DEFAULT)' rule: #valuesCommand
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

{ #category : #tests-shared }
PSQLGrammarTest >> testWithClause [
	self
		parse: 'WITH table AS (SELECT * FROM foo), table2(id,text) AS (SELECT * FROM bar)' rule: #withClause;
		parse: 'WITH RECURSIVE table AS (SELECT * FROM foo), table2(id,text) AS (SELECT * FROM bar)' rule: #withClause
]

{ #category : #tests-shared }
PSQLGrammarTest >> testWithQuery [
	self
		parse: 'table AS (SELECT * FROM foo)' rule: #withQuery;
		parse: 'table(id,bar) AS (SELECT * FROM foo)' rule: #withQuery
]
