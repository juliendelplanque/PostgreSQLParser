Class {
	#name : #PSQLSelectQueryGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLSelectQueryGrammarTest >> parserClass [
	^ PSQLSelectQueryGrammar
]

{ #category : #tests }
PSQLSelectQueryGrammarTest >> testAllOrDistinctClause [
	self
		parse: 'ALL' rule: #allOrDistinctClause;
		parse: 'DISTINCT' rule: #allOrDistinctClause;
		parse: 'DISTINCT ON (id)' rule: #allOrDistinctClause;
		parse: 'DISTINCT ON (id , name,company)' rule: #allOrDistinctClause
]

{ #category : #tests }
PSQLSelectQueryGrammarTest >> testColumnsAndAliasesSelected [
	self
		parse: 'kind, sum(len) AS total' rule: #columnsAndAliasesSelected;
		parse: 'actors.name' rule: #columnsAndAliasesSelected;
		parse: 'COUNT(*), foo' rule: #columnsAndAliasesSelected
]

{ #category : #tests-accessing }
PSQLSelectQueryGrammarTest >> testFetchClause [
	self
		parse: 'FETCH FIRST ROW ONLY' rule: #fetchClause;
		parse: 'FETCH FIRST 42 ROWS ONLY' rule: #fetchClause;
		parse: 'FETCH NEXT ROW ONLY' rule: #fetchClause;
		parse: 'FETCH NEXT 42 ROWS ONLY' rule: #fetchClause
]

{ #category : #'tests-select command' }
PSQLSelectQueryGrammarTest >> testForClause [
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
PSQLSelectQueryGrammarTest >> testGroupByClause [
	self
		parse: 'GROUP BY table."column_name"' rule: #groupByClause;
		parse: 'GROUP BY table."column_name", table."column_name2",table.column_name3' rule: #groupByClause
]

{ #category : #tests-accessing }
PSQLSelectQueryGrammarTest >> testHavingClause [
	self
		parse: 'HAVING count(name) < 2' rule: #havingClause
]

{ #category : #tests-accessing }
PSQLSelectQueryGrammarTest >> testLimitClause [
	self
		parse: 'LIMIT 42' rule: #limitClause;
		parse: 'LIMIT ALL' rule: #limitClause
]

{ #category : #tests-accessing }
PSQLSelectQueryGrammarTest >> testOffsetClause [
	self
		parse: 'OFFSET 25' rule: #offsetClause
]

{ #category : #'tests-select command' }
PSQLSelectQueryGrammarTest >> testSelectCommand [
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
PSQLSelectQueryGrammarTest >> testSelectIntoCommand [
	self
		parse: 'SELECT equipe.cle INTO cleequipe FROM personne,affectation,support,equipe WHERE personne.cle = clepersonne::int4 AND clepersonne::int4 = personne.cle AND	abandon::bool = FALSE AND support.cle_personne = personne.cle AND affectation.cle_support = support.cle AND affectation.cle_equipe = equipe.cle AND (dateobservation::date > affectation.debut AND (dateobservation::date <= affectation.fin OR dateobservation::date <= (affectation.fin + ''1 YEAR''::INTERVAL)))' rule: #selectIntoCommand;
		parse: 'SELECT cle INTO clepersonne FROM personne WHERE uidpersonne = uid' rule: #selectIntoCommand;
		parse: 'SELECT INTO "issue_row" * FROM "issue" WHERE "id" = "issue_id_p"' rule: #selectIntoCommand
]

{ #category : #'tests-select command' }
PSQLSelectQueryGrammarTest >> testSelectIntoCommandAlternative [
	self
		parse: 'SELECT INTO "issue_row" * FROM "issue" WHERE "id" = "issue_id_p"' rule: #selectIntoCommandAlternative
]

{ #category : #'tests-select command' }
PSQLSelectQueryGrammarTest >> testUnionIntersectExceptClause [
	self
		parse: 'UNION SELECT * FROM sales2007q2' rule: #unionIntersectExceptClause;
		parse: 'UNION ALL SELECT * FROM sales2007q2' rule: #unionIntersectExceptClause;
		parse: 'UNION ALL SELECT * FROM sales2007q2 ORDER BY name ASC, amount DESC' rule: #unionIntersectExceptClause;
		parse: 'EXCEPT SELECT DISTINCT inventory.film_id, title FROM inventory INNER JOIN film ON film.film_id = inventory.film_id ORDER BY title' rule: #unionIntersectExceptClause;
		parse: 'INTERSECT SELECT employee_id FROM hipos' rule: #unionIntersectExceptClause;
		parse: 'INTERSECT SELECT employee_id FROM hipos ORDER BY employee_id' rule: #unionIntersectExceptClause
]

{ #category : #'tests-select command' }
PSQLSelectQueryGrammarTest >> testWhereClause [
	self
		parse: 'WHERE 1 + 1 = 2' rule: #whereClause;
		parse: 'WHERE table.id = 42' rule: #whereClause;
		parse: 'WHERE fct(table)  = ''test''' rule: #whereClause;
		parse: 'WHERE personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL' rule: #whereClause;
		parse: 'WHERE ((((support.cle_grade = grade.cle) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND ((grade.cle = 27) OR (grade.cle = 17)))' rule: #whereClause;
		parse: 'WHERE (((((((personne.cle = support.cle_personne) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND ((categorie.categorie)::text = ''PERMANENT''::text)) AND (support.cle_employeur = employeur.cle)) AND (((((support.cle_employeur = 1) OR (support.cle_employeur = 15)) OR (support.cle_employeur = 2)) OR (support.cle_employeur = 3)) OR (support.cle_employeur = 107))) AND ((grade.cle_catgrade)::text = ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text])))' rule: #whereClause
]
