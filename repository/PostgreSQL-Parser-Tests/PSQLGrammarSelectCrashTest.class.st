Class {
	#name : #PSQLGrammarSelectCrashTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLGrammarSelectCrashTest >> parserClass [
	^ PSQLSelectQueryGrammar
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect1 [
	self
		parse: 'SELECT affectation.debut AS debutaffectation, affectation.fin AS finaffectation FROM affectation,support,personne WHERE affectation.cle_support = support.cle AND	support.cle_personne = personne.cle AND personne.cle = clepersonne AND	affectation.cle_equipe = cleequipe AND affectation.fin <= finperiode ORDER BY affectation.debut' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect10 [
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom FROM personne WHERE (personne.cle IN (SELECT these.cle_coencadrant FROM these))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect11 [
	self
		parse: 'SELECT equipe.cle AS cleequipe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, equipe.nom AS nomequipe, equipe.debut AS debutequipe, equipe.fin AS finequipe, affectation.debut AS debutaffectation, affectation.fin AS finaffectation FROM affectation, equipe, support, personne WHERE ((((affectation.cle_equipe = equipe.cle) AND (((affectation.debut > equipe.fin) OR (affectation.debut < equipe.debut)) OR (affectation.fin > equipe.fin))) AND (affectation.cle_support = support.cle)) AND (support.cle_personne = personne.cle))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect12 [
	self
		parse: 'SELECT civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, grade.grade AS corps, typesupport.nature AS typecontrat, support.debut AS debutsupport, support.fin AS finsupport, employeur.nom AS nomemployeur, these.fin AS finthese, these.abandon AS abandonthese FROM (((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle))), grade, typesupport, employeur WHERE ((((support.cle_grade = grade.cle) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND ((grade.cle = 27) OR (grade.cle = 17)))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect13 [
	self
		parse: 'SELECT financements.clesupport, financements.reffinancement, financements.typefinancement, agt_genere_liste((financements.financeurs)::text) AS financeurs FROM (SELECT support.cle AS clesupport, support.financement AS reffinancement, typefinancement.type AS typefinancement, employeur.nom AS financeurs, r_supfin.principal FROM (((support LEFT JOIN r_supfin ON ((support.cle = r_supfin.cle_support))) LEFT JOIN employeur ON ((r_supfin.cle_financeur = employeur.cle))) LEFT JOIN typefinancement ON ((support.cle_typefinancement = typefinancement.cle))) ORDER BY support.cle, r_supfin.principal DESC) financements GROUP BY financements.clesupport, financements.reffinancement, financements.typefinancement' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect14 [
	self
		parse: 'SELECT personne.cle AS clepersonne, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, equipe.nom AS nomequipe, support.cle_typesupport, support.debut AS debutsupport, support.fin AS finsupport, vue_financements_des_supports.typefinancement, employeur.nom AS nomemployeur, vue_financements_des_supports.financeurs, vue_financements_des_supports.reffinancement, aff_date_fin_these(date(these.fin), these.abandon) AS txtfinthese, date(these.fin) AS finthese, these.abandon AS abandonthese, affectation.debut AS debutaffectation, affectation.fin AS finaffectation, e2.nom AS cotutelle, typesupport.nature AS typesupport FROM (personne LEFT JOIN these ON ((personne.cle = these.cle_personne))), (support LEFT JOIN employeur e2 ON ((support.cle_cotutelle = e2.cle))), affectation, employeur, equipe, vue_financements_des_supports, typesupport WHERE (((((((support.cle_personne = personne.cle) AND (support.cle_grade = 8)) AND (support.cle_employeur = employeur.cle)) AND (support.cle = vue_financements_des_supports.clesupport)) AND (support.cle = affectation.cle_support)) AND (equipe.cle = affectation.cle_equipe)) AND (support.cle_typesupport = typesupport.cle))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect15 [
	self
		parse: 'SELECT support.cle AS clesupport, employeur.nom AS nomemployeur FROM (support JOIN employeur ON ((employeur.cle = support.cle_employeur)))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect16 [
	self
		parse: 'SELECT personne.cle AS clepersonne, civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, enseignement.entite AS nomenseignement, employeur.nom AS nomemployeur, support.debut AS debutsupport, support.fin AS finsupport, grade.grade AS statut FROM (((((personne JOIN civilite ON ((personne.civilite = civilite.cle))) JOIN support ON ((support.cle_personne = personne.cle))) LEFT JOIN enseignement ON ((support.cle_enseignement = enseignement.cle))) JOIN employeur ON ((support.cle_employeur = employeur.cle))) JOIN grade ON ((support.cle_grade = grade.cle))) WHERE (((grade.cle_catgrade)::text = ''MCF''::text) OR ((grade.cle_catgrade)::text = ''PR''::text))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect17 [
	self
		parse: 'SELECT date_part(''year''::text, support.debut) AS annee, count(*) AS total, (sum(est_un_homme(personne.civilite)))::integer AS homme, (sum(est_une_femme(personne.civilite)))::integer AS femme FROM personne, support WHERE ((personne.cle = support.cle_personne) AND (date_part(''year''::text, support.debut) IN (SELECT DISTINCT date_part(''year''::text, support.debut) AS annee FROM support ORDER BY date_part(''year''::text, support.debut)))) GROUP BY date_part(''year''::text, support.debut) ORDER BY date_part(''year''::text, support.debut)' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect18 [
	self
		parse: 'SELECT personne.cle AS clepersonne, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, grade.grade, employeur.nom AS nomemployeur, support.debut AS debutsupport, support.fin AS finsupport FROM personne, support, grade, categorie, employeur WHERE (((((((personne.cle = support.cle_personne) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND ((categorie.categorie)::text = ''PERMANENT''::text)) AND (support.cle_employeur = employeur.cle)) AND (((((support.cle_employeur = 1) OR (support.cle_employeur = 15)) OR (support.cle_employeur = 2)) OR (support.cle_employeur = 3)) OR (support.cle_employeur = 107))) AND ((grade.cle_catgrade)::text = ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text])))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect19 [
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom FROM personne WHERE (personne.cle IN (SELECT these.cle_responsable FROM these))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect2 [
	self
		parse: 'SELECT * FROM membres(labo,dateobservation::DATE,dateobservation::DATE) AS ( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect20 [
	self
		parse: 'SELECT premierssupports.cle_personne, premierssupports.min, support.cle AS clesupport FROM (SELECT support.cle_personne, min(support.debut) AS min FROM support GROUP BY support.cle_personne) premierssupports, support WHERE ((support.cle_personne = premierssupports.cle_personne) AND (support.debut = premierssupports.min))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect21 [
	self
		parse: 'SELECT personne.cle AS clepersonne, vue_support_le_plus_ancien.min AS datearrivee, civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, personne.datenaissance, pays.nom AS paysorigine, categorie.categorie AS nomcategorie, grade.grade AS corps, typesupport.nature AS typedusupport, section.numero AS numsection, cmu.numero AS numcmu, support.debut AS debutsupport, support.fin AS finsupport, equipe.nom AS nomequipe, affectation.debut AS debutaffectation, affectation.fin AS finaffectation, affectation.repartition, employeur.nom AS nomemployeur, enseignement.entite AS nomenseignement, vue_financements_des_supports.typefinancement, vue_financements_des_supports.financeurs, vue_financements_des_supports.reffinancement, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) AS responsablethese FROM civilite, vue_support_le_plus_ancien, ((((support LEFT JOIN enseignement ON ((support.cle_enseignement = enseignement.cle))) LEFT JOIN section ON ((support.cle_section = section.cle))) LEFT JOIN cmu ON ((support.cle_cmu = cmu.cle))) LEFT JOIN vue_financements_des_supports ON ((support.cle = vue_financements_des_supports.clesupport))), pays, categorie, grade, typesupport, employeur, affectation, equipe, ((these LEFT JOIN vue_responsable_de_theses ON ((these.cle_responsable = vue_responsable_de_theses.cle))) RIGHT JOIN personne ON ((these.cle_personne = personne.cle))) WHERE ((((((((((personne.cle = vue_support_le_plus_ancien.cle_personne) AND (support.cle_personne = personne.cle)) AND (personne.civilite = civilite.cle)) AND (personne.paysorigine = pays.cle)) AND (support.cle_categorie = categorie.cle)) AND (support.cle_grade = grade.cle)) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND (affectation.cle_support = support.cle)) AND (equipe.cle = affectation.cle_equipe)) GROUP BY personne.nom, personne.prenom, personne.cle, vue_support_le_plus_ancien.min, civilite.civilite, personne.datenaissance, pays.nom, categorie.categorie, grade.grade, typesupport.nature, section.numero, cmu.numero, support.debut, support.fin, equipe.nom, affectation.debut, affectation.fin, affectation.repartition, employeur.nom, enseignement.entite, vue_financements_des_supports.typefinancement, vue_financements_des_supports.financeurs, vue_financements_des_supports.reffinancement, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) ORDER BY personne.nom, personne.prenom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect22 [
	self
		parse: 'SELECT personne.cle AS clepersonne, civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, grade.grade AS corps, equipe.nom AS nomequipe, typesupport.nature AS typesupport, support.debut AS debutsupport, support.fin AS finsupport, employeur.nom AS nomemployeur FROM civilite, personne, grade, support, affectation, equipe, typesupport, employeur WHERE ((((((((support.cle_personne = personne.cle) AND (personne.civilite = civilite.cle)) AND (support.cle_grade = grade.cle)) AND (affectation.cle_support = support.cle)) AND (affectation.cle_equipe = equipe.cle)) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND (support.cle_categorie = 4))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect23 [
	self
		parse: 'SELECT personne.cle AS clepersonne, support.cle AS clesupport, civilite.civilite AS labelcivilite, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, pays.nom AS nompays, grade.grade, employeur.nom AS nomemployeur, support.debut AS debutsupport, support.fin AS finsupport FROM personne, pays, civilite, grade, categorie, employeur, support WHERE ((((((((personne.cle = support.cle_personne) AND (personne.civilite = civilite.cle)) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND (support.cle_employeur = employeur.cle)) AND (personne.paysorigine = pays.cle)) AND (support.cle_grade = ANY (ARRAY[25, 51, 52, 53, 9, 10, 11, 12, 20, 21, 22, 24, 26]))) AND ((categorie.categorie)::text = ''PERMANENT''::text))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect24 [
	self
		parse: 'SELECT personne.cle AS clepersonne, civilite.civilite AS labelcivilite, personne.nom AS nompersonne, personne.prenom, personne.datenaissance, pays.nom AS nompays, grade.grade, employeur.nom AS nomemployeur, support.debut AS debutsupport, support.fin AS finsupport, agt_genere_liste(((((equipe.nom)::text || '' (''::text) || affectation.repartition) || ''%)''::text)) AS nomequipes FROM personne, pays, civilite, grade, categorie, employeur, equipe, (affectation LEFT JOIN support ON ((affectation.cle_support = support.cle))) WHERE ((affectation.cle_equipe = equipe.cle) AND ((((((((personne.paysorigine = pays.cle) AND (personne.cle = support.cle_personne)) AND (personne.civilite = civilite.cle)) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND (support.cle_employeur = employeur.cle)) AND ((support.debut <= now()) AND ((support.fin >= now()) OR (support.fin IS NULL)))) AND (((((support.cle_grade = 25) OR (support.cle_grade = 51)) OR (support.cle_grade = 52)) OR (support.cle_grade = 53)) OR (((((((((((support.cle_grade = 9) OR (support.cle_grade = 10)) OR (support.cle_grade = 11)) OR (support.cle_grade = 12)) OR (support.cle_grade = 20)) OR (support.cle_grade = 21)) OR (support.cle_grade = 22)) OR (support.cle_grade = 24)) OR (support.cle_grade = 26)) AND ((affectation.debut <= now()) AND ((affectation.fin >= now()) OR (affectation.fin IS NULL)))) AND ((categorie.categorie)::text = ''PERMANENT''::text))))) GROUP BY personne.cle, civilite.civilite, personne.nom, personne.prenom, personne.datenaissance, pays.nom, grade.grade, employeur.nom, support.debut, support.fin' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect25 [
	self
		parse: 'SELECT personne.cle AS clepersonne, personne.nom, personne.prenom FROM personne, support WHERE ((((personne.cle = support.cle_personne) AND (support.debut <= now())) AND ((support.fin IS NULL) OR (support.fin >= now()))) AND (((NOT (support.cle IN (SELECT affectation.cle_support FROM affectation WHERE ((affectation.fin >= now()) OR (affectation.fin IS NULL))))) OR (support.cle IN (SELECT affectation.cle_support FROM affectation WHERE (affectation.cle_equipe = 0)))) OR (NOT (support.cle IN (SELECT affectation.cle_support FROM affectation)))))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect26 [
	self
		parse: 'SELECT these.fin, "cleNomPrenom_des_membres".nomprenom, p.relname, sujet.titre, equipe.nom AS equipe, lieusoutenance.nom FROM these, soutenance, sujet, "cleNomPrenom_des_membres", equipe, lieusoutenance, pg_class p WHERE (((((((these.tableoid = p.oid) AND (soutenance.cle_diplome = these.cle)) AND (these.cle_sujet = sujet.cle)) AND (these.cle_equipe = equipe.cle)) AND (these.cle_personne = "cleNomPrenom_des_membres".cle)) AND (soutenance.cle_lieusoutenance = lieusoutenance.cle)) AND ((these.fin IS NOT NULL) AND (these.abandon = false))) UNION SELECT hdr.fin, "cleNomPrenom_des_membres".nomprenom, p.relname, sujet.titre, equipe.nom AS equipe, lieusoutenance.nom FROM hdr, soutenance, sujet, "cleNomPrenom_des_membres", equipe, lieusoutenance, pg_class p WHERE (((((((hdr.tableoid = p.oid) AND (soutenance.cle_diplome = hdr.cle)) AND (hdr.cle_sujet = sujet.cle)) AND (hdr.cle_equipe = equipe.cle)) AND (hdr.cle_personne = "cleNomPrenom_des_membres".cle)) AND (soutenance.cle_lieusoutenance = lieusoutenance.cle)) AND (hdr.fin IS NOT NULL))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect27 [
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom, date_trunc(''day''::text, ((support.debut)::timestamp with time zone - now())) AS delai, support.cle AS clesupport, support.debut FROM personne, support WHERE (((personne.cle = support.cle_personne) AND (((support.debut)::timestamp with time zone - now()) > ''00:00:00''::interval)) AND (((support.debut)::timestamp with time zone - now()) < ''30 days''::interval)) GROUP BY personne.cle, personne.nom, personne.prenom, support.cle, support.debut' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect28 [
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom, date_trunc(''day''::text, (now() - (support.debut)::timestamp with time zone)) AS delai, support.cle AS clesupport, support.debut FROM personne, support WHERE (((personne.cle = support.cle_personne) AND ((now() - (support.debut)::timestamp with time zone) > ''00:00:00''::interval)) AND ((now() - (support.debut)::timestamp with time zone) < ''30 days''::interval)) GROUP BY personne.cle, personne.nom, personne.prenom, support.cle, support.debut' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect29 [
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom, date_trunc(''day''::text, ((support.fin)::timestamp with time zone - now())) AS delai, support.cle AS clesupport FROM personne, vue_support_le_plus_recent, support WHERE ((((support.cle = vue_support_le_plus_recent.clesupport) AND (support.fin IS NOT NULL)) AND (personne.cle = vue_support_le_plus_recent.clepersonne)) AND ((((support.fin)::timestamp with time zone - now()) > ''00:00:00''::interval) AND (((support.fin)::timestamp with time zone - now()) < ''30 days''::interval))) GROUP BY personne.cle, personne.nom, personne.prenom, support.fin, support.cle' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect3 [
	self
		parse: 'SELECT  clepersonne,  datearrivee,  sexe,  nompersonne,  prenompersonne,  datenaissance,  paysorigine,  nomcategorie,  corps,  typedusupport,  numsection,  numcmu,  debutsupport,  finsupport,  agt_genere_liste (equipe_avec_repartition(nomequipe, repartition)) AS nomequipes,  nomemployeur,  nomenseignement,  typefinancement,  financeurs,  reffinancement,  responsablethese  FROM "vue_liste_personnel_affectations"  WHERE  labo_personne(clepersonne,debut::DATE) = labo  AND		est_dans_interval(debut,fin,debutsupport,finsupport)  AND		est_dans_interval(debut,fin,debutaffectation,finaffectation)  GROUP BY  clepersonne,  datearrivee,  sexe,  nompersonne,  prenompersonne,  datenaissance,  paysorigine,  nomcategorie,  corps,  typedusupport,  numsection,  numcmu,  debutsupport,  finsupport,  nomemployeur,  nomenseignement,  typefinancement,  financeurs,  reffinancement,  responsablethese' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect30 [
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom, support.fin, support.cle AS clesupport FROM personne, vue_support_le_plus_recent, support WHERE ((((support.cle = vue_support_le_plus_recent.clesupport) AND (support.fin IS NOT NULL)) AND (personne.cle = vue_support_le_plus_recent.clepersonne)) AND ((((support.fin)::timestamp with time zone - now()) < ''00:00:00''::interval) AND (((support.fin)::timestamp with time zone - now()) > ''-30 days''::interval))) GROUP BY personne.cle, personne.nom, personne.prenom, support.fin, support.cle' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect31 [
	self
		parse: 'SELECT equipe.cle AS cleequipe, equipe.nom AS nomequipe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, domaine_diplome.domaine AS discipline, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) AS directeur FROM (((((these JOIN sujet ON ((sujet.cle = these.cle_sujet))) JOIN domaine_diplome ON ((domaine_diplome.cle = these.cle_domaine))) JOIN equipe ON ((equipe.cle = these.cle_equipe))) JOIN personne ON ((personne.cle = these.cle_personne))) LEFT JOIN vue_responsable_de_theses ON ((vue_responsable_de_theses.cle = these.cle_responsable))) WHERE ((these.fin IS NOT NULL) AND (these.abandon = false)) ORDER BY equipe.nom, personne.nom, personne.prenom, sujet.titre' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect32 [
	self
		parse: 'SELECT these.date_inscription, (these.fin)::date AS datesoutenance, personne.cle AS clepersonne, equipe.cle AS cleequipe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre, domaine_diplome.domaine AS discipline, equipe.nom AS nomequipe, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, (((vue_responsable_de_theses.nom)::text || '' ''::text) || (vue_responsable_de_theses.prenom)::text) AS directeur FROM (((((these RIGHT JOIN personne ON ((these.cle_personne = personne.cle))) RIGHT JOIN domaine_diplome ON ((domaine_diplome.cle = these.cle_domaine))) LEFT JOIN equipe ON ((these.cle_equipe = equipe.cle))) LEFT JOIN sujet ON ((these.cle_sujet = sujet.cle))) LEFT JOIN vue_responsable_de_theses ON ((these.cle_responsable = vue_responsable_de_theses.cle))) WHERE ((these.abandon = false) AND (these.fin IS NOT NULL)) ORDER BY date_part(''year''::text, these.fin), personne.nom, personne.prenom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect33 [
	self
		parse: 'SELECT personne.nom, personne.prenom, grade.grade, typesupport.nature, support.debut, support.fin, typefinancement.type, employeur.nom AS employeur, labo.nom AS laboratoire, categorie.categorie FROM personne, support, typesupport, grade, typefinancement, employeur, categorie, labo WHERE (((((((personne.cle = support.cle_personne) AND (personne.cle_labo = labo.cle)) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_grade = grade.cle)) AND (support.cle_typefinancement = typefinancement.cle)) AND (support.cle_employeur = employeur.cle)) AND (support.cle_categorie = categorie.cle)) ORDER BY personne.nom, personne.prenom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect34 [
	self
		parse: 'SELECT DISTINCT actualite.titrecourt, actualite.titrecourt_en, actualite.titre, actualite.titre_en, actualite.description, actualite.description_en, actualite.marquant, actualite.debut, date_part(''year''::text, actualite.debut) AS annee, actualite.fin, actualite.debutpublication, actualite.cle_categorie, actualite.cle AS id, actualite.intervenant, actualite.lieu, actualite.heure, actualite.heurefin, categorie_actualite.intitule, categorie_actualite.code AS type FROM (actualite LEFT JOIN categorie_actualite ON ((actualite.cle_categorie = categorie_actualite.cle))) WHERE (actualite.debut >= (now() - ''1 day''::interval)) ORDER BY actualite.debut DESC, actualite.cle_categorie' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect35 [
	self
		parse: 'SELECT DISTINCT grade.poids, catgrade.sigle, catgrade.intitule FROM (catgrade LEFT JOIN grade ON (((grade.cle_catgrade)::text = (catgrade.sigle)::text))) ORDER BY grade.poids DESC' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect36 [
	self
		parse: 'SELECT equipe.nom, equipe.siteweb, equipe.nomlong, equipe.nomlong_en, equipe.description, equipe.description_en, personne.nom AS chefnom, personne.prenom AS chefprenom, equipe.cle AS eid FROM ((equipe LEFT JOIN chefequipe ON ((chefequipe.cle_equipe = equipe.cle))) LEFT JOIN personne ON ((personne.cle = chefequipe.cle_personne))) WHERE ((equipe.cle_type_equipe = 2) AND ((equipe.fin <= now()) OR (equipe.fin IS NULL)))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect37 [
	self
		parse: 'SELECT DISTINCT plateforme.cle, plateforme.nom, plateforme.description, plateforme.description_en, plateforme.siteweb, personne.nom AS resp_nom, personne.prenom AS resp_prenom, equipeexterne.nom AS equipe, equipeexterne.cle AS eid, equipeexterne.description AS desc_eq, equipeexterne.description_en AS desc_eq_en FROM (((((plateforme LEFT JOIN personne ON ((plateforme.cle_responsable = personne.cle))) LEFT JOIN r_equpla ON ((r_equpla.cle_plateforme = plateforme.cle))) LEFT JOIN equipe ON ((equipe.cle = r_equpla.cle_equipe))) LEFT JOIN r_equextequ ON ((r_equextequ.cle_equipe_interne = equipe.cle))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE ((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL)) ORDER BY plateforme.nom, equipeexterne.nom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect38 [
	self
		parse: 'SELECT theme.cle, theme.nom, theme.description, theme.nom_en, theme.description_en, theme.cle_responsable, theme.debut, theme.fin, personne.nom AS nom_resp, personne.prenom AS prenom_resp, theme.nomcourt FROM (theme JOIN personne ON ((theme.cle_responsable = personne.cle))) WHERE (theme.debut > ''2014-12-31''::date)' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect39 [
	self
		parse: 'SELECT personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, date(hdr.fin) AS soutenance, date_part(''year''::text, hdr.fin) AS finthese, equipeexterne.cle AS eid, equipeexterne.nom AS equipe, hdr.cle AS id, sujet.resume, sujet.titre_en AS sujet_en, sujet.resume_en FROM (((((hdr LEFT JOIN sujet ON ((sujet.cle = hdr.cle_sujet))) LEFT JOIN personne ON ((personne.cle = hdr.cle_personne))) LEFT JOIN equipe ON ((equipe.cle = hdr.cle_equipe))) LEFT JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((equipe.fin IS NULL) OR (equipe.fin > ''2015-01-01''::date)) AND ((equipeexterne.fin IS NULL) OR (equipeexterne.fin > ''2015-01-01''::date))) ORDER BY hdr.fin DESC' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect4 [
	self
		parse: 'SELECT calcule_age(datenaissance,dateobservation::date)::INTEGER AS age, SUM(est_un_homme(civilite))::INTEGER AS homme, SUM(est_une_femme(civilite))::INTEGER AS femme FROM personne,support WHERE personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL GROUP BY age ORDER BY age' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect40 [
	self
		parse: 'SELECT localisation.cle_personne, localisation.bureau, localisation.etage, localisation.telephone, batiment.nom AS batiment, site.nom AS site, batiment.latitude, batiment.longitude, batiment.cle AS batid FROM ((localisation LEFT JOIN batiment ON ((localisation.cle_batiment = batiment.cle))) LEFT JOIN site ON ((batiment.cle_site = site.cle)))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect41 [
	self
		parse: 'SELECT DISTINCT personne.nom, personne.prenom, date_part(''year''::text, personne.datenaissance) AS naissance, personne.uid, personne.visible, support.fin AS finsupport, support.cle_typesupport AS support, typesupport.nature, equipeexterne.nom AS equipe, equipeexterne.cle AS eid, grade.grade AS grade_libelle, grade.cle AS grade, grade.poids, catgrade.intitule AS intitule_statut, catgrade.sigle AS statut, categorie.categorie, personne.cle, (chefequipe.cle_personne = personne.cle) AS estresp FROM (((((((((personne LEFT JOIN support ON ((support.cle_personne = personne.cle))) LEFT JOIN typesupport ON ((support.cle_typesupport = typesupport.cle))) LEFT JOIN affectation ON ((affectation.cle_support = support.cle))) LEFT JOIN r_equextequ ON ((affectation.cle_equipe = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((r_equextequ.cle_equipe_externe = equipeexterne.cle))) LEFT JOIN chefequipe ON ((chefequipe.cle_equipe = affectation.cle_equipe))) LEFT JOIN grade ON ((grade.cle = support.cle_grade))) LEFT JOIN catgrade ON (((grade.cle_catgrade)::text = (catgrade.sigle)::text))) LEFT JOIN categorie ON ((categorie.cle = support.cle_categorie))) WHERE ((((support.debut <= now()) AND ((support.fin >= now()) OR (support.fin IS NULL))) AND ((affectation.fin >= now()) OR (affectation.fin IS NULL))) AND ((chefequipe.fin >= ''2015-01-01''::date) OR (chefequipe.fin IS NULL))) ORDER BY equipeexterne.nom, grade.poids DESC, catgrade.sigle, personne.nom, personne.prenom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect42 [
	self
		parse: 'SELECT equipe.nomlong, equipe.nomlong_en, r_equextequ.cle_equipe_externe FROM ((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL)) AND ((equipe.fin >= now()) OR (equipe.fin IS NULL)))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect43 [
	self
		parse: 'SELECT DISTINCT plateforme.cle, plateforme.nom, plateforme.description, plateforme.description_en, plateforme.siteweb, personne.nom AS resp_nom, personne.prenom AS resp_prenom FROM (plateforme LEFT JOIN personne ON ((plateforme.cle_responsable = personne.cle)))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect44 [
	self
		parse: 'SELECT DISTINCT publi.titre, publi.halid, typepubli.intitule, typepubli.intitule_en, publi.auteurs, publi.journal, publi.page, publi.fichier, publi.cle_type AS type, date_part(''year''::text, publi.datepubli) AS annee, publi.datepubli FROM (publi LEFT JOIN typepubli ON (((publi.cle_type)::text = (typepubli.type)::text))) WHERE (((((publi.cle_type)::text <> ''THESE''::text) AND ((publi.cle_type)::text <> ''BREVET''::text)) AND ((publi.cle_type)::text <> ''HDR''::text)) AND (publi.datepubli IS NOT NULL)) ORDER BY publi.datepubli DESC, publi.cle_type' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect45 [
	self
		parse: 'SELECT DISTINCT personne.nom, personne.prenom, r_equextequ.cle_equipe_externe FROM (((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN chefequipe ON ((chefequipe.cle_equipe = equipe.cle))) JOIN personne ON ((chefequipe.cle_personne = personne.cle))) WHERE ((chefequipe.fin >= ''2015-01-01''::date) OR (chefequipe.fin IS NULL)) ORDER BY r_equextequ.cle_equipe_externe' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect46 [
	self
		parse: 'SELECT equipe.siteweb, r_equextequ.cle_equipe_externe FROM ((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL)) AND ((equipe.fin >= now()) OR (equipe.fin IS NULL)))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect47 [
	self
		parse: 'SELECT DISTINCT soutenance.cle AS id, soutenance.jury, soutenance.jury_en, diplome.fin, date_part(''year''::text, diplome.fin) AS annee, sujet.titre, sujet.titre_en, sujet.resume, lieusoutenance.nom AS lieu, personne.nom, personne.prenom, pg_class.relname, diplome.cle AS diplome_id FROM (((((soutenance LEFT JOIN diplome ON ((soutenance.cle_diplome = diplome.cle))) LEFT JOIN sujet ON ((diplome.cle_sujet = sujet.cle))) LEFT JOIN lieusoutenance ON ((lieusoutenance.cle = soutenance.cle_lieusoutenance))) LEFT JOIN personne ON ((diplome.cle_personne = personne.cle))) LEFT JOIN pg_class ON ((diplome.tableoid = pg_class.oid))) WHERE ((NOT (personne.nom IS NULL)) AND (diplome.fin >= (now() - ''1 day''::interval))) ORDER BY diplome.fin DESC, personne.nom, sujet.titre' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect48 [
	self
		parse: 'SELECT membres.clepersonne, membres.datearrivee, membres.sexe, membres.nompersonne, membres.prenompersonne, membres.datenaissance, membres.paysorigine, membres.nomcategorie, membres.corps, membres.typedusupport, membres.numsection, membres.numcmu, membres.debutsupport, membres.finsupport, membres.nomequipes, membres.nomemployeur, membres.nomenseignement, membres.typefinancement, membres.financeurs, membres.reffinancement, membres.responsablethese FROM membres(1, (now())::date) membres(clepersonne integer, datearrivee date, sexe character varying, nompersonne character varying, prenompersonne character varying, datenaissance date, paysorigine character varying, nomcategorie character varying, corps character varying, typedusupport character varying, numsection smallint, numcmu smallint, debutsupport date, finsupport date, nomequipes text, nomemployeur character varying, nomenseignement character varying, typefinancement character varying, financeurs text, reffinancement character varying, responsablethese text)' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect49 [
	self
		parse: 'SELECT DISTINCT actualite.titrecourt, actualite.titrecourt_en, actualite.titre, actualite.titre_en, actualite.description, actualite.description_en, actualite.marquant, actualite.debut, date_part(''year''::text, actualite.debut) AS annee, actualite.fin, actualite.debutpublication, actualite.cle_categorie AS type, actualite.cle AS id, actualite.intervenant, actualite.lieu, actualite.heure, actualite.heurefin, categorie_actualite.intitule, categorie_actualite.code, actualite.url, CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END AS datetri FROM (actualite LEFT JOIN categorie_actualite ON ((actualite.cle_categorie = categorie_actualite.cle))) ORDER BY actualite.debut DESC, actualite.cle_categorie' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect5 [
	self
		parse: 'SELECT support.cle, support.debut, support.fin FROM support WHERE support.cle_personne = clepersonne' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect50 [
	self
		parse: 'SELECT DISTINCT soutenance.cle AS id, soutenance.jury, soutenance.jury_en, diplome.fin, date_part(''year''::text, diplome.fin) AS annee, sujet.titre, sujet.titre_en, sujet.resume, lieusoutenance.nom AS lieu, personne.nom, personne.prenom, pg_class.relname, diplome.cle AS diplome_id FROM (((((soutenance LEFT JOIN diplome ON ((soutenance.cle_diplome = diplome.cle))) LEFT JOIN sujet ON ((diplome.cle_sujet = sujet.cle))) LEFT JOIN lieusoutenance ON ((lieusoutenance.cle = soutenance.cle_lieusoutenance))) LEFT JOIN personne ON ((diplome.cle_personne = personne.cle))) LEFT JOIN pg_class ON ((diplome.tableoid = pg_class.oid))) WHERE ((NOT (personne.nom IS NULL)) AND (diplome.fin >= (now() - ''1 day''::interval))) ORDER BY diplome.fin DESC, personne.nom, sujet.titre' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect51 [
	self
		parse: 'SELECT these.cle, personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, sujet.resume, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, equipeexterne.cle AS eid, equipeexterne.nom AS equipe, soutenance.jury, sujet.titre_en AS sujet_en, sujet.resume_en, soutenance.jury_en FROM ((((((these LEFT JOIN sujet ON ((sujet.cle = these.cle_sujet))) LEFT JOIN personne ON ((personne.cle = these.cle_personne))) LEFT JOIN equipe ON ((equipe.cle = these.cle_equipe))) LEFT JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) LEFT JOIN soutenance ON ((soutenance.cle_diplome = these.cle))) WHERE ((equipeexterne.fin >= ''2015-01-01''::date) OR (equipeexterne.fin IS NULL)) ORDER BY personne.nom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect52 [
	self
		parse: 'SELECT personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, equipeexterne.cle AS eid, equipeexterne.nom AS equipe, sujet.titre_en AS sujet_en, sujet.resume_en FROM (((((these LEFT JOIN sujet ON ((sujet.cle = these.cle_sujet))) LEFT JOIN personne ON ((personne.cle = these.cle_personne))) LEFT JOIN equipe ON ((equipe.cle = these.cle_equipe))) LEFT JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((((these.fin IS NULL) OR (these.fin > ''2015-01-01''::date)) AND (these.abandon = false)) AND ((equipe.fin IS NULL) OR (equipe.fin > ''2015-01-01''::date))) AND ((equipeexterne.fin IS NULL) OR (equipeexterne.fin > ''2015-01-01''::date))) ORDER BY personne.nom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect53 [
	self
		parse: 'SELECT these.cle, personne.nom AS nompersonne, personne.prenom AS prenompersonne, sujet.titre AS sujet, date(these.fin) AS soutenance, date_part(''year''::text, these.fin) AS finthese, equipeexterne.cle AS eid, equipeexterne.nom AS equipe, sujet.titre_en AS sujet_en, sujet.resume_en FROM (((((these LEFT JOIN sujet ON ((sujet.cle = these.cle_sujet))) LEFT JOIN personne ON ((personne.cle = these.cle_personne))) LEFT JOIN equipe ON ((equipe.cle = these.cle_equipe))) LEFT JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE ((((these.fin < now()) AND (these.abandon = false)) AND ((equipe.fin IS NULL) OR (equipe.fin > ''2015-01-01''::date))) AND ((equipeexterne.fin IS NULL) OR (equipeexterne.fin > ''2015-01-01''::date))) ORDER BY these.fin DESC' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect54 [
	self
		parse: 'SELECT zoom.cle, zoom.titre, zoom.titre_en, zoom.cle_couleur, zoom.cle_actu, actualite.debut, actualite.heure, actualite.intervenant, actualite.cle_categorie, actualite.titre AS titre_actu, actualite.titre_en AS titre_actu_en, actualite.titrecourt, actualite.titrecourt_en, actualite.heurefin, actualite.description, actualite.description_en, categorie_actualite.code, s_cat_zoom.nom AS type FROM (((zoom LEFT JOIN actualite ON ((zoom.cle_actu = actualite.cle))) LEFT JOIN categorie_actualite ON ((actualite.cle_categorie = categorie_actualite.cle))) LEFT JOIN s_cat_zoom ON ((s_cat_zoom.cle = zoom.cle_cat_zoom)))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect55 [
	self
		parse: 'SELECT DISTINCT equipeexterne.nom, equipeexterne.cle AS eid, equipeexterne.description, equipeexterne.description_en, equipeexterne.fin AS url_smarthal, tableau_agg(DISTINCT equipe.nomlong) AS nomslongs, tableau_agg(DISTINCT equipe.nomlong_en) AS nomslongs_en, tableau_agg(DISTINCT equipe.siteweb) AS sitesweb, tableau_agg(personne.nom) AS resp_nom, tableau_agg(personne.prenom) AS resp_prenom, r_equthe.cle_theme, equipeexterne.debut, equipeexterne.fin, equipe.idhal FROM (((((((equipeexterne LEFT JOIN r_equextequ ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) LEFT JOIN equipe ON ((equipe.cle = r_equextequ.cle_equipe_interne))) LEFT JOIN chefequipe ON ((equipe.cle = chefequipe.cle_equipe))) LEFT JOIN personne ON ((personne.cle = chefequipe.cle_personne))) LEFT JOIN r_equextlab ON ((equipeexterne.cle = r_equextlab.cle_equipeexterne))) LEFT JOIN r_equthe ON ((r_equthe.cle_equipe = equipe.cle))) LEFT JOIN theme ON ((r_equthe.cle_theme = theme.cle))) WHERE (((((((equipeexterne.debut <= now()) OR (equipeexterne.debut IS NULL)) AND ((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL))) AND ((equipe.debut <= now()) OR (equipe.debut IS NULL))) AND ((equipe.fin >= now()) OR (equipe.fin IS NULL))) AND ((theme.fin >= now()) OR (theme.fin IS NULL))) AND ((r_equthe.fin >= now()) OR (r_equthe.fin IS NULL))) GROUP BY equipeexterne.nom, equipeexterne.description, equipeexterne.description_en, equipeexterne.cle, equipeexterne.fin, equipeexterne.url_smarthal, r_equthe.cle_theme, equipe.idhal ORDER BY equipeexterne.nom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect56 [
	self
		parse: 'SELECT personne.cle AS clepersonne, civilite.civilite AS sexe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, personne.datenaissance, grade.grade AS corps, chemin_photo((personne.photo)::text) AS photo, personne.uid, personne.mailperso, personne.telephoneperso, (SELECT agt_genere_liste_avec_br((equipe.nom)::text) AS agt_genere_liste_avec_br FROM support, affectation, equipe WHERE ((((support.cle_personne = personne.cle) AND (affectation.cle_support = support.cle)) AND (affectation.cle_equipe = equipe.cle)) AND ((affectation.debut <= now()) AND ((affectation.fin >= now()) OR (affectation.fin IS NULL))))) AS nomequipes, (SELECT agt_genere_liste_avec_br(vue_annuaire_localisations_par_membre.emplacement) AS agt_genere_liste_avec_br FROM vue_annuaire_localisations_par_membre WHERE (vue_annuaire_localisations_par_membre.clepersonne = personne.cle)) AS localisations FROM civilite, (((support LEFT JOIN personne ON ((support.cle_personne = personne.cle))) LEFT JOIN grade ON ((support.cle_grade = grade.cle))) LEFT JOIN affectation ON ((affectation.cle_support = support.cle))) WHERE ((personne.civilite = civilite.cle) AND ((support.debut <= now()) AND ((support.fin >= now()) OR (support.fin IS NULL)))) GROUP BY personne.cle, civilite.civilite, personne.prenom, personne.nom, personne.datenaissance, grade.grade, personne.photo, personne.uid ORDER BY personne.nom, personne.prenom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect57 [
	self
		parse: 'SELECT subquery.string, subquery.major, subquery.minor, subquery.revision FROM ( VALUES (''3.1.0''::text,3,1,0)) subquery(string, major, minor, revision)' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect58 [
	self
		parse: 'SELECT "area_delegation".*
        FROM "area_delegation" LEFT JOIN "membership"
        ON "membership"."area_id" = "area_id_p"
        AND "membership"."member_id" = "area_delegation"."truster_id"
        WHERE "area_delegation"."area_id" = "area_id_p"
        AND "area_delegation"."trustee_id" = "member_id_p"
        AND "membership"."member_id" ISNULL' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect6 [
	self
		parse: 'SELECT personne.cle, (((personne.nom)::text || '' ''::text) || (personne.prenom)::text) AS nomprenom FROM personne ORDER BY personne.nom, personne.prenom' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect7 [
	self
		parse: 'SELECT personne.nom AS nompersonne, personne.prenom, affectation.cle_equipe, support.cle_personne, equipe.nom AS nomequipe FROM personne, support, affectation, equipe WHERE ((((equipe.cle = affectation.cle_equipe) AND ((affectation.debut <= now()) AND ((affectation.fin >= now()) OR (affectation.fin IS NULL)))) AND (affectation.cle_support = support.cle)) AND (support.cle_personne = personne.cle))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect8 [
	self
		parse: 'SELECT localisation.cle_personne AS clepersonne, ((((((((((((''<a href="''::text || (genere_url_carto(localisation.cle_batiment, localisation.bureau))::text) || ''" target="_blank">''::text) || (site.nom)::text) || ''<br>''::text) || (batiment.nom)::text) || ''<br>''::text) || (affiche_etage(localisation.etage))::text) || ''Bureau ''::text) || (localisation.bureau)::text) || ''</a><br>''::text) || (localisation.telephone)::text) || ''<br>''::text) AS emplacement FROM localisation, site, batiment WHERE (((localisation.visible = true) AND (localisation.cle_batiment = batiment.cle)) AND (batiment.cle_site = site.cle))' rule: #selectCommand
]

{ #category : #tests }
PSQLGrammarSelectCrashTest >> testSelect9 [
	self
		parse: 'SELECT personne.cle, (((personne.nom)::text || '' ''::text) || (personne.prenom)::text) AS nomprenom FROM personne ORDER BY personne.nom, personne.prenom' rule: #selectCommand
]
