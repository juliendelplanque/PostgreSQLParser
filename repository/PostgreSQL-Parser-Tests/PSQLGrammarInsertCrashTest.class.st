Class {
	#name : #PSQLGrammarInsertCrashTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLGrammarInsertCrashTest >> parserClass [
	^ PSQLGrammar
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert1 [
	self
		parse: 'INSERT INTO listehdr(cle_personne,dateobtention) VALUES(NEW.cle_personne,NEW.fin)' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert10 [
	self
		parse: 'INSERT INTO "delegating_interest_snapshot" ( "issue_id", "event", "member_id", "scope", "delegate_member_ids" ) VALUES ( "issue_id_p", ''periodic'', "issue_delegation_row"."truster_id", "issue_delegation_row"."scope", "delegate_member_ids_v" )' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert11 [
	self
		parse: 'INSERT INTO "event" ( "event", "member_id", "issue_id", "state", "initiative_id", "draft_id" ) VALUES ( "event_v", NEW."author_id", "initiative_row"."issue_id", "issue_row"."state", "initiative_row"."id", NEW."id" )' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert12 [
	self
		parse: 'INSERT INTO "event" ( "event", "member_id", "issue_id", "state", "initiative_id", "draft_id" ) VALUES ( ''initiative_revoked'', NEW."revoked_by_member_id", NEW."issue_id", "issue_row"."state", NEW."id", "draft_id_v")' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert13 [
	self
		parse: 'INSERT INTO "event" ("event", "issue_id", "state") VALUES (''issue_state_changed'', NEW."id", NEW."state")' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert14 [
	self
		parse: 'INSERT INTO "event" ( "event", "member_id", "issue_id", "state", "initiative_id", "suggestion_id" ) VALUES ( ''suggestion_created'', NEW."author_id", "initiative_row"."issue_id", "issue_row"."state", "initiative_row"."id", NEW."id" )' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert15 [
	self
		parse: 'INSERT INTO journal(cle_campagne,fichier,acronyme_doc,uid,action,gestionnaire,cle_document) VALUES(NEW.cle_campagne,nomfichier(NEW.filename),NEW.acronyme,NEW.uid,''DEPOT'',NEW.gestionnaire,NEW.cle)' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert16 [
	self
		parse: 'INSERT INTO journal(cle_campagne,fichier,acronyme_doc,uid,action,gestionnaire,cle_document) VALUES(OLD.cle_campagne,nomfichier(OLD.filename),OLD.acronyme,OLD.uid,''ANNULATION'',OLD.gestionnaire,OLD.cle)' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert17 [
	self
		parse: 'INSERT INTO documents( cle_campagne, cle_personne, acronyme, acronyme_campagne, uid ) VALUES( campagne.cle, clepersonne, campagne.acronyme, (campagne.acronyme IS NOT NULL), uid_membre )' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert18 [
	self
		parse: 'INSERT INTO fonctions(uid,fonction) VALUES (uid_utilisateur,fonction_actuelle)' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert2 [
	self
		parse: 'INSERT INTO "interest" ("issue_id", "member_id")
            SELECT "issue_id", NEW."member_id"
            FROM "initiative" WHERE "id" = NEW."initiative_id"' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert3 [
	self
		parse: 'INSERT INTO "member_count" ("total_count")
        SELECT "total_count" FROM "member_count_view"' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert4 [
	self
		parse: 'INSERT INTO "temporary_transaction_data" ("key", "value")
          VALUES (''override_protection_triggers'', TRUE::TEXT)' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert5 [
	self
		parse: 'INSERT INTO "temporary_transaction_data" ("key", "value")
        VALUES (''override_protection_triggers'', TRUE::TEXT)' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert6 [
	self
		parse: 'INSERT INTO "battle" (
        "issue_id",
        "winning_initiative_id", "losing_initiative_id",
        "count"
      ) SELECT
        "issue_id",
        "winning_initiative_id", "losing_initiative_id",
        "count"
        FROM "battle_view" WHERE "issue_id" = "issue_id_p"' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert7 [
	self
		parse: 'INSERT INTO "direct_interest_snapshot"
        ("issue_id", "event", "member_id")
        SELECT
          "issue_id_p"  AS "issue_id",
          ''periodic''    AS "event",
          "member"."id" AS "member_id"
        FROM "issue"
        JOIN "area" ON "issue"."area_id" = "area"."id"
        JOIN "interest" ON "issue"."id" = "interest"."issue_id"
        JOIN "member" ON "interest"."member_id" = "member"."id"
        JOIN "privilege"
          ON "privilege"."unit_id" = "area"."unit_id"
          AND "privilege"."member_id" = "member"."id"
        WHERE "issue"."id" = "issue_id_p"
        AND "member"."active" AND "privilege"."voting_right"' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert8 [
	self
		parse: 'INSERT INTO "direct_supporter_snapshot" ( "issue_id", "initiative_id", "event", "member_id", "draft_id", "informed", "satisfied" ) SELECT "issue_id_p"            AS "issue_id", "initiative"."id"       AS "initiative_id", ''periodic''              AS "event", "supporter"."member_id" AS "member_id", "supporter"."draft_id"  AS "draft_id", "supporter"."draft_id" = "current_draft"."id" AS "informed", NOT EXISTS ( SELECT NULL FROM "critical_opinion" WHERE "initiative_id" = "initiative"."id" AND "member_id" = "supporter"."member_id" ) AS "satisfied" FROM "initiative" JOIN "supporter" ON "supporter"."initiative_id" = "initiative"."id" JOIN "current_draft" ON "initiative"."id" = "current_draft"."initiative_id" JOIN "direct_interest_snapshot" ON "supporter"."member_id" = "direct_interest_snapshot"."member_id" AND "initiative"."issue_id" = "direct_interest_snapshot"."issue_id" AND "event" = ''periodic'' WHERE "initiative"."issue_id" = "issue_id_p"' rule: #insertCommand
]

{ #category : #tests }
PSQLGrammarInsertCrashTest >> testInsert9 [
	self
		parse: 'INSERT INTO "direct_population_snapshot" ("issue_id", "event", "member_id") SELECT "issue_id_p"                 AS "issue_id", ''periodic''::"snapshot_event" AS "event", "member"."id"                AS "member_id" FROM "issue" JOIN "area" ON "issue"."area_id" = "area"."id" JOIN "membership" ON "area"."id" = "membership"."area_id" JOIN "member" ON "membership"."member_id" = "member"."id" JOIN "privilege" ON "privilege"."unit_id" = "area"."unit_id" AND "privilege"."member_id" = "member"."id" WHERE "issue"."id" = "issue_id_p" AND "member"."active" AND "privilege"."voting_right" UNION SELECT "issue_id_p"                 AS "issue_id", ''periodic''::"snapshot_event" AS "event", "member"."id"                AS "member_id" FROM "issue" JOIN "area" ON "issue"."area_id" = "area"."id" JOIN "interest" ON "issue"."id" = "interest"."issue_id" JOIN "member" ON "interest"."member_id" = "member"."id" JOIN "privilege" ON "privilege"."unit_id" = "area"."unit_id" AND "privilege"."member_id" = "member"."id" WHERE "issue"."id" = "issue_id_p" AND "member"."active" AND "privilege"."voting_right"' rule: #insertCommand
]
