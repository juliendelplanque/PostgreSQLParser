Class {
	#name : #PSQLGrammarCreateViewCrashTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLGrammarCreateViewCrashTest >> parserClass [
	^ PSQLGrammar
]

{ #category : #tests }
PSQLGrammarCreateViewCrashTest >> testCreateView1 [
	self
		parse: 'CREATE VIEW "cleNomPrenom_des_membres" AS SELECT personne.cle, (((personne.nom)::text || '' ''::text) || (personne.prenom)::text) AS nomprenom FROM personne ORDER BY personne.nom, personne.prenom' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView10 [
	self
		parse: 'CREATE VIEW vue_employeurs AS SELECT support.cle AS clesupport, employeur.nom AS nomemployeur FROM (support JOIN employeur ON ((employeur.cle = support.cle_employeur)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView11 [
	self
		parse: 'CREATE VIEW vue_enseignements AS SELECT personne.cle AS clepersonne, civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, enseignement.entite AS nomenseignement, employeur.nom AS nomemployeur, support.debut AS debutsupport, support.fin AS finsupport, grade.grade AS statut FROM (((((personne JOIN civilite ON ((personne.civilite = civilite.cle))) JOIN support ON ((support.cle_personne = personne.cle))) LEFT JOIN enseignement ON ((support.cle_enseignement = enseignement.cle))) JOIN employeur ON ((support.cle_employeur = employeur.cle))) JOIN grade ON ((support.cle_grade = grade.cle))) WHERE (((grade.cle_catgrade)::text = ''MCF''::text) OR ((grade.cle_catgrade)::text = ''PR''::text))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView12 [
	self
		parse: 'CREATE VIEW vue_entrees_par_annee AS SELECT date_part(''year''::text, support.debut) AS annee, count(*) AS total, (sum(est_un_homme(personne.civilite)))::integer AS homme, (sum(est_une_femme(personne.civilite)))::integer AS femme FROM personne, support WHERE ((personne.cle = support.cle_personne) AND (date_part(''year''::text, support.debut) IN (SELECT DISTINCT date_part(''year''::text, support.debut) AS annee FROM support ORDER BY date_part(''year''::text, support.debut)))) GROUP BY date_part(''year''::text, support.debut) ORDER BY date_part(''year''::text, support.debut)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView13 [
	self
		parse: 'CREATE VIEW vue_it_permanents AS SELECT personne.cle AS clepersonne, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, grade.grade, employeur.nom AS nomemployeur, support.debut AS debutsupport, support.fin AS finsupport FROM personne, support, grade, categorie, employeur WHERE (((((((personne.cle = support.cle_personne) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND ((categorie.categorie)::text = ''PERMANENT''::text)) AND (support.cle_employeur = employeur.cle)) AND (((((support.cle_employeur = 1) OR (support.cle_employeur = 15)) OR (support.cle_employeur = 2)) OR (support.cle_employeur = 3)) OR (support.cle_employeur = 107))) AND ((grade.cle_catgrade)::text = ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text])))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView14 [
	self
		parse: 'CREATE VIEW vue_responsable_de_theses AS SELECT personne.cle, personne.nom, personne.prenom FROM personne WHERE (personne.cle IN (SELECT these.cle_responsable FROM these))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView15 [
	self
		parse: 'CREATE VIEW vue_support_le_plus_recent AS SELECT recents.clepersonne, support.cle AS clesupport, recents.debutsupport FROM support, (SELECT support.cle_personne AS clepersonne, max(support.debut) AS debutsupport FROM support GROUP BY support.cle_personne) recents WHERE ((support.cle_personne = recents.clepersonne) AND (support.debut = recents.debutsupport)) ORDER BY recents.clepersonne' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView16 [
	self
		parse: 'CREATE VIEW vue_liste_doctorants AS SELECT personne.cle AS clepersonne, personne.nom, personne.prenom, these.abandon, these.date_inscription AS debutthese, date(these.fin) AS finthese, domaine_diplome.domaine AS discipline, equipe.nom AS nomequipe, vue_responsable_de_theses.cle AS cleresponsable, vue_coencadrant_de_theses.cle AS clecoresponsable, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) AS responsable, (((vue_coencadrant_de_theses.nom)::text || '' ''::text) || (vue_coencadrant_de_theses.prenom)::text) AS coencadrant, vue_financements_des_supports.financeurs, sujet.titre FROM (((((((((these JOIN personne ON ((personne.cle = these.cle_personne))) JOIN sujet ON ((these.cle_sujet = sujet.cle))) JOIN domaine_diplome ON ((these.cle_domaine = domaine_diplome.cle))) LEFT JOIN vue_responsable_de_theses ON ((vue_responsable_de_theses.cle = these.cle_responsable))) LEFT JOIN vue_coencadrant_de_theses ON ((vue_coencadrant_de_theses.cle = these.cle_coencadrant))) LEFT JOIN equipe ON ((equipe.cle = these.cle_equipe))) JOIN vue_support_le_plus_recent ON ((vue_support_le_plus_recent.clepersonne = personne.cle))) JOIN support ON ((support.cle = vue_support_le_plus_recent.clesupport))) JOIN vue_financements_des_supports ON ((vue_financements_des_supports.clesupport = support.cle)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView17 [
	self
		parse: 'CREATE VIEW vue_liste_personnel AS SELECT membres.clepersonne, membres.datearrivee, membres.sexe, membres.nompersonne, membres.prenompersonne, membres.datenaissance, membres.paysorigine, membres.nomcategorie, membres.corps, membres.typedusupport, membres.numsection, membres.numcmu, membres.debutsupport, membres.finsupport, membres.nomequipes, membres.nomemployeur, membres.nomenseignement, membres.typefinancement, membres.financeurs, membres.reffinancement, membres.responsablethese FROM membres(1, (now())::date) membres(clepersonne integer, datearrivee date, sexe character varying, nompersonne character varying, prenompersonne character varying, datenaissance date, paysorigine character varying, nomcategorie character varying, corps character varying, typedusupport character varying, numsection smallint, numcmu smallint, debutsupport date, finsupport date, nomequipes text, nomemployeur character varying, nomenseignement character varying, typefinancement character varying, financeurs text, reffinancement character varying, responsablethese text)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView18 [
	self
		parse: 'CREATE VIEW vue_support_le_plus_ancien AS SELECT premierssupports.cle_personne, premierssupports.min, support.cle AS clesupport FROM (SELECT support.cle_personne, min(support.debut) AS min FROM support GROUP BY support.cle_personne) premierssupports, support WHERE ((support.cle_personne = premierssupports.cle_personne) AND (support.debut = premierssupports.min))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView19 [
	self
		parse: 'CREATE VIEW vue_liste_personnel_affectations AS SELECT personne.cle AS clepersonne, vue_support_le_plus_ancien.min AS datearrivee, civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, personne.datenaissance, pays.nom AS paysorigine, categorie.categorie AS nomcategorie, grade.grade AS corps, typesupport.nature AS typedusupport, section.numero AS numsection, cmu.numero AS numcmu, support.debut AS debutsupport, support.fin AS finsupport, equipe.nom AS nomequipe, affectation.debut AS debutaffectation, affectation.fin AS finaffectation, affectation.repartition, employeur.nom AS nomemployeur, enseignement.entite AS nomenseignement, vue_financements_des_supports.typefinancement, vue_financements_des_supports.financeurs, vue_financements_des_supports.reffinancement, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) AS responsablethese FROM civilite, vue_support_le_plus_ancien, ((((support LEFT JOIN enseignement ON ((support.cle_enseignement = enseignement.cle))) LEFT JOIN section ON ((support.cle_section = section.cle))) LEFT JOIN cmu ON ((support.cle_cmu = cmu.cle))) LEFT JOIN vue_financements_des_supports ON ((support.cle = vue_financements_des_supports.clesupport))), pays, categorie, grade, typesupport, employeur, affectation, equipe, ((these LEFT JOIN vue_responsable_de_theses ON ((these.cle_responsable = vue_responsable_de_theses.cle))) RIGHT JOIN personne ON ((these.cle_personne = personne.cle))) WHERE ((((((((((personne.cle = vue_support_le_plus_ancien.cle_personne) AND (support.cle_personne = personne.cle)) AND (personne.civilite = civilite.cle)) AND (personne.paysorigine = pays.cle)) AND (support.cle_categorie = categorie.cle)) AND (support.cle_grade = grade.cle)) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND (affectation.cle_support = support.cle)) AND (equipe.cle = affectation.cle_equipe)) GROUP BY personne.nom, personne.prenom, personne.cle, vue_support_le_plus_ancien.min, civilite.civilite, personne.datenaissance, pays.nom, categorie.categorie, grade.grade, typesupport.nature, section.numero, cmu.numero, support.debut, support.fin, equipe.nom, affectation.debut, affectation.fin, affectation.repartition, employeur.nom, enseignement.entite, vue_financements_des_supports.typefinancement, vue_financements_des_supports.financeurs, vue_financements_des_supports.reffinancement, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) ORDER BY personne.nom, personne.prenom' rule: #createViewCommand
]

{ #category : #tests }
PSQLGrammarCreateViewCrashTest >> testCreateView2 [
	self
		parse: 'CREATE VIEW repartition_personnes_dans_equipes AS SELECT personne.nom AS nompersonne, personne.prenom, affectation.cle_equipe, support.cle_personne, equipe.nom AS nomequipe FROM personne, support, affectation, equipe WHERE ((((equipe.cle = affectation.cle_equipe) AND ((affectation.debut <= now()) AND ((affectation.fin >= now()) OR (affectation.fin IS NULL)))) AND (affectation.cle_support = support.cle)) AND (support.cle_personne = personne.cle))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView20 [
	self
		parse: 'CREATE VIEW vue_membres_associes AS SELECT personne.cle AS clepersonne, civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, grade.grade AS corps, equipe.nom AS nomequipe, typesupport.nature AS typesupport, support.debut AS debutsupport, support.fin AS finsupport, employeur.nom AS nomemployeur FROM civilite, personne, grade, support, affectation, equipe, typesupport, employeur WHERE ((((((((support.cle_personne = personne.cle) AND (personne.civilite = civilite.cle)) AND (support.cle_grade = grade.cle)) AND (affectation.cle_support = support.cle)) AND (affectation.cle_equipe = equipe.cle)) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND (support.cle_categorie = 4))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView21 [
	self
		parse: 'CREATE VIEW vue_personnel_recherche_permanents AS SELECT personne.cle AS clepersonne, support.cle AS clesupport, civilite.civilite AS labelcivilite, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, pays.nom AS nompays, grade.grade, employeur.nom AS nomemployeur, support.debut AS debutsupport, support.fin AS finsupport FROM personne, pays, civilite, grade, categorie, employeur, support WHERE ((((((((personne.cle = support.cle_personne) AND (personne.civilite = civilite.cle)) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND (support.cle_employeur = employeur.cle)) AND (personne.paysorigine = pays.cle)) AND (support.cle_grade = ANY (ARRAY[25, 51, 52, 53, 9, 10, 11, 12, 20, 21, 22, 24, 26]))) AND ((categorie.categorie)::text = ''PERMANENT''::text))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView22 [
	self
		parse: 'CREATE VIEW vue_personnel_recherche_permanents_copy AS SELECT personne.cle AS clepersonne, civilite.civilite AS labelcivilite, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, pays.nom AS nompays, grade.grade, employeur.nom AS nomemployeur, support.debut AS debutsupport, support.fin AS finsupport, agt_genere_liste(((((equipe.nom)::text || '' (''::text) || affectation.repartition) || ''%)''::text)) AS nomequipes FROM personne, pays, civilite, grade, categorie, employeur, equipe, (affectation LEFT JOIN support ON ((affectation.cle_support = support.cle))) WHERE ((affectation.cle_equipe = equipe.cle) AND ((((((((personne.paysorigine = pays.cle) AND (personne.cle = support.cle_personne)) AND (personne.civilite = civilite.cle)) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND (support.cle_employeur = employeur.cle)) AND ((support.debut <= now()) AND ((support.fin >= now()) OR (support.fin IS NULL)))) AND (((((support.cle_grade = 25) OR (support.cle_grade = 51)) OR (support.cle_grade = 52)) OR (support.cle_grade = 53)) OR (((((((((((support.cle_grade = 9) OR (support.cle_grade = 10)) OR (support.cle_grade = 11)) OR (support.cle_grade = 12)) OR (support.cle_grade = 20)) OR (support.cle_grade = 21)) OR (support.cle_grade = 22)) OR (support.cle_grade = 24)) OR (support.cle_grade = 26)) AND ((affectation.debut <= now()) AND ((affectation.fin >= now()) OR (affectation.fin IS NULL)))) AND ((categorie.categorie)::text = ''PERMANENT''::text))))) GROUP BY personne.cle, civilite.civilite, personne.nom, personne.prenom, personne.datenaissance, pays.nom, grade.grade, employeur.nom, support.debut, support.fin' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView23 [
	self
		parse: 'CREATE VIEW vue_personnes_sans_equipe AS SELECT personne.cle AS clepersonne, personne.nom, personne.prenom FROM personne, support WHERE ((((personne.cle = support.cle_personne) AND (support.debut <= now())) AND ((support.fin IS NULL) OR (support.fin >= now()))) AND (((NOT (support.cle IN (SELECT affectation.cle_support FROM affectation WHERE ((affectation.fin >= now()) OR (affectation.fin IS NULL))))) OR (support.cle IN (SELECT affectation.cle_support FROM affectation WHERE (affectation.cle_equipe = 0)))) OR (NOT (support.cle IN (SELECT affectation.cle_support FROM affectation)))))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView24 [
	self
		parse: 'CREATE VIEW vue_soutenances AS SELECT these.fin, "cleNomPrenom_des_membres".nomprenom, p.relname, sujet.titre, equipe.nom AS equipe, lieusoutenance.nom FROM these, soutenance, sujet, "cleNomPrenom_des_membres", equipe, lieusoutenance, pg_class p WHERE (((((((these.tableoid = p.oid) AND (soutenance.cle_diplome = these.cle)) AND (these.cle_sujet = sujet.cle)) AND (these.cle_equipe = equipe.cle)) AND (these.cle_personne = "cleNomPrenom_des_membres".cle)) AND (soutenance.cle_lieusoutenance = lieusoutenance.cle)) AND ((these.fin IS NOT NULL) AND (these.abandon = false))) UNION SELECT hdr.fin, "cleNomPrenom_des_membres".nomprenom, p.relname, sujet.titre, equipe.nom AS equipe, lieusoutenance.nom FROM hdr, soutenance, sujet, "cleNomPrenom_des_membres", equipe, lieusoutenance, pg_class p WHERE (((((((hdr.tableoid = p.oid) AND (soutenance.cle_diplome = hdr.cle)) AND (hdr.cle_sujet = sujet.cle)) AND (hdr.cle_equipe = equipe.cle)) AND (hdr.cle_personne = "cleNomPrenom_des_membres".cle)) AND (soutenance.cle_lieusoutenance = lieusoutenance.cle)) AND (hdr.fin IS NOT NULL))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView25 [
	self
		parse: 'CREATE VIEW vue_supports_debutants_dans_trente_jours AS SELECT personne.cle, personne.nom, personne.prenom, date_trunc(''day''::text, ((support.debut)::timestamp with time zone - now())) AS delai, support.cle AS clesupport, support.debut FROM personne, support WHERE (((personne.cle = support.cle_personne) AND (((support.debut)::timestamp with time zone - now()) > ''00:00:00''::interval)) AND (((support.debut)::timestamp with time zone - now()) < ''30 days''::interval)) GROUP BY personne.cle, personne.nom, personne.prenom, support.cle, support.debut' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView26 [
	self
		parse: 'CREATE VIEW vue_supports_debutes_depuis_trente_jours AS SELECT personne.cle, personne.nom, personne.prenom, date_trunc(''day''::text, (now() - (support.debut)::timestamp with time zone)) AS delai, support.cle AS clesupport, support.debut FROM personne, support WHERE (((personne.cle = support.cle_personne) AND ((now() - (support.debut)::timestamp with time zone) > ''00:00:00''::interval)) AND ((now() - (support.debut)::timestamp with time zone) < ''30 days''::interval)) GROUP BY personne.cle, personne.nom, personne.prenom, support.cle, support.debut' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView27 [
	self
		parse: 'CREATE VIEW vue_supports_expirants_dans_trente_jours AS SELECT personne.cle, personne.nom, personne.prenom, date_trunc(''day''::text, ((support.fin)::timestamp with time zone - now())) AS delai, support.cle AS clesupport FROM personne, vue_support_le_plus_recent, support WHERE ((((support.cle = vue_support_le_plus_recent.clesupport) AND (support.fin IS NOT NULL)) AND (personne.cle = vue_support_le_plus_recent.clepersonne)) AND ((((support.fin)::timestamp with time zone - now()) > ''00:00:00''::interval) AND (((support.fin)::timestamp with time zone - now()) < ''30 days''::interval))) GROUP BY personne.cle, personne.nom, personne.prenom, support.fin, support.cle' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView28 [
	self
		parse: 'CREATE VIEW vue_supports_expires_depuis_trente_jours AS SELECT personne.cle, personne.nom, personne.prenom, support.fin, support.cle AS clesupport FROM personne, vue_support_le_plus_recent, support WHERE ((((support.cle = vue_support_le_plus_recent.clesupport) AND (support.fin IS NOT NULL)) AND (personne.cle = vue_support_le_plus_recent.clepersonne)) AND ((((support.fin)::timestamp with time zone - now()) < ''00:00:00''::interval) AND (((support.fin)::timestamp with time zone - now()) > ''-30 days''::interval))) GROUP BY personne.cle, personne.nom, personne.prenom, support.fin, support.cle' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView29 [
	self
		parse: 'CREATE VIEW vue_theses_par_equipe AS SELECT equipe.cle AS cleequipe, equipe.nom AS nomequipe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, domaine_diplome.domaine AS discipline, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) AS directeur FROM (((((these JOIN sujet ON ((sujet.cle = these.cle_sujet))) JOIN domaine_diplome ON ((domaine_diplome.cle = these.cle_domaine))) JOIN equipe ON ((equipe.cle = these.cle_equipe))) JOIN personne ON ((personne.cle = these.cle_personne))) LEFT JOIN vue_responsable_de_theses ON ((vue_responsable_de_theses.cle = these.cle_responsable))) WHERE ((these.fin IS NOT NULL) AND (these.abandon = false)) ORDER BY equipe.nom, personne.nom, personne.prenom, sujet.titre' rule: #createViewCommand
]

{ #category : #tests }
PSQLGrammarCreateViewCrashTest >> testCreateView3 [
	self
		parse: 'CREATE VIEW vue_annuaire_localisations_par_membre AS SELECT localisation.cle_personne AS clepersonne, ((((((((((((''<a href="''::text || (genere_url_carto(localisation.cle_batiment, localisation.bureau))::text) || ''" target="_blank">''::text) || (site.nom)::text) || ''<br>''::text) || (batiment.nom)::text) || ''<br>''::text) || (affiche_etage(localisation.etage))::text) || ''Bureau ''::text) || (localisation.bureau)::text) || ''</a><br>''::text) || (localisation.telephone)::text) || ''<br>''::text) AS emplacement FROM localisation, site, batiment WHERE (((localisation.visible = true) AND (localisation.cle_batiment = batiment.cle)) AND (batiment.cle_site = site.cle))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView30 [
	self
		parse: 'CREATE VIEW vue_theses_soutenues_par_annee AS SELECT these.date_inscription, (these.fin)::date AS datesoutenance, personne.cle AS clepersonne, equipe.cle AS cleequipe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre, domaine_diplome.domaine AS discipline, equipe.nom AS nomequipe, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) AS directeur FROM (((((these RIGHT JOIN personne ON ((these.cle_personne = personne.cle))) RIGHT JOIN domaine_diplome ON ((domaine_diplome.cle = these.cle_domaine))) LEFT JOIN equipe ON ((these.cle_equipe = equipe.cle))) LEFT JOIN sujet ON ((these.cle_sujet = sujet.cle))) LEFT JOIN vue_responsable_de_theses ON ((these.cle_responsable = vue_responsable_de_theses.cle))) WHERE ((these.abandon = false) AND (these.fin IS NOT NULL)) ORDER BY date_part(''year''::text, these.fin), personne.nom, personne.prenom' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView31 [
	self
		parse: 'CREATE VIEW vue_tous_les_supports AS SELECT personne.nom, personne.prenom, grade.grade, typesupport.nature, support.debut, support.fin, typefinancement.type, employeur.nom AS employeur, labo.nom AS laboratoire, categorie.categorie FROM personne, support, typesupport, grade, typefinancement, employeur, categorie, labo WHERE (((((((personne.cle = support.cle_personne) AND (personne.cle_labo = labo.cle)) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_grade = grade.cle)) AND (support.cle_typefinancement = typefinancement.cle)) AND (support.cle_employeur = employeur.cle)) AND (support.cle_categorie = categorie.cle)) ORDER BY personne.nom, personne.prenom' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView32 [
	self
		parse: 'CREATE VIEW vue_types_affectations AS SELECT typeaffectation.cle, typeaffectation.nom FROM typeaffectation ORDER BY typeaffectation.defaut DESC' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView33 [
	self
		parse: 'CREATE VIEW web_actualites AS SELECT DISTINCT actualite.titrecourt, actualite.titrecourt_en, actualite.titre, actualite.titre_en, actualite.description, actualite.description_en, actualite.marquant, actualite.debut, date_part(''year''::text, actualite.debut) AS annee, actualite.fin, actualite.debutpublication, actualite.cle_categorie AS type, actualite.cle AS id, actualite.intervenant, actualite.lieu, actualite.heure, actualite.heurefin, categorie_actualite.intitule, categorie_actualite.code, actualite.url, CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END AS datetri FROM (actualite LEFT JOIN categorie_actualite ON ((actualite.cle_categorie = categorie_actualite.cle))) ORDER BY actualite.debut DESC, actualite.cle_categorie' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView34 [
	self
		parse: 'CREATE VIEW web_actualites_futures AS SELECT DISTINCT actualite.titrecourt, actualite.titrecourt_en, actualite.titre, actualite.titre_en, actualite.description, actualite.description_en, actualite.marquant, actualite.debut, date_part(''year''::text, actualite.debut) AS annee, actualite.fin, actualite.debutpublication, actualite.cle_categorie, actualite.cle AS id, actualite.intervenant, actualite.lieu, actualite.heure, actualite.heurefin, categorie_actualite.intitule, categorie_actualite.code AS type FROM (actualite LEFT JOIN categorie_actualite ON ((actualite.cle_categorie = categorie_actualite.cle))) WHERE (actualite.debut >= (now() - ''1 day''::interval)) ORDER BY actualite.debut DESC, actualite.cle_categorie' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView35 [
	self
		parse: 'CREATE VIEW web_catgrade AS SELECT DISTINCT grade.poids, catgrade.sigle, catgrade.intitule FROM (catgrade LEFT JOIN grade ON (((grade.cle_catgrade)::text = (catgrade.sigle)::text))) ORDER BY grade.poids DESC' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView36 [
	self
		parse: 'CREATE VIEW web_equipes_emergentes AS SELECT equipe.nom, equipe.siteweb, equipe.nomlong, equipe.nomlong_en, equipe.description, equipe.description_en, personne.nom AS chefnom, personne.prenom AS chefprenom, equipe.cle AS eid FROM ((equipe LEFT JOIN chefequipe ON ((chefequipe.cle_equipe = equipe.cle))) LEFT JOIN personne ON ((personne.cle = chefequipe.cle_personne))) WHERE ((equipe.cle_type_equipe = 2) AND ((equipe.fin <= now()) OR (equipe.fin IS NULL)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView37 [
	self
		parse: 'CREATE VIEW web_equipes_par_plateforme AS SELECT DISTINCT plateforme.cle, plateforme.nom, plateforme.description, plateforme.description_en, plateforme.siteweb, personne.nom AS resp_nom, personne.prenom AS resp_prenom, equipeexterne.nom AS equipe, equipeexterne.cle AS eid, equipeexterne.description AS desc_eq, equipeexterne.description_en AS desc_eq_en FROM (((((plateforme LEFT JOIN personne ON ((plateforme.cle_responsable = personne.cle))) LEFT JOIN r_equpla ON ((r_equpla.cle_plateforme = plateforme.cle))) LEFT JOIN equipe ON ((equipe.cle = r_equpla.cle_equipe))) LEFT JOIN r_equextequ ON ((r_equextequ.cle_equipe_interne = equipe.cle))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE ((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL)) ORDER BY plateforme.nom, equipeexterne.nom' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView38 [
	self
		parse: 'CREATE VIEW web_gt_cristal AS SELECT theme.cle, theme.nom, theme.description, theme.nom_en, theme.description_en, theme.cle_responsable, theme.debut, theme.fin, personne.nom AS nom_resp, personne.prenom AS prenom_resp, theme.nomcourt FROM (theme JOIN personne ON ((theme.cle_responsable = personne.cle))) WHERE (theme.debut > ''2014-12-31''::date)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView39 [
	self
		parse: 'CREATE VIEW web_hdrs_par_equipeexterne AS SELECT personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, date(hdr.fin) AS soutenance, date_part(''year''::text, hdr.fin) AS finthese, equipeexterne.cle AS eid, equipeexterne.nom AS equipe, hdr.cle AS id, sujet.resume, sujet.titre_en AS sujet_en, sujet.resume_en FROM (((((hdr LEFT JOIN sujet ON ((sujet.cle = hdr.cle_sujet))) LEFT JOIN personne ON ((personne.cle = hdr.cle_personne))) LEFT JOIN equipe ON ((equipe.cle = hdr.cle_equipe))) LEFT JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((equipe.fin IS NULL) OR (equipe.fin > ''2015-01-01''::date)) AND ((equipeexterne.fin IS NULL) OR (equipeexterne.fin > ''2015-01-01''::date))) ORDER BY hdr.fin DESC' rule: #createViewCommand
]

{ #category : #tests }
PSQLGrammarCreateViewCrashTest >> testCreateView4 [
	self
		parse: 'CREATE VIEW vue_clenomprenom_des_membres AS SELECT personne.cle, (((personne.nom)::text || '' ''::text) || (personne.prenom)::text) AS nomprenom FROM personne ORDER BY personne.nom, personne.prenom' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView40 [
	self
		parse: 'CREATE VIEW web_localisations_par_membre AS SELECT localisation.cle_personne, localisation.bureau, localisation.etage, localisation.telephone, batiment.nom AS batiment, site.nom AS site, batiment.latitude, batiment.longitude, batiment.cle AS batid FROM ((localisation LEFT JOIN batiment ON ((localisation.cle_batiment = batiment.cle))) LEFT JOIN site ON ((batiment.cle_site = site.cle)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView41 [
	self
		parse: 'CREATE VIEW web_membres AS SELECT DISTINCT personne.nom, personne.prenom, date_part(''year''::text, personne.datenaissance) AS naissance, personne.uid, personne.visible, support.fin AS finsupport, support.cle_typesupport AS support, typesupport.nature, equipeexterne.nom AS equipe, equipeexterne.cle AS eid, grade.grade AS grade_libelle, grade.cle AS grade, grade.poids, catgrade.intitule AS intitule_statut, catgrade.sigle AS statut, categorie.categorie, personne.cle, (chefequipe.cle_personne = personne.cle) AS estresp FROM (((((((((personne LEFT JOIN support ON ((support.cle_personne = personne.cle))) LEFT JOIN typesupport ON ((support.cle_typesupport = typesupport.cle))) LEFT JOIN affectation ON ((affectation.cle_support = support.cle))) LEFT JOIN r_equextequ ON ((affectation.cle_equipe = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((r_equextequ.cle_equipe_externe = equipeexterne.cle))) LEFT JOIN chefequipe ON ((chefequipe.cle_equipe = affectation.cle_equipe))) LEFT JOIN grade ON ((grade.cle = support.cle_grade))) LEFT JOIN catgrade ON (((grade.cle_catgrade)::text = (catgrade.sigle)::text))) LEFT JOIN categorie ON ((categorie.cle = support.cle_categorie))) WHERE ((((support.debut <= now()) AND ((support.fin >= now()) OR (support.fin IS NULL))) AND ((affectation.fin >= now()) OR (affectation.fin IS NULL))) AND ((chefequipe.fin >= ''2015-01-01''::date) OR (chefequipe.fin IS NULL))) ORDER BY equipeexterne.nom, grade.poids DESC, catgrade.sigle, personne.nom, personne.prenom' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView42 [
	self
		parse: 'CREATE VIEW web_noms_longs_equipes_by_equipeexterne AS SELECT equipe.nomlong, equipe.nomlong_en, r_equextequ.cle_equipe_externe FROM ((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL)) AND ((equipe.fin >= now()) OR (equipe.fin IS NULL)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView43 [
	self
		parse: 'CREATE VIEW web_plateforme AS SELECT DISTINCT plateforme.cle, plateforme.nom, plateforme.description, plateforme.description_en, plateforme.siteweb, personne.nom AS resp_nom, personne.prenom AS resp_prenom FROM (plateforme LEFT JOIN personne ON ((plateforme.cle_responsable = personne.cle)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView44 [
	self
		parse: 'CREATE VIEW web_publis AS SELECT DISTINCT publi.titre, publi.halid, typepubli.intitule, typepubli.intitule_en, publi.auteurs, publi.journal, publi.page, publi.fichier, publi.cle_type AS type, date_part(''year''::text, publi.datepubli) AS annee, publi.datepubli FROM (publi LEFT JOIN typepubli ON (((publi.cle_type)::text = (typepubli.type)::text))) WHERE (((((publi.cle_type)::text <> ''THESE''::text) AND ((publi.cle_type)::text <> ''BREVET''::text)) AND ((publi.cle_type)::text <> ''HDR''::text)) AND (publi.datepubli IS NOT NULL)) ORDER BY publi.datepubli DESC, publi.cle_type' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView45 [
	self
		parse: 'CREATE VIEW web_responsables_by_equipeexterne AS SELECT DISTINCT personne.nom, personne.prenom, r_equextequ.cle_equipe_externe FROM (((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN chefequipe ON ((chefequipe.cle_equipe = equipe.cle))) JOIN personne ON ((chefequipe.cle_personne = personne.cle))) WHERE ((chefequipe.fin >= ''2015-01-01''::date) OR (chefequipe.fin IS NULL)) ORDER BY r_equextequ.cle_equipe_externe' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView46 [
	self
		parse: 'CREATE VIEW web_sitesweb_by_equipeexterne AS SELECT equipe.siteweb, r_equextequ.cle_equipe_externe FROM ((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL)) AND ((equipe.fin >= now()) OR (equipe.fin IS NULL)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView47 [
	self
		parse: 'CREATE VIEW web_soutenances_futures AS SELECT DISTINCT soutenance.cle AS id, soutenance.jury, soutenance.jury_en, diplome.fin, date_part(''year''::text, diplome.fin) AS annee, sujet.titre, sujet.titre_en, sujet.resume, lieusoutenance.nom AS lieu, personne.nom, personne.prenom, pg_class.relname, diplome.cle AS diplome_id FROM (((((soutenance LEFT JOIN diplome ON ((soutenance.cle_diplome = diplome.cle))) LEFT JOIN sujet ON ((diplome.cle_sujet = sujet.cle))) LEFT JOIN lieusoutenance ON ((lieusoutenance.cle = soutenance.cle_lieusoutenance))) LEFT JOIN personne ON ((diplome.cle_personne = personne.cle))) LEFT JOIN pg_class ON ((diplome.tableoid = pg_class.oid))) WHERE ((NOT (personne.nom IS NULL)) AND (diplome.fin >= (now() - ''1 day''::interval))) ORDER BY diplome.fin DESC, personne.nom, sujet.titre' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView48 [
	self
		parse: 'CREATE VIEW web_theses AS SELECT these.cle, personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, sujet.resume, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, equipeexterne.cle AS eid, equipeexterne.nom AS equipe, soutenance.jury, sujet.titre_en AS sujet_en, sujet.resume_en, soutenance.jury_en FROM ((((((these LEFT JOIN sujet ON ((sujet.cle = these.cle_sujet))) LEFT JOIN personne ON ((personne.cle = these.cle_personne))) LEFT JOIN equipe ON ((equipe.cle = these.cle_equipe))) LEFT JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) LEFT JOIN soutenance ON ((soutenance.cle_diplome = these.cle))) WHERE ((equipeexterne.fin >= ''2015-01-01''::date) OR (equipeexterne.fin IS NULL)) ORDER BY personne.nom' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView49 [
	self
		parse: 'CREATE VIEW web_theses_encours_par_equipeexterne AS SELECT personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, equipeexterne.cle AS eid, equipeexterne.nom AS equipe, sujet.titre_en AS sujet_en, sujet.resume_en FROM (((((these LEFT JOIN sujet ON ((sujet.cle = these.cle_sujet))) LEFT JOIN personne ON ((personne.cle = these.cle_personne))) LEFT JOIN equipe ON ((equipe.cle = these.cle_equipe))) LEFT JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((((these.fin IS NULL) OR (these.fin > ''2015-01-01''::date)) AND (these.abandon = false)) AND ((equipe.fin IS NULL) OR (equipe.fin > ''2015-01-01''::date))) AND ((equipeexterne.fin IS NULL) OR (equipeexterne.fin > ''2015-01-01''::date))) ORDER BY personne.nom' rule: #createViewCommand
]

{ #category : #tests }
PSQLGrammarCreateViewCrashTest >> testCreateView5 [
	self
		parse: 'CREATE VIEW vue_coencadrant_de_theses AS SELECT personne.cle, personne.nom, personne.prenom FROM personne WHERE (personne.cle IN (SELECT these.cle_coencadrant FROM these))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView50 [
	self
		parse: 'CREATE VIEW web_theses_soutenues_par_equipeexterne AS SELECT these.cle, personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, equipeexterne.cle AS eid, equipeexterne.nom AS equipe, sujet.titre_en AS sujet_en, sujet.resume_en FROM (((((these LEFT JOIN sujet ON ((sujet.cle = these.cle_sujet))) LEFT JOIN personne ON ((personne.cle = these.cle_personne))) LEFT JOIN equipe ON ((equipe.cle = these.cle_equipe))) LEFT JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE ((((these.fin < now()) AND (these.abandon = false)) AND ((equipe.fin IS NULL) OR (equipe.fin > ''2015-01-01''::date))) AND ((equipeexterne.fin IS NULL) OR (equipeexterne.fin > ''2015-01-01''::date))) ORDER BY these.fin DESC' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView51 [
	self
		parse: 'CREATE VIEW web_zooms AS SELECT zoom.cle, zoom.titre, zoom.titre_en, zoom.cle_couleur, zoom.cle_actu, actualite.debut, actualite.heure, actualite.intervenant, actualite.cle_categorie, actualite.titre AS titre_actu, actualite.titre_en AS titre_actu_en, actualite.titrecourt, actualite.titrecourt_en, actualite.heurefin, actualite.description, actualite.description_en, categorie_actualite.code, s_cat_zoom.nom AS type FROM (((zoom LEFT JOIN actualite ON ((zoom.cle_actu = actualite.cle))) LEFT JOIN categorie_actualite ON ((actualite.cle_categorie = categorie_actualite.cle))) LEFT JOIN s_cat_zoom ON ((s_cat_zoom.cle = zoom.cle_cat_zoom)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView52 [
	self
		parse: 'CREATE VIEW area_delegation AS SELECT DISTINCT ON (area.id, delegation.truster_id) area.id AS area_id, delegation.id, delegation.truster_id, delegation.trustee_id, delegation.scope FROM (((area JOIN delegation ON (((delegation.unit_id = area.unit_id) OR (delegation.area_id = area.id)))) JOIN member ON ((delegation.truster_id = member.id))) JOIN privilege ON (((area.unit_id = privilege.unit_id) AND (delegation.truster_id = privilege.member_id)))) WHERE (member.active AND privilege.voting_right) ORDER BY area.id, delegation.truster_id, delegation.scope DESC' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView53 [
	self
		parse: 'CREATE VIEW area_member_count AS SELECT area.id AS area_id, count(member.id) AS direct_member_count, COALESCE(sum( CASE WHEN (member.id IS NOT NULL) THEN membership_weight(area.id, member.id) ELSE 0 END)) AS member_weight FROM (((area LEFT JOIN membership ON ((area.id = membership.area_id))) LEFT JOIN privilege ON ((((privilege.unit_id = area.unit_id) AND (privilege.member_id = membership.member_id)) AND privilege.voting_right))) LEFT JOIN member ON (((member.id = privilege.member_id) AND member.active))) GROUP BY area.id' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView54 [
	self
		parse: 'CREATE VIEW battle_participant AS SELECT initiative.id, initiative.issue_id FROM (issue JOIN initiative ON ((issue.id = initiative.issue_id))) WHERE initiative.admitted UNION ALL SELECT NULL::integer AS id, issue.id AS issue_id FROM issue' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView55 [
	self
		parse: 'CREATE VIEW battle_view AS SELECT issue.id AS issue_id, winning_initiative.id AS winning_initiative_id, losing_initiative.id AS losing_initiative_id, sum( CASE WHEN (COALESCE(better_vote.grade, 0) > COALESCE(worse_vote.grade, 0)) THEN direct_voter.weight ELSE 0 END) AS count FROM (((((issue LEFT JOIN direct_voter ON ((issue.id = direct_voter.issue_id))) JOIN battle_participant winning_initiative ON ((issue.id = winning_initiative.issue_id))) JOIN battle_participant losing_initiative ON ((issue.id = losing_initiative.issue_id))) LEFT JOIN vote better_vote ON (((direct_voter.member_id = better_vote.member_id) AND (winning_initiative.id = better_vote.initiative_id)))) LEFT JOIN vote worse_vote ON (((direct_voter.member_id = worse_vote.member_id) AND (losing_initiative.id = worse_vote.initiative_id)))) WHERE (((issue.state = ''voting''::issue_state) AND (issue.phase_finished IS NOT NULL)) AND ((winning_initiative.id <> losing_initiative.id) OR (((winning_initiative.id IS NOT NULL) AND (losing_initiative.id IS NULL)) OR ((winning_initiative.id IS NULL) AND (losing_initiative.id IS NOT NULL))))) GROUP BY issue.id, winning_initiative.id, losing_initiative.id' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView56 [
	self
		parse: 'CREATE VIEW critical_opinion AS SELECT opinion.initiative_id, opinion.suggestion_id, opinion.member_id, opinion.degree, opinion.fulfilled FROM opinion WHERE (((opinion.degree = 2) AND (opinion.fulfilled = false)) OR ((opinion.degree = (-2)) AND (opinion.fulfilled = true)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView57 [
	self
		parse: 'CREATE VIEW current_draft AS SELECT draft.initiative_id, draft.id, draft.created, draft.author_id, draft.formatting_engine, draft.content, draft.external_reference, draft.text_search_data FROM (( SELECT initiative.id AS initiative_id, max(draft_1.id) AS draft_id FROM (initiative JOIN draft draft_1 ON ((initiative.id = draft_1.initiative_id))) GROUP BY initiative.id) subquery JOIN draft ON ((subquery.draft_id = draft.id)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView58 [
	self
		parse: 'CREATE VIEW event_seen_by_member AS SELECT member.id AS seen_by_member_id, CASE WHEN (event.state = ANY (ARRAY[''voting''::issue_state, ''finished_without_winner''::issue_state, ''finished_with_winner''::issue_state])) THEN ''voting''::notify_level ELSE CASE WHEN (event.state = ANY (ARRAY[''verification''::issue_state, ''canceled_after_revocation_during_verification''::issue_state, ''canceled_no_initiative_admitted''::issue_state])) THEN ''verification''::notify_level ELSE CASE WHEN (event.state = ANY (ARRAY[''discussion''::issue_state, ''canceled_after_revocation_during_discussion''::issue_state])) THEN ''discussion''::notify_level ELSE ''all''::notify_level END END END AS notify_level, event.id, event.occurrence, event.event, event.member_id, event.issue_id, event.state, event.initiative_id, event.draft_id, event.suggestion_id FROM ((((((member CROSS JOIN event) LEFT JOIN issue ON ((event.issue_id = issue.id))) LEFT JOIN membership ON (((member.id = membership.member_id) AND (issue.area_id = membership.area_id)))) LEFT JOIN interest ON (((member.id = interest.member_id) AND (event.issue_id = interest.issue_id)))) LEFT JOIN ignored_member ON (((member.id = ignored_member.member_id) AND (event.member_id = ignored_member.other_member_id)))) LEFT JOIN ignored_initiative ON (((member.id = ignored_initiative.member_id) AND (event.initiative_id = ignored_initiative.initiative_id)))) WHERE ((((interest.member_id IS NOT NULL) OR ((membership.member_id IS NOT NULL) AND (event.event = ANY (ARRAY[''issue_state_changed''::event_type, ''initiative_created_in_new_issue''::event_type, ''initiative_created_in_existing_issue''::event_type, ''initiative_revoked''::event_type])))) AND (ignored_member.member_id IS NULL)) AND (ignored_initiative.member_id IS NULL))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView59 [
	self
		parse: 'CREATE VIEW expired_session AS SELECT session.ident, session.additional_secret, session.expiry, session.member_id, session.authority, session.authority_uid, session.authority_login, session.needs_delegation_check, session.lang FROM session WHERE (now() > session.expiry)' rule: #createViewCommand
]

{ #category : #tests }
PSQLGrammarCreateViewCrashTest >> testCreateView6 [
	self
		parse: 'CREATE VIEW vue_coherence_dates_affectation_equipe AS SELECT equipe.cle AS cleequipe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, equipe.nom AS nomequipe, equipe.debut AS debutequipe, equipe.fin AS finequipe, affectation.debut AS debutaffectation, affectation.fin AS finaffectation FROM affectation, equipe, support, personne WHERE ((((affectation.cle_equipe = equipe.cle) AND (((affectation.debut > equipe.fin) OR (affectation.debut < equipe.debut)) OR (affectation.fin > equipe.fin))) AND (affectation.cle_support = support.cle)) AND (support.cle_personne = personne.cle))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView60 [
	self
		parse: 'CREATE VIEW individual_suggestion_ranking AS SELECT opinion.initiative_id, opinion.member_id, direct_interest_snapshot.weight, CASE WHEN (((opinion.degree = 2) AND (opinion.fulfilled = false)) OR ((opinion.degree = (-2)) AND (opinion.fulfilled = true))) THEN 1 ELSE CASE WHEN (((opinion.degree = 1) AND (opinion.fulfilled = false)) OR ((opinion.degree = (-1)) AND (opinion.fulfilled = true))) THEN 2 ELSE CASE WHEN (((opinion.degree = 2) AND (opinion.fulfilled = true)) OR ((opinion.degree = (-2)) AND (opinion.fulfilled = false))) THEN 3 ELSE 4 END END END AS preference, opinion.suggestion_id FROM (((opinion JOIN initiative ON ((initiative.id = opinion.initiative_id))) JOIN issue ON ((issue.id = initiative.issue_id))) JOIN direct_interest_snapshot ON ((((direct_interest_snapshot.issue_id = issue.id) AND (direct_interest_snapshot.event = issue.latest_snapshot_event)) AND (direct_interest_snapshot.member_id = opinion.member_id))))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView61 [
	self
		parse: 'CREATE VIEW initiative_suggestion_order_calculation AS SELECT initiative.id AS initiative_id, ((issue.closed IS NOT NULL) OR (issue.fully_frozen IS NOT NULL)) AS final FROM (initiative JOIN issue ON ((initiative.issue_id = issue.id))) WHERE (((issue.closed IS NULL) AND (issue.fully_frozen IS NULL)) OR (initiative.final_suggestion_order_calculated = false))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView62 [
	self
		parse: 'CREATE VIEW issue_delegation AS SELECT DISTINCT ON (issue.id, delegation.truster_id) issue.id AS issue_id, delegation.id, delegation.truster_id, delegation.trustee_id, delegation.scope FROM ((((issue JOIN area ON ((area.id = issue.area_id))) JOIN delegation ON ((((delegation.unit_id = area.unit_id) OR (delegation.area_id = area.id)) OR (delegation.issue_id = issue.id)))) JOIN member ON ((delegation.truster_id = member.id))) JOIN privilege ON (((area.unit_id = privilege.unit_id) AND (delegation.truster_id = privilege.member_id)))) WHERE (member.active AND privilege.voting_right) ORDER BY issue.id, delegation.truster_id, delegation.scope DESC' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView63 [
	self
		parse: 'CREATE VIEW issue_supporter_in_admission_state AS SELECT DISTINCT area.unit_id, issue.area_id, issue.id AS issue_id, supporter.member_id, direct_interest_snapshot.weight FROM (((issue JOIN area ON ((area.id = issue.area_id))) JOIN supporter ON ((supporter.issue_id = issue.id))) JOIN direct_interest_snapshot ON ((((direct_interest_snapshot.issue_id = issue.id) AND (direct_interest_snapshot.event = issue.latest_snapshot_event)) AND (direct_interest_snapshot.member_id = supporter.member_id)))) WHERE (issue.state = ''admission''::issue_state)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView64 [
	self
		parse: 'CREATE VIEW liquid_feedback_version AS SELECT subquery.string, subquery.major, subquery.minor, subquery.revision FROM ( VALUES (''3.1.0''::text,3,1,0)) subquery(string, major, minor, revision)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView65 [
	self
		parse: 'CREATE VIEW opening_draft AS SELECT draft.initiative_id, draft.id, draft.created, draft.author_id, draft.formatting_engine, draft.content, draft.external_reference, draft.text_search_data FROM (( SELECT initiative.id AS initiative_id, min(draft_1.id) AS draft_id FROM (initiative JOIN draft draft_1 ON ((initiative.id = draft_1.initiative_id))) GROUP BY initiative.id) subquery JOIN draft ON ((subquery.draft_id = draft.id)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView66 [
	self
		parse: 'CREATE VIEW member_contingent AS SELECT member.id AS member_id, contingent.polling, contingent.time_frame, CASE WHEN (contingent.text_entry_limit IS NOT NULL) THEN (( SELECT count(1) AS count FROM (draft JOIN initiative ON ((initiative.id = draft.initiative_id))) WHERE (((draft.author_id = member.id) AND (initiative.polling = contingent.polling)) AND (draft.created > (now() - contingent.time_frame)))) + ( SELECT count(1) AS count FROM (suggestion JOIN initiative ON ((initiative.id = suggestion.initiative_id))) WHERE (((suggestion.author_id = member.id) AND (contingent.polling = false)) AND (suggestion.created > (now() - contingent.time_frame))))) ELSE NULL::bigint END AS text_entry_count, contingent.text_entry_limit, CASE WHEN (contingent.initiative_limit IS NOT NULL) THEN ( SELECT count(1) AS count FROM (opening_draft draft JOIN initiative ON ((initiative.id = draft.initiative_id))) WHERE (((draft.author_id = member.id) AND (initiative.polling = contingent.polling)) AND (draft.created > (now() - contingent.time_frame)))) ELSE NULL::bigint END AS initiative_count, contingent.initiative_limit FROM (member CROSS JOIN contingent)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView67 [
	self
		parse: 'CREATE VIEW member_contingent_left AS SELECT member_contingent.member_id, member_contingent.polling, max((member_contingent.text_entry_limit - member_contingent.text_entry_count)) AS text_entries_left, max((member_contingent.initiative_limit - member_contingent.initiative_count)) AS initiatives_left FROM member_contingent GROUP BY member_contingent.member_id, member_contingent.polling' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView68 [
	self
		parse: 'CREATE VIEW member_count_view AS SELECT count(1) AS total_count FROM member WHERE member.active' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView69 [
	self
		parse: 'CREATE VIEW open_issue AS SELECT issue.id, issue.area_id, issue.policy_id, issue.admin_notice, issue.external_reference, issue.state, issue.phase_finished, issue.created, issue.accepted, issue.half_frozen, issue.fully_frozen, issue.closed, issue.cleaned, issue.min_admission_time, issue.max_admission_time, issue.discussion_time, issue.verification_time, issue.voting_time, issue.snapshot, issue.latest_snapshot_event, issue.population, issue.voter_count, issue.status_quo_schulze_rank FROM issue WHERE (issue.closed IS NULL)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView7 [
	self
		parse: 'CREATE VIEW vue_contractuels_recherche AS SELECT civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, grade.grade AS corps, typesupport.nature AS typecontrat, support.debut AS debutsupport, support.fin AS finsupport, employeur.nom AS nomemployeur, these.fin AS finthese, these.abandon AS abandonthese FROM (((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle))), grade, typesupport, employeur WHERE ((((support.cle_grade = grade.cle) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND ((grade.cle = 27) OR (grade.cle = 17)))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView70 [
	self
		parse: 'CREATE VIEW remaining_harmonic_initiative_weight_dummies AS SELECT initiative.issue_id, initiative.id AS initiative_id, initiative.admitted, 0 AS weight_num, 1 AS weight_den FROM initiative WHERE (initiative.harmonic_weight IS NULL)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView71 [
	self
		parse: 'CREATE VIEW remaining_harmonic_supporter_weight AS SELECT direct_interest_snapshot.issue_id, direct_interest_snapshot.event, direct_interest_snapshot.member_id, direct_interest_snapshot.weight AS weight_num, count(initiative.id) AS weight_den FROM (((issue JOIN direct_interest_snapshot ON (((issue.id = direct_interest_snapshot.issue_id) AND (issue.latest_snapshot_event = direct_interest_snapshot.event)))) JOIN initiative ON (((issue.id = initiative.issue_id) AND (initiative.harmonic_weight IS NULL)))) JOIN direct_supporter_snapshot ON (((((initiative.id = direct_supporter_snapshot.initiative_id) AND (direct_interest_snapshot.event = direct_supporter_snapshot.event)) AND (direct_interest_snapshot.member_id = direct_supporter_snapshot.member_id)) AND ((direct_supporter_snapshot.satisfied = true) OR (COALESCE(initiative.admitted, false) = false))))) GROUP BY direct_interest_snapshot.issue_id, direct_interest_snapshot.event, direct_interest_snapshot.member_id, direct_interest_snapshot.weight' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView72 [
	self
		parse: 'CREATE VIEW remaining_harmonic_initiative_weight_summands AS SELECT initiative.issue_id, initiative.id AS initiative_id, initiative.admitted, sum(remaining_harmonic_supporter_weight.weight_num) AS weight_num, remaining_harmonic_supporter_weight.weight_den FROM ((remaining_harmonic_supporter_weight JOIN initiative ON (((remaining_harmonic_supporter_weight.issue_id = initiative.issue_id) AND (initiative.harmonic_weight IS NULL)))) JOIN direct_supporter_snapshot ON (((((initiative.id = direct_supporter_snapshot.initiative_id) AND (remaining_harmonic_supporter_weight.event = direct_supporter_snapshot.event)) AND (remaining_harmonic_supporter_weight.member_id = direct_supporter_snapshot.member_id)) AND ((direct_supporter_snapshot.satisfied = true) OR (COALESCE(initiative.admitted, false) = false))))) GROUP BY initiative.issue_id, initiative.id, initiative.admitted, remaining_harmonic_supporter_weight.weight_den' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView73 [
	self
		parse: 'CREATE VIEW selected_event_seen_by_member AS SELECT member.id AS seen_by_member_id, CASE WHEN (event.state = ANY (ARRAY[''voting''::issue_state, ''finished_without_winner''::issue_state, ''finished_with_winner''::issue_state])) THEN ''voting''::notify_level ELSE CASE WHEN (event.state = ANY (ARRAY[''verification''::issue_state, ''canceled_after_revocation_during_verification''::issue_state, ''canceled_no_initiative_admitted''::issue_state])) THEN ''verification''::notify_level ELSE CASE WHEN (event.state = ANY (ARRAY[''discussion''::issue_state, ''canceled_after_revocation_during_discussion''::issue_state])) THEN ''discussion''::notify_level ELSE ''all''::notify_level END END END AS notify_level, event.id, event.occurrence, event.event, event.member_id, event.issue_id, event.state, event.initiative_id, event.draft_id, event.suggestion_id FROM ((((((member CROSS JOIN event) LEFT JOIN issue ON ((event.issue_id = issue.id))) LEFT JOIN membership ON (((member.id = membership.member_id) AND (issue.area_id = membership.area_id)))) LEFT JOIN interest ON (((member.id = interest.member_id) AND (event.issue_id = interest.issue_id)))) LEFT JOIN ignored_member ON (((member.id = ignored_member.member_id) AND (event.member_id = ignored_member.other_member_id)))) LEFT JOIN ignored_initiative ON (((member.id = ignored_initiative.member_id) AND (event.initiative_id = ignored_initiative.initiative_id)))) WHERE (((((((member.notify_level >= ''all''::notify_level) OR ((member.notify_level >= ''voting''::notify_level) AND (event.state = ANY (ARRAY[''voting''::issue_state, ''finished_without_winner''::issue_state, ''finished_with_winner''::issue_state])))) OR ((member.notify_level >= ''verification''::notify_level) AND (event.state = ANY (ARRAY[''verification''::issue_state, ''canceled_after_revocation_during_verification''::issue_state, ''canceled_no_initiative_admitted''::issue_state])))) OR ((member.notify_level >= ''discussion''::notify_level) AND (event.state = ANY (ARRAY[''discussion''::issue_state, ''canceled_after_revocation_during_discussion''::issue_state])))) AND ((interest.member_id IS NOT NULL) OR ((membership.member_id IS NOT NULL) AND (event.event = ANY (ARRAY[''issue_state_changed''::event_type, ''initiative_created_in_new_issue''::event_type, ''initiative_created_in_existing_issue''::event_type, ''initiative_revoked''::event_type]))))) AND (ignored_member.member_id IS NULL)) AND (ignored_initiative.member_id IS NULL))' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView74 [
	self
		parse: 'CREATE VIEW unit_delegation AS SELECT unit.id AS unit_id, delegation.id, delegation.truster_id, delegation.trustee_id, delegation.scope FROM (((unit JOIN delegation ON ((delegation.unit_id = unit.id))) JOIN member ON ((delegation.truster_id = member.id))) JOIN privilege ON (((delegation.unit_id = privilege.unit_id) AND (delegation.truster_id = privilege.member_id)))) WHERE (member.active AND privilege.voting_right)' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView75 [
	self
		parse: 'CREATE VIEW unit_member_count AS SELECT unit.id AS unit_id, count(member.id) AS member_count FROM ((unit LEFT JOIN privilege ON (((privilege.unit_id = unit.id) AND privilege.voting_right))) LEFT JOIN member ON (((member.id = privilege.member_id) AND member.active))) GROUP BY unit.id' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView8 [
	self
		parse: 'CREATE VIEW vue_financements_des_supports AS SELECT financements.clesupport, financements.reffinancement, financements.typefinancement, agt_genere_liste((financements.financeurs)::text) AS financeurs FROM (SELECT support.cle AS clesupport, support.financement AS reffinancement, typefinancement.type AS typefinancement, employeur.nom AS financeurs, r_supfin.principal FROM (((support LEFT JOIN r_supfin ON ((support.cle = r_supfin.cle_support))) LEFT JOIN employeur ON ((r_supfin.cle_financeur = employeur.cle))) LEFT JOIN typefinancement ON ((support.cle_typefinancement = typefinancement.cle))) ORDER BY support.cle, r_supfin.principal DESC) financements GROUP BY financements.clesupport, financements.reffinancement, financements.typefinancement' rule: #createViewCommand
]

{ #category : #'as yet unclassified' }
PSQLGrammarCreateViewCrashTest >> testCreateView9 [
	self
		parse: 'CREATE VIEW vue_contrats_doctoraux AS SELECT personne.cle AS clepersonne, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, equipe.nom AS nomequipe, support.cle_typesupport, support.debut AS debutsupport, support.fin AS finsupport, vue_financements_des_supports.typefinancement, employeur.nom AS nomemployeur, vue_financements_des_supports.financeurs, vue_financements_des_supports.reffinancement, aff_date_fin_these(date(these.fin), these.abandon) AS txtfinthese, date(these.fin) AS finthese, these.abandon AS abandonthese, affectation.debut AS debutaffectation, affectation.fin AS finaffectation, e2.nom AS cotutelle, typesupport.nature AS typesupport FROM (personne LEFT JOIN these ON ((personne.cle = these.cle_personne))), (support LEFT JOIN employeur e2 ON ((support.cle_cotutelle = e2.cle))), affectation, employeur, equipe, vue_financements_des_supports, typesupport WHERE (((((((support.cle_personne = personne.cle) AND (support.cle_grade = 8)) AND (support.cle_employeur = employeur.cle)) AND (support.cle = vue_financements_des_supports.clesupport)) AND (support.cle = affectation.cle_support)) AND (equipe.cle = affectation.cle_equipe)) AND (support.cle_typesupport = typesupport.cle))' rule: #createViewCommand
]
