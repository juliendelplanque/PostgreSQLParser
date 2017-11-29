Class {
	#name : #PSQLFromClauseGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLFromClauseGrammarTest >> parserClass [
	^ PSQLFromClauseGrammar
]

{ #category : #tests }
PSQLFromClauseGrammarTest >> testColumnDefinition [
	self
		parse: 'clepersonne INTEGER' rule: #columnDefinition;
		parse: 'datearrivee DATE' rule: #columnDefinition;
		parse: 'sexe VARCHAR' rule: #columnDefinition
]

{ #category : #tests-shared }
PSQLFromClauseGrammarTest >> testFromClause [
	"A smoke test with multiple FROM clauses extracted from existing open-source schemas."
	self
		parse: 'FROM "initiative"' rule: #fromClause;
		parse: 'FROM "area_delegation" LEFT JOIN "membership"' rule: #fromClause;
		parse: 'FROM affectation,support,personne' rule: #fromClause;
		parse: 'FROM (((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle))), grade, typesupport, employeur' rule: #fromClause
]

{ #category : #tests-shared }
PSQLFromClauseGrammarTest >> testFromItems [
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
PSQLFromClauseGrammarTest >> testFromItems1 [
	self
		parse: 'ONLY table * AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'table * AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'ONLY table AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'ONLY table *' rule: #fromItems1
]

{ #category : #tests-shared }
PSQLFromClauseGrammarTest >> testFromItems2 [
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
PSQLFromClauseGrammarTest >> testFromItems3 [
	self
		parse: 'queryName' rule: #fromItems3;
		parse: 'queryName as aliasName' rule: #fromItems3;
		parse: 'queryName AS aliasName (c1,C2, c3   )' rule: #fromItems3
]

{ #category : #tests-shared }
PSQLFromClauseGrammarTest >> testFromItems4 [
	self
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE) AS mbrs( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #fromItems4;
		parse: 'membres(1, (now())::date) membres(clepersonne integer, datearrivee date, sexe character varying, nompersonne character varying, prenompersonne character varying, datenaissance date, paysorigine character varying, nomcategorie character varying, corps character varying, typedusupport character varying, numsection smallint, numcmu smallint, debutsupport date, finsupport date, nomequipes text, nomemployeur character varying, nomenseignement character varying, typefinancement character varying, financeurs text, reffinancement character varying, responsablethese text)' rule: #fromItems4
]

{ #category : #tests-shared }
PSQLFromClauseGrammarTest >> testFromItems5 [
	self
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE) AS ( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #fromItems5
]

{ #category : #tests-shared }
PSQLFromClauseGrammarTest >> testFromItems6 [
	self
		parse: 'JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"' rule: #fromItems6;
		parse: 'LEFT JOIN "membership"' rule: #fromItems6
]

{ #category : #tests-shared }
PSQLFromClauseGrammarTest >> testFromItems7 [
	self
		parse: 'function(1, "a") aliasName' rule: #fromItems7;
		parse: 'function(1, "a") AS aliasName (c1, C2, "C3")' rule: #fromItems7;
		parse: 'function(1, "a") aliasName (c1, C2, "C3")' rule: #fromItems7
]

{ #category : #tests-keywords }
PSQLFromClauseGrammarTest >> testJoinType [
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
