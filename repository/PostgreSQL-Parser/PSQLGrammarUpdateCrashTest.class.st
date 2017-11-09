Class {
	#name : #PSQLGrammarUpdateCrashTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLGrammarUpdateCrashTest >> parserClass [
	^ PSQLGrammar
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate0 [
	self
		parse: 'UPDATE actualite SET datecreation = NOW() WHERE cle = NEW.cle' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate1 [
	self
		parse: 'UPDATE listehdr SET dateobtention = NEW.fin WHERE listehdr.cle_personne = OLD.cle_personne' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate10 [
	self
		parse: 'UPDATE "initiative" SET "indirect_majority" = TRUE FROM ( SELECT "new_initiative"."id" AS "initiative_id" FROM "initiative" "old_initiative" JOIN "initiative" "new_initiative" ON "new_initiative"."issue_id" = "issue_id_p" AND "new_initiative"."indirect_majority" = FALSE JOIN "battle" "battle_win" ON "battle_win"."issue_id" = "issue_id_p" AND "battle_win"."winning_initiative_id" = "new_initiative"."id" AND "battle_win"."losing_initiative_id" = "old_initiative"."id" JOIN "battle" "battle_lose" ON "battle_lose"."issue_id" = "issue_id_p" AND "battle_lose"."losing_initiative_id" = "new_initiative"."id" AND "battle_lose"."winning_initiative_id" = "old_initiative"."id" WHERE "old_initiative"."issue_id" = "issue_id_p" AND "old_initiative"."indirect_majority" = TRUE AND CASE WHEN "policy_row"."indirect_majority_strict" THEN "battle_win"."count" * "policy_row"."indirect_majority_den" > "policy_row"."indirect_majority_num" * ("battle_win"."count"+"battle_lose"."count") ELSE "battle_win"."count" * "policy_row"."indirect_majority_den" >= "policy_row"."indirect_majority_num" * ("battle_win"."count"+"battle_lose"."count") END AND "battle_win"."count" >= "policy_row"."indirect_majority_positive" AND "issue_row"."voter_count"-"battle_lose"."count" >= "policy_row"."indirect_majority_non_negative" ) AS "subquery" WHERE "id" = "subquery"."initiative_id"' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate11 [
	self
		parse: 'UPDATE "initiative" SET "multistage_majority" = TRUE FROM ( SELECT "losing_initiative"."id" AS "initiative_id" FROM "initiative" "losing_initiative" JOIN "initiative" "winning_initiative" ON "winning_initiative"."issue_id" = "issue_id_p" AND "winning_initiative"."admitted" JOIN "battle" "battle_win" ON "battle_win"."issue_id" = "issue_id_p" AND "battle_win"."winning_initiative_id" = "winning_initiative"."id" AND "battle_win"."losing_initiative_id" = "losing_initiative"."id" JOIN "battle" "battle_lose" ON "battle_lose"."issue_id" = "issue_id_p" AND "battle_lose"."losing_initiative_id" = "winning_initiative"."id" AND "battle_lose"."winning_initiative_id" = "losing_initiative"."id" WHERE "losing_initiative"."issue_id" = "issue_id_p" AND "losing_initiative"."admitted" AND "winning_initiative"."schulze_rank" < "losing_initiative"."schulze_rank" AND "battle_win"."count" > "battle_lose"."count" AND ( "battle_win"."count" > "winning_initiative"."positive_votes" OR "battle_lose"."count" < "losing_initiative"."negative_votes" ) ) AS "subquery" WHERE "id" = "subquery"."initiative_id"' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate12 [
	self
		parse: 'UPDATE "initiative" SET "eligible" = TRUE WHERE "issue_id" = "issue_id_p" AND "initiative"."direct_majority" AND "initiative"."indirect_majority" AND "initiative"."better_than_status_quo" AND ( "policy_row"."no_multistage_majority" = FALSE OR "initiative"."multistage_majority" = FALSE ) AND ( "policy_row"."no_reverse_beat_path" = FALSE OR coalesce("initiative"."reverse_beat_path", FALSE) = FALSE )' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate13 [
	self
		parse: 'UPDATE "initiative" SET "winner" = TRUE FROM ( SELECT "id" AS "initiative_id" FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "eligible" ORDER BY "schulze_rank", "id" LIMIT 1 ) AS "subquery" WHERE "id" = "subquery"."initiative_id"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate14 [
	self
		parse: 'UPDATE "initiative" SET "rank" = "rank_v" WHERE "id" = "initiative_id_v"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate15 [
	self
		parse: 'UPDATE "issue" SET "status_quo_schulze_rank" = "rank_ary"[1], "state" = CASE WHEN EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "winner" ) THEN ''finished_with_winner''::"issue_state" ELSE ''finished_without_winner''::"issue_state" END, "closed" = "phase_finished", "phase_finished" = NULL WHERE "id" = "issue_id_p"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate16 [
	self
		parse: 'UPDATE "member" SET "active" = FALSE WHERE "active" = TRUE AND "last_activity" < (now() - "system_setting_row"."member_ttl")::DATE' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate17 [
	self
		parse: 'UPDATE "issue" SET "phase_finished" = now() WHERE "id" = "issue_row"."id"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate18 [
	self
		parse: 'UPDATE "issue" SET "state"          = "state_v", "closed"         = "phase_finished", "phase_finished" = NULL WHERE "id" = "issue_id_p"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate19 [
	self
		parse: 'UPDATE "direct_voter" SET "weight" = 1 WHERE "issue_id" = "issue_id_p"' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate2 [
	self
		parse: 'UPDATE inscription SET datecreation = NOW() WHERE cle = NEW.cle' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate20 [
	self
		parse: 'UPDATE "vote" SET "first_preference" = "subquery"."first_preference" FROM ( SELECT "vote"."initiative_id", "vote"."member_id", CASE WHEN "vote"."grade" > 0 THEN CASE WHEN "vote"."grade" = max("agg"."grade") THEN TRUE ELSE FALSE END ELSE NULL END AS "first_preference" FROM "vote" JOIN "initiative" ON "vote"."issue_id" = "initiative"."issue_id" JOIN "vote" AS "agg" ON "initiative"."id" = "agg"."initiative_id" AND "vote"."member_id" = "agg"."member_id" GROUP BY "vote"."initiative_id", "vote"."member_id", "vote"."grade" ) AS "subquery" WHERE "vote"."issue_id" = "issue_id_p" AND "vote"."initiative_id" = "subquery"."initiative_id" AND "vote"."member_id" = "subquery"."member_id"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate21 [
	self
		parse: 'UPDATE "issue" SET "voter_count" = ( SELECT coalesce(sum("weight"), 0) FROM "direct_voter" WHERE "issue_id" = "issue_id_p" ) WHERE "id" = "issue_id_p"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate22 [
	self
		parse: 'UPDATE "initiative" SET "first_preference_votes" = 0, "positive_votes" = "battle_win"."count", "negative_votes" = "battle_lose"."count" FROM "battle" AS "battle_win", "battle" AS "battle_lose" WHERE "battle_win"."issue_id" = "issue_id_p" AND "battle_win"."winning_initiative_id" = "initiative"."id" AND "battle_win"."losing_initiative_id" ISNULL AND "battle_lose"."issue_id" = "issue_id_p" AND "battle_lose"."losing_initiative_id" = "initiative"."id" AND "battle_lose"."winning_initiative_id" ISNULL' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate23 [
	self
		parse: 'UPDATE "initiative" SET "first_preference_votes" = "subquery"."sum" FROM ( SELECT "vote"."initiative_id", sum("direct_voter"."weight") FROM "vote" JOIN "direct_voter" ON "vote"."issue_id" = "direct_voter"."issue_id" AND "vote"."member_id" = "direct_voter"."member_id" WHERE "vote"."first_preference" GROUP BY "vote"."initiative_id" ) AS "subquery" WHERE "initiative"."issue_id" = "issue_id_p" AND "initiative"."admitted" AND "initiative"."id" = "subquery"."initiative_id"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate24 [
	self
		parse: 'UPDATE "direct_interest_snapshot" SET "weight" = 1 + "weight_of_added_delegations_for_interest_snapshot"( "issue_id_p", "member_id_v", ''{}'' ) WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "member_id_v"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate25 [
	self
		parse: 'UPDATE "direct_population_snapshot" SET "weight" = 1 + "weight_of_added_delegations_for_population_snapshot"( "issue_id_p", "member_id_v", ''{}'' ) WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "member_id_v"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate26 [
	self
		parse: 'UPDATE "issue" SET "snapshot" = coalesce("phase_finished", now()), "latest_snapshot_event" = ''periodic'', "population" = ( SELECT coalesce(sum("weight"), 0) FROM "direct_population_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' ) WHERE "id" = "issue_id_p"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate27 [
	self
		parse: 'UPDATE "initiative" SET "supporter_count" = ( SELECT coalesce(sum("di"."weight"), 0) FROM "direct_interest_snapshot" AS "di" JOIN "direct_supporter_snapshot" AS "ds" ON "di"."member_id" = "ds"."member_id" WHERE "di"."issue_id" = "issue_id_p" AND "di"."event" = ''periodic'' AND "ds"."initiative_id" = "initiative_id_v" AND "ds"."event" = ''periodic'' ), "informed_supporter_count" = ( SELECT coalesce(sum("di"."weight"), 0) FROM "direct_interest_snapshot" AS "di" JOIN "direct_supporter_snapshot" AS "ds" ON "di"."member_id" = "ds"."member_id" WHERE "di"."issue_id" = "issue_id_p" AND "di"."event" = ''periodic'' AND "ds"."initiative_id" = "initiative_id_v" AND "ds"."event" = ''periodic'' AND "ds"."informed" ), "satisfied_supporter_count" = ( SELECT coalesce(sum("di"."weight"), 0) FROM "direct_interest_snapshot" AS "di" JOIN "direct_supporter_snapshot" AS "ds" ON "di"."member_id" = "ds"."member_id" WHERE "di"."issue_id" = "issue_id_p" AND "di"."event" = ''periodic'' AND "ds"."initiative_id" = "initiative_id_v" AND "ds"."event" = ''periodic'' AND "ds"."satisfied" ), "satisfied_informed_supporter_count" = ( SELECT coalesce(sum("di"."weight"), 0) FROM "direct_interest_snapshot" AS "di" JOIN "direct_supporter_snapshot" AS "ds" ON "di"."member_id" = "ds"."member_id" WHERE "di"."issue_id" = "issue_id_p" AND "di"."event" = ''periodic'' AND "ds"."initiative_id" = "initiative_id_v" AND "ds"."event" = ''periodic'' AND "ds"."informed" AND "ds"."satisfied" ) WHERE "id" = "initiative_id_v"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate28 [
	self
		parse: 'UPDATE "suggestion" SET "minus2_unfulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = -2 AND "opinion"."fulfilled" = FALSE ), "minus2_fulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = -2 AND "opinion"."fulfilled" = TRUE ), "minus1_unfulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = -1 AND "opinion"."fulfilled" = FALSE ), "minus1_fulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = -1 AND "opinion"."fulfilled" = TRUE ), "plus1_unfulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = 1 AND "opinion"."fulfilled" = FALSE ), "plus1_fulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = 1 AND "opinion"."fulfilled" = TRUE ), "plus2_unfulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = 2 AND "opinion"."fulfilled" = FALSE ), "plus2_fulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = 2 AND "opinion"."fulfilled" = TRUE ) WHERE "suggestion"."id" = "suggestion_id_v"' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate29 [
	self
		parse: 'UPDATE "member" SET "last_login"                   = NULL, "last_delegation_check"        = NULL, "login"                        = NULL, "password"                     = NULL, "authority"                    = NULL, "authority_uid"                = NULL, "authority_login"              = NULL, "locked"                       = TRUE, "active"                       = FALSE, "notify_email"                 = NULL, "notify_email_unconfirmed"     = NULL, "notify_email_secret"          = NULL, "notify_email_secret_expiry"   = NULL, "notify_email_lock_expiry"     = NULL, "login_recovery_expiry"        = NULL, "password_reset_secret"        = NULL, "password_reset_secret_expiry" = NULL, "organizational_unit"          = NULL, "internal_posts"               = NULL, "realname"                     = NULL, "birthday"                     = NULL, "address"                      = NULL, "email"                        = NULL, "xmpp_address"                 = NULL, "website"                      = NULL, "phone"                        = NULL, "mobile_phone"                 = NULL, "profession"                   = NULL, "external_memberships"         = NULL, "external_posts"               = NULL, "statement"                    = NULL WHERE "id" = "member_id_p"' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate3 [
	self
		parse: 'UPDATE diplome SET fin = NULL WHERE cle = OLD.cle_diplome' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate30 [
	self
		parse: 'UPDATE documents SET filename = nomfichier, date_reception = datereception, cle_equipe = cleequipe, acronyme = acronyme_doc, gestionnaire = estgestionnaire WHERE cle = cledocument' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate31 [
	self
		parse: 'UPDATE documents SET gestionnaire = estgestionnaire WHERE cle = cledocument' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate32 [
	self
		parse: 'UPDATE fonctions SET fonction = fonction_actuelle WHERE uid = uid_utilisateur' rule: #updateCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarUpdateCrashTest >> testUpdate33 [
	self
		parse: 'UPDATE nom SET disponible = true WHERE nom = OLD.nom' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate4 [
	self
		parse: 'UPDATE personne SET datecreation = NOW() WHERE cle = NEW.cle' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate5 [
	self
		parse: 'UPDATE affectation SET fin = NEW.fin WHERE affectation.cle_support = NEW.cle AND affectation.fin IS NULL' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate6 [
	self
		parse: 'UPDATE "direct_voter" SET "weight" = "weight" + "weight_of_added_vote_delegations"( "issue_id_p", "member_id_v", ''{}'' ) WHERE "member_id" = "member_id_v" AND "issue_id" = "issue_id_p"' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate7 [
	self
		parse: 'UPDATE "unit" SET "member_count" = "view"."member_count" FROM "unit_member_count" AS "view" WHERE "view"."unit_id" = "unit"."id"' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate8 [
	self
		parse: 'UPDATE "area" SET "direct_member_count" = "view"."direct_member_count", "member_weight"       = "view"."member_weight" FROM "area_member_count" AS "view" WHERE "view"."area_id" = "area"."id"' rule: #updateCommand
]

{ #category : #tests }
PSQLGrammarUpdateCrashTest >> testUpdate9 [
	self
		parse: 'UPDATE "initiative" SET "direct_majority" = CASE WHEN "policy_row"."direct_majority_strict" THEN "positive_votes" * "policy_row"."direct_majority_den" > "policy_row"."direct_majority_num" * ("positive_votes"+"negative_votes") ELSE "positive_votes" * "policy_row"."direct_majority_den" >= "policy_row"."direct_majority_num" * ("positive_votes"+"negative_votes") END AND "positive_votes" >= "policy_row"."direct_majority_positive" AND "issue_row"."voter_count"-"negative_votes" >= "policy_row"."direct_majority_non_negative", "indirect_majority" = CASE WHEN "policy_row"."indirect_majority_strict" THEN "positive_votes" * "policy_row"."indirect_majority_den" > "policy_row"."indirect_majority_num" * ("positive_votes"+"negative_votes") ELSE "positive_votes" * "policy_row"."indirect_majority_den" >= "policy_row"."indirect_majority_num" * ("positive_votes"+"negative_votes") END AND "positive_votes" >= "policy_row"."indirect_majority_positive" AND "issue_row"."voter_count"-"negative_votes" >= "policy_row"."indirect_majority_non_negative", "schulze_rank"           = "rank_ary"["i"], "better_than_status_quo" = "rank_ary"["i"] < "rank_ary"[1], "worse_than_status_quo"  = "rank_ary"["i"] > "rank_ary"[1], "multistage_majority"    = "rank_ary"["i"] >= "rank_ary"[1], "reverse_beat_path"      = CASE WHEN "policy_row"."defeat_strength" = ''simple''::"defeat_strength" THEN NULL ELSE "matrix_p"[1]["i"]."primary" >= 0 END, "eligible"               = FALSE, "winner"                 = FALSE, "rank"                   = NULL WHERE "id" = "initiative_id_v"' rule: #updateCommand
]
