Class {
	#name : #PSQLGrammarDeleteCrashTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLGrammarDeleteCrashTest >> parserClass [
	^ PSQLGrammar
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete1 [
	self
		parse: 'DELETE FROM listehdr WHERE listehdr.cle_personne = OLD.cle_personne' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete10 [
	self
		parse: 'DELETE FROM "direct_voter" USING "issue" WHERE "direct_voter"."issue_id" = "issue"."id" AND "issue"."closed" ISNULL' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete11 [
	self
		parse: 'DELETE FROM "non_voter"' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete12 [
	self
		parse: 'DELETE FROM "initiative" WHERE "id" = OLD."initiative_id"' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete13 [
	self
		parse: 'DELETE FROM documents WHERE cle = cledocument' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete14 [
	self
		parse: 'DELETE FROM documents WHERE cle IN ( SELECT d.cle FROM documents as d, campagnes as c WHERE est_un_slot_vide(d.cle) AND	c.cle = d.cle_campagne AND	c.fin < NOW()::DATE )' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete15 [
	self
		parse: 'DELETE FROM fonctions WHERE uid NOT IN (SELECT uid FROM vue_personnes)' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete16 [
	self
		parse: 'DELETE FROM documents WHERE cle IN ( SELECT d.cle FROM documents as d, campagnes as c WHERE est_un_slot_vide(d.cle) AND	c.cle = d.cle_campagne AND	c.fin < NOW()::DATE )' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete2 [
	self
		parse: 'DELETE FROM "member_count"' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete3 [
	self
		parse: 'DELETE FROM "direct_voter"     WHERE "issue_id" = "issue_id_p"' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete4 [
	self
		parse: 'DELETE FROM "supporter" USING "initiative" WHERE "initiative"."issue_id" = "issue_id_p" AND "supporter"."initiative_id" = "initiative_id"' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete5 [
	self
		parse: 'DELETE FROM "direct_voter" USING ( SELECT "direct_voter"."member_id" FROM "direct_voter" JOIN "member" ON "direct_voter"."member_id" = "member"."id" LEFT JOIN "privilege" ON "privilege"."unit_id" = "unit_id_v" AND "privilege"."member_id" = "direct_voter"."member_id" WHERE "direct_voter"."issue_id" = "issue_id_p" AND ( "member"."active" = FALSE OR "privilege"."voting_right" ISNULL OR "privilege"."voting_right" = FALSE ) ) AS "subquery" WHERE "direct_voter"."issue_id" = "issue_id_p" AND "direct_voter"."member_id" = "subquery"."member_id"' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete6 [
	self
		parse: 'DELETE FROM "direct_interest_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic''' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete7 [
	self
		parse: 'DELETE FROM "direct_supporter_snapshot" USING "initiative" WHERE "initiative"."issue_id" = "issue_id_p" AND "direct_supporter_snapshot"."initiative_id" = "initiative"."id" AND "direct_supporter_snapshot"."event" = ''periodic''' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete8 [
	self
		parse: 'DELETE FROM "direct_population_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic''' rule: #deleteCommand
]

{ #category : #tests }
PSQLGrammarDeleteCrashTest >> testDelete9 [
	self
		parse: 'DELETE FROM "member" WHERE "activated" ISNULL' rule: #deleteCommand
]
