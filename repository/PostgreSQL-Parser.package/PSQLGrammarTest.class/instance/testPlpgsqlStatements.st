tests-plpgsql
testPlpgsqlStatements
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