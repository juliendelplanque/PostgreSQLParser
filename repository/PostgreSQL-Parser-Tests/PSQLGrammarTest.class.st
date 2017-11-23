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
		parse: 'actors.name' rule: #columnsAndAliasesSelected;
		parse: 'COUNT(*), foo' rule: #columnsAndAliasesSelected
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
