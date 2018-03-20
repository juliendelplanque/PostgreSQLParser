Class {
	#name : #PSQLUpdateQueryGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLUpdateQueryGrammarTest >> parserClass [
	^ PSQLUpdateQueryGrammar
]

{ #category : #'tests-update command' }
PSQLUpdateQueryGrammarTest >> testUpdateCommand [
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
