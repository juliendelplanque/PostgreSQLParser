Class {
	#name : #PSQLGrammarPLpgSQLBodyCrashTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLGrammarPLpgSQLBodyCrashTest >> parserClass [
	^ PSQLGrammar
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody1 [
	self
		parse: 'BEGIN IF abandon = true THEN return null; ELSE return fin; END IF; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody10 [
	self
		parse: 'DECLARE nbrjours int4; dateexpiration date;  BEGIN SELECT typesupport.expiration INTO nbrjours FROM typesupport WHERE typesupport.cle = cletypesupport;  IF (datefin IS NOT NULL) AND (nbrjours IS NOT NULL) THEN dateexpiration = datefin + nbrjours; END IF;  RETURN dateexpiration; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody100 [
	self
		parse: 'DECLARE nomcomplet varchar; BEGIN SELECT nomprenom INTO nomcomplet FROM vue_personnes WHERE uid = NEW.uid; NEW.nomprenom := nomcomplet;  return NEW; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody101 [
	self
		parse: 'DECLARE fonction varchar; chef boolean; rgt boolean;  support_personne vue_personnes%ROWTYPE; BEGIN fonction = '''';  SELECT * INTO support_personne FROM vue_personnes WHERE uid = uid_membre; IF (support_personne.cle IS NOT NULL) THEN fonction = ''MEMBRE''; IF (support_personne.cle_grade = 8 OR support_personne.cle_grade = 17) THEN fonction = ''DOCT''; ELSE IF (support_personne.cle_categorie = 2) THEN fonction = ''PERM''; END IF; SELECT (COUNT(*) = 1) INTO chef FROM vue_chefs_equipe WHERE uid = uid_membre; IF chef = TRUE THEN fonction = ''CHEF''; END IF; SELECT (COUNT(*) = 1) INTO rgt FROM vue_responsables_gt WHERE uid = uid_membre; if rgt = TRUE THEN fonction = ''RGT''; END IF; END IF; ELSE fonction = ''''; END IF;  return fonction; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody102 [
	self
		parse: 'DECLARE clepersonne INT4; BEGIN SELECT cle INTO clepersonne FROM vue_personnes WHERE uid = uid_membre; IF (clepersonne IS NULL) THEN clepersonne = 0; END IF; RETURN clepersonne; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody103 [
	self
		parse: 'BEGIN UPDATE documents SET filename = nomfichier, date_reception = datereception, cle_equipe = cleequipe, acronyme = acronyme_doc, gestionnaire = estgestionnaire WHERE cle = cledocument;  RETURN TRUE; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody104 [
	self
		parse: 'BEGIN IF OLD.filename <> '''' THEN INSERT INTO journal(cle_campagne,fichier,acronyme_doc,uid,action,gestionnaire,cle_document) VALUES(OLD.cle_campagne,nomfichier(OLD.filename),OLD.acronyme,OLD.uid,''ANNULATION'',OLD.gestionnaire,OLD.cle); END IF; return OLD; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody105 [
	self
		parse: 'BEGIN UPDATE documents SET gestionnaire = estgestionnaire WHERE cle = cledocument;  DELETE FROM documents WHERE cle = cledocument;  RETURN TRUE; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody106 [
	self
		parse: 'BEGIN BEGIN DELETE FROM documents WHERE cle IN ( SELECT d.cle FROM documents as d, campagnes as c WHERE est_un_slot_vide(d.cle) AND	c.cle = d.cle_campagne AND	c.fin < NOW()::DATE ); RETURN true; EXCEPTION WHEN OTHERS THEN RAISE EXCEPTION ''Erreur dans efface_slots_obsoletes()''; RETURN FALSE; END; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody107 [
	self
		parse: 'DECLARE nbr INT := 0; BEGIN SELECT COUNT(*) INTO nbr FROM documents WHERE cle = cledocument AND filename IS NOT NULL AND date_reception IS NOT NULL;  RETURN (nbr = 1); END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody108 [
	self
		parse: 'DECLARE nbr INT := 0; BEGIN SELECT COUNT(*) INTO nbr FROM documents WHERE cle = cledocument AND filename IS NULL AND date_reception IS NULL;  RETURN (nbr = 1); END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody109 [
	self
		parse: 'BEGIN NEW.fin_validite := NOW() + (1 || '' days'')::interval; return NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody11 [
	self
		parse: 'DECLARE nbrsupportscotutelle int := 0; BEGIN SELECT count(support.cle) INTO nbrsupportscotutelle FROM support WHERE support.cle_personne = clepersonne::INT4 AND	support.cle_typesupport = 12 AND est_dans_interval(debutobservation::DATE,finobservation::date,support.debut,support.fin) = TRUE;  return (nbrsupportscotutelle > 0); END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody110 [
	self
		parse: 'DECLARE clegt integer; BEGIN SELECT cle_theme into clegt FROM appsi.r_equthe WHERE r_equthe.cle_equipe = NEW.cle_equipe AND r_equthe.debut <= NOW() AND (r_equthe.fin >= NOW() OR r_equthe.fin IS NULL);  NEW.cle_gt = clegt; return NEW; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody111 [
	self
		parse: 'DECLARE fonction_actuelle varchar; BEGIN SELECT fonction INTO fonction_actuelle FROM fonctions WHERE uid = uid_membre; RETURN fonction_actuelle; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody112 [
	self
		parse: 'DECLARE ret BOOLEAN; nbrdoc INTEGER; clepersonne INTEGER; ajouter BOOLEAN;  campagne campagnes;  crs_campagnes CURSOR (uid VARCHAR) FOR SELECT cle,acronyme FROM campagnes WHERE cle_type_campagne IN (SELECT cle_type_campagne FROM acces WHERE categorie = fonction(uid)) AND	(debut <= NOW()::DATE AND fin >= NOW()::DATE);   BEGIN clepersonne = cle_personne(uid_membre);  OPEN crs_campagnes(uid_membre); LOOP FETCH crs_campagnes into campagne.cle,campagne.acronyme; EXIT WHEN NOT FOUND;  ajouter := TRUE; IF (campagne.acronyme IS NOT NULL) THEN SELECT COUNT(*) INTO nbrdoc FROM documents WHERE documents.cle_campagne = campagne.cle AND cle_personne = clepersonne AND documents.acronyme = campagne.acronyme; IF (nbrdoc > 0) THEN ajouter := FALSE; END IF; ELSE SELECT COUNT(*) INTO nbrdoc FROM documents WHERE documents.cle_campagne = campagne.cle AND cle_personne = clepersonne AND est_un_slot_vide(documents.cle); IF (nbrdoc > 0) THEN ajouter := FALSE; END IF; END IF;  IF (ajouter = TRUE) THEN INSERT INTO documents( cle_campagne, cle_personne, acronyme, acronyme_campagne, uid ) VALUES( campagne.cle, clepersonne, campagne.acronyme, (campagne.acronyme IS NOT NULL), uid_membre ); END IF; END LOOP; CLOSE crs_campagnes;  RETURN TRUE; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody113 [
	self
		parse: 'BEGIN BEGIN DELETE FROM fonctions WHERE uid NOT IN (SELECT uid FROM vue_personnes); RETURN TRUE; EXCEPTION WHEN OTHERS THEN RAISE EXCEPTION ''Erreur dans nettoyage_fonctions()''; RETURN FALSE; END; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody114 [
	self
		parse: 'DECLARE items VARCHAR ARRAY; len INT2; BEGIN SELECT INTO items regexp_split_to_array(filename, ''_''); len := array_length(items, 1); IF (len > 1) THEN RETURN items[len]; ELSE RETURN ''''; END IF; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody115 [
	self
		parse: 'DECLARE valeur VARCHAR := '''';  BEGIN  SELECT configuration.valeur INTO valeur FROM configuration WHERE param = parametre;  RETURN valeur; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody116 [
	self
		parse: 'DECLARE valeur VARCHAR := '''';  BEGIN  SELECT configuration.valeur INTO valeur FROM appsi.configuration WHERE param = parametre;  RETURN valeur; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody117 [
	self
		parse: 'DECLARE fonction_connue varchar; fonction_actuelle varchar; res boolean; chef boolean; rgt boolean; clepersonne integer;  ancienne_fonction fonctions%ROWTYPE; BEGIN fonction_connue = ''AUCUNE''; fonction_actuelle := ''AUCUNE'';  res := nettoyage_fonctions();  SELECT * INTO ancienne_fonction FROM fonctions WHERE uid = uid_utilisateur; IF (ancienne_fonction.cle IS NOT NULL) THEN IF(ancienne_fonction.fin_validite < NOW()::DATE) THEN DELETE FROM fonctions WHERE cle = ancienne_fonction.cle; ELSE fonction_connue = ancienne_fonction.fonction; END IF; END IF;  IF (fonction_connue = ''AUCUNE'') THEN fonction_actuelle = cherche_fonction(uid_utilisateur); END IF;  IF (fonction_actuelle != ''AUCUNE'') THEN IF(fonction_connue != ''AUCUNE'') THEN IF (fonction_connue != fonction_actuelle) THEN DELETE FROM documents WHERE est_un_slot_vide(cle) AND	cle_personne = (SELECT cle FROM vue_personnes WHERE uid = uid_utilisateur);  UPDATE fonctions SET fonction = fonction_actuelle WHERE uid = uid_utilisateur; END IF; ELSE INSERT INTO fonctions(uid,fonction) VALUES (uid_utilisateur,fonction_actuelle); END IF; ELSE IF (fonction_connue != ''AUCUNE'') THEN fonction_actuelle = fonction_connue; END IF; END IF;  RETURN fonction_actuelle; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody12 [
	self
		parse: 'DECLARE debutaff DATE; finaff DATE; duree INT2;  crs_affectation CURSOR (clepersonne INTEGER,cleequipe INTEGER, finperiode DATE ) FOR SELECT affectation.debut AS debutaffectation, affectation.fin AS finaffectation FROM affectation,support,personne WHERE affectation.cle_support = support.cle AND	support.cle_personne = personne.cle AND personne.cle = clepersonne AND	affectation.cle_equipe = cleequipe AND affectation.fin <= finperiode ORDER BY affectation.debut;  BEGIN duree := 0;  OPEN crs_affectation(clemembre,cleequipe,fin); LOOP IF NOT FOUND THEN EXIT; END IF; FETCH crs_affectation into debutaff,finaff;  IF debutaff IS NOT NULL THEN duree := duree + nbr_mois_sur_une_periode(debut, fin, debutaff, finaff); END IF; END LOOP; CLOSE crs_affectation;  RETURN duree::INT2; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody13 [
	self
		parse: 'DECLARE chaine VARCHAR;  BEGIN chaine := equipe;  IF (repartition IS NOT NULL) THEN IF (repartition > 0) THEN chaine := chaine || '' '' || repartition::TEXT || ''%''; END IF; END IF;  RETURN chaine; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody14 [
	self
		parse: 'BEGIN RETURN ((debut,fin) OVERLAPS (debutinterval,fininterval) OR (fin ISNULL AND (debut <= debutinterval OR (debut >= debutinterval AND debut <= fininterval)))); END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody15 [
	self
		parse: 'BEGIN IF civilite = 1 THEN return 1; ELSE return 0; END IF; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody16 [
	self
		parse: 'BEGIN IF civilite != 1 THEN return 1; ELSE return 0; END IF; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody17 [
	self
		parse: 'DECLARE urlbase VARCHAR := ''''; position RECORD; url VARCHAR := ''''; BEGIN  urlbase := param(''urlcarto'');  IF urlbase <> ''#'' THEN SELECT latitude,longitude INTO position FROM batiment WHERE cle = clebatiment;  url := urlbase || ''lat='' || CAST (position.latitude AS TEXT) || ''&lon='' || CAST(position.longitude  AS TEXT) || ''&room='' || CAST(bureau AS TEXT); ELSE url := urlbase; END IF; RETURN url; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody18 [
	self
		parse: 'BEGIN IF (str1 IS NULL AND str2 IS NULL) THEN RETURN ''''; END IF; IF (str1 IS NULL OR str1 = '''') THEN RETURN str2; END IF; IF (str2 IS NULL OR str2 = '''') THEN RETURN str1; END IF; RETURN (str1 || separator || str2); END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody19 [
	self
		parse: 'DECLARE clelabo int := 0;  BEGIN SELECT cle_labo INTO clelabo FROM r_equlab WHERE cle_equipe = equipe::int4 AND dateobservation::date >= debut AND (dateobservation::date <= fin OR fin IS NULL);  RETURN clelabo; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody2 [
	self
		parse: 'DECLARE chaine VARCHAR; BEGIN chaine := ''''; IF (etage IS NOT NULL) THEN IF (etage = 0) THEN chaine := ''Rez-de-chaussée<br>''; ELSE chaine := ''Etage: '' || etage || ''<br>''; END IF; END IF; RETURN chaine; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody20 [
	self
		parse: 'DECLARE  clelabo int := 0;    BEGIN  SELECT cle_labo INTO clelabo  FROM  r_perlab  WHERE  cle_personne = clepersonne::int4  AND debut <= dateobservation  AND ((fin >= dateobservation) OR (fin IS NULL));    RETURN clelabo;  END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody21 [
	self
		parse: 'DECLARE clelabo int := 0;  BEGIN SELECT cle_labo INTO clelabo FROM personne WHERE cle = clepersonne::int4;  RETURN clelabo; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody22 [
	self
		parse: 'DECLARE clemembre int := 0;  BEGIN IF clepersonne IS NOT NULL THEN SELECT count(cle_personne) INTO clemembre FROM listehdr WHERE cle_personne = clepersonne::INT4 AND (dateobtention <= debut::DATE OR (dateobtention >= debut::DATE AND dateobtention <= fin::DATE));  IF clemembre > 0 THEN return true; END IF; END IF;  return false;  END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody23 [
	self
		parse: 'DECLARE  BEGIN RETURN QUERY SELECT * FROM membres(labo,dateobservation::DATE,dateobservation::DATE) AS ( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT ); END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody24 [
	self
		parse: 'DECLARE  res RECORD;    BEGIN    RETURN QUERY SELECT  clepersonne,  datearrivee,  sexe,  nompersonne,  prenompersonne,  datenaissance,  paysorigine,  nomcategorie,  corps,  typedusupport,  numsection,  numcmu,  debutsupport,  finsupport,  agt_genere_liste (equipe_avec_repartition(nomequipe, repartition)) AS nomequipes,  nomemployeur,  nomenseignement,  typefinancement,  financeurs,  reffinancement,  responsablethese  FROM "vue_liste_personnel_affectations"  WHERE  labo_personne(clepersonne,debut::DATE) = labo  AND		est_dans_interval(debut,fin,debutsupport,finsupport)  AND		est_dans_interval(debut,fin,debutaffectation,finaffectation)  GROUP BY  clepersonne,  datearrivee,  sexe,  nompersonne,  prenompersonne,  datenaissance,  paysorigine,  nomcategorie,  corps,  typedusupport,  numsection,  numcmu,  debutsupport,  finsupport,  nomemployeur,  nomenseignement,  typefinancement,  financeurs,  reffinancement,  responsablethese;  END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody25 [
	self
		parse: 'BEGIN return nbr_mois_sur_une_periode(debut,fin,debut,fin); END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody26 [
	self
		parse: 'DECLARE debutAffectation DATE; finAffectation DATE; estimation REAL; nbrMois INT2;  BEGIN debutAffectation := debut; finAffectation := fin;  IF (finAffectation < debutperiode) OR (debutAffectation > finperiode) THEN return 0; ELSE IF debutAffectation < debutperiode THEN debutAffectation := debutperiode; END IF;  IF (finAffectation ISNULL) OR (finAffectation > finperiode) THEN finAffectation := finperiode; END IF;  estimation := ((finAffectation - debutAffectation) / 30.0);  return ROUND(estimation); END IF; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody27 [
	self
		parse: 'DECLARE valeur VARCHAR := '''';  BEGIN  SELECT configuration.valeur INTO valeur FROM configuration WHERE param = parametre;  RETURN valeur; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody28 [
	self
		parse: 'DECLARE res RECORD;  BEGIN RETURN QUERY SELECT calcule_age(datenaissance,dateobservation::date)::INTEGER AS age, SUM(est_un_homme(civilite))::INTEGER AS homme, SUM(est_une_femme(civilite))::INTEGER AS femme FROM personne,support WHERE personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL GROUP BY age ORDER BY age;  END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody29 [
	self
		parse: 'DECLARE res RECORD;  BEGIN RETURN QUERY SELECT calcule_age(datenaissance,dateobservation::date)::INTEGER AS age, SUM(est_un_homme(civilite))::INTEGER AS homme, SUM(est_une_femme(civilite))::INTEGER AS femme FROM personne,support WHERE personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL AND labo_personne(personne.cle,dateobservation) = clelabo GROUP BY age ORDER BY age;  END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody3 [
	self
		parse: 'DECLARE cleequipe int := 0;  BEGIN SELECT equipe.cle INTO cleequipe FROM personne,affectation,support,equipe WHERE personne.cle = clepersonne::int4 AND	clepersonne::int4 = personne.cle AND	abandon::bool = FALSE AND support.cle_personne = personne.cle AND affectation.cle_support = support.cle AND affectation.cle_equipe = equipe.cle AND (dateobservation::date > affectation.debut AND (dateobservation::date <= affectation.fin OR dateobservation::date <= (affectation.fin + ''1 YEAR''::INTERVAL)));  RETURN cleequipe; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody30 [
	self
		parse: 'DECLARE valeur_quotite int := 0;  BEGIN  SELECT quotite INTO valeur_quotite FROM quotite,personne,support,quotite_support WHERE personne.cle = clepersonne AND	support.cle_personne = personne.cle AND	quotite_support.cle_support = support.cle AND	quotite_support.cle_quotite = quotite.cle AND quotite_support.debut <= dateobservation::DATE AND (quotite_support.fin >= dateobservation::DATE OR quotite_support.fin IS NULL);  RETURN valeur_quotite;  END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody31 [
	self
		parse: 'BEGIN IF civilite = 1 THEN return ''HOMME''; ELSE return''FEMME''; END IF; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody32 [
	self
		parse: 'DECLARE spechar VARCHAR[ ] := ARRAY[''à'',''â'',''é'',''è'',''ê'',''ë'',''ï'',''î'',''ô'',''û'',''ù'',''ç'' ]; lettres VARCHAR[ ] := ARRAY[''a'',''a'',''e'',''e'',''e'',''e'',''i'',''i'',''o'',''u'',''u'',''c'' ]; resultat VARCHAR; nbrspechar INTEGER := 12;  BEGIN IF (str IS NOT NULL) THEN resultat := str; FOR i IN 1..nbrspechar LOOP resultat := regexp_replace(resultat,spechar[i],lettres[i],''g''); END LOOP; END IF; RETURN resultat; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody33 [
	self
		parse: 'BEGIN UPDATE actualite SET datecreation = NOW() WHERE cle = NEW.cle; return NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody34 [
	self
		parse: 'BEGIN NEW.datemodification = NOW(); return NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody35 [
	self
		parse: 'BEGIN INSERT INTO listehdr(cle_personne,dateobtention) VALUES(NEW.cle_personne,NEW.fin); RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody36 [
	self
		parse: 'BEGIN DELETE FROM listehdr WHERE listehdr.cle_personne = OLD.cle_personne; RETURN OLD; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody37 [
	self
		parse: 'BEGIN UPDATE listehdr SET dateobtention = NEW.fin WHERE listehdr.cle_personne = OLD.cle_personne; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody38 [
	self
		parse: 'BEGIN UPDATE inscription SET datecreation = NOW() WHERE cle = NEW.cle; return NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody39 [
	self
		parse: 'BEGIN UPDATE diplome SET fin = NULL WHERE cle = OLD.cle_diplome; RETURN OLD; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody4 [
	self
		parse: 'BEGIN return (calcule_duree(datenaissance,dateobservation)); END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody40 [
	self
		parse: 'BEGIN IF NEW.cle_equipe IS NULL THEN NEW.cle_equipe := appartenance_these_equipe(NEW.cle_personne,DATE(NEW.fin),NEW.abandon); END IF; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody41 [
	self
		parse: 'BEGIN UPDATE personne SET datecreation = NOW() WHERE cle = NEW.cle; return NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody42 [
	self
		parse: 'DECLARE ret bool;  BEGIN IF valide_dates_support(NEW.cle,NEW.cle_personne,NEW.debut,NEW.fin) = false THEN RAISE EXCEPTION ''Les dates de début et de fin de ce support sont en conflit avec un support existant.''; END IF; NEW.datecreation = NOW(); NEW.datemodification = NOW(); RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody43 [
	self
		parse: 'BEGIN IF NEW.fin NOTNULL THEN UPDATE affectation SET fin = NEW.fin WHERE affectation.cle_support = NEW.cle AND affectation.fin IS NULL; END IF; return NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody44 [
	self
		parse: 'BEGIN IF valide_dates_support(NEW.cle,NEW.cle_personne,NEW.debut,NEW.fin) = false THEN RAISE EXCEPTION ''Les dates de début et de fin de ce support sont en conflit avec un support existant.''; END IF; NEW.datemodification = NOW(); RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody45 [
	self
		parse: 'DECLARE taux float4 := 1;  BEGIN IF doctorant_en_cotutelle(clepersonne,debutobservation,finobservation) THEN taux := 0.5; ELSE IF membre_avec_hdr(clecoencadrant,debutobservation,finobservation) THEN taux := 0.5; END IF; END IF; return taux; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody46 [
	self
		parse: 'DECLARE uidpersonne varchar := '''';  BEGIN SELECT uid INTO uidpersonne FROM personne WHERE clepersonne = cle;  RETURN uidpersonne; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody47 [
	self
		parse: 'DECLARE clesup INT4; debutsup DATE; finsup DATE; conflit BOOL;  crs_supports CURSOR FOR SELECT support.cle, support.debut, support.fin FROM support WHERE support.cle_personne = clepersonne;  BEGIN conflit := false;  OPEN crs_supports;  FETCH crs_supports INTO clesup,debutsup,finsup; WHILE FOUND LOOP IF finsup IS NULL THEN finsup := ''2099-1-1''::DATE; END IF;  IF est_dans_interval(debutsup,finsup,debut,fin) AND clesup <> clesupport THEN conflit := true; END IF; FETCH crs_supports INTO clesup,debutsup,finsup; END LOOP;  CLOSE crs_supports;  RETURN NOT conflit; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody48 [
	self
		parse: 'DECLARE "member_id_v" "member"."id"%TYPE; BEGIN PERFORM "require_transaction_isolation"(); FOR "member_id_v" IN SELECT "member_id" FROM "direct_voter" WHERE "issue_id" = "issue_id_p" LOOP UPDATE "direct_voter" SET "weight" = "weight" + "weight_of_added_vote_delegations"( "issue_id_p", "member_id_v", ''{}'' ) WHERE "member_id" = "member_id_v" AND "issue_id" = "issue_id_p"; END LOOP; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody49 [
	self
		parse: 'BEGIN IF NOT EXISTS ( SELECT NULL FROM "initiative" JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id" WHERE "initiative"."id" = NEW."initiative_id" AND "interest"."member_id" = NEW."member_id" ) THEN BEGIN INSERT INTO "interest" ("issue_id", "member_id") SELECT "issue_id", NEW."member_id" FROM "initiative" WHERE "id" = NEW."initiative_id"; EXCEPTION WHEN unique_violation THEN END; END IF; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody5 [
	self
		parse: 'BEGIN return calcule_duree(datenaissance,now()::date); END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody50 [
	self
		parse: 'BEGIN IF NOT EXISTS ( SELECT NULL FROM "suggestion" JOIN "supporter" ON "suggestion"."initiative_id" = "supporter"."initiative_id" WHERE "suggestion"."id" = NEW."suggestion_id" AND "supporter"."member_id" = NEW."member_id" ) THEN BEGIN INSERT INTO "supporter" ("initiative_id", "member_id") SELECT "initiative_id", NEW."member_id" FROM "suggestion" WHERE "id" = NEW."suggestion_id"; EXCEPTION WHEN unique_violation THEN END; END IF; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody51 [
	self
		parse: 'BEGIN IF NEW."initiative_id" ISNULL THEN SELECT "initiative_id" INTO NEW."initiative_id" FROM "suggestion" WHERE "id" = NEW."suggestion_id"; END IF; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody52 [
	self
		parse: 'BEGIN IF NEW."issue_id" ISNULL THEN SELECT "issue_id" INTO NEW."issue_id" FROM "initiative" WHERE "id" = NEW."initiative_id"; END IF; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody53 [
	self
		parse: 'BEGIN PERFORM "require_transaction_isolation"(); DELETE FROM "member_count"; INSERT INTO "member_count" ("total_count") SELECT "total_count" FROM "member_count_view"; UPDATE "unit" SET "member_count" = "view"."member_count" FROM "unit_member_count" AS "view" WHERE "view"."unit_id" = "unit"."id"; UPDATE "area" SET "direct_member_count" = "view"."direct_member_count", "member_weight"       = "view"."member_weight" FROM "area_member_count" AS "view" WHERE "view"."area_id" = "area"."id"; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody54 [
	self
		parse: 'DECLARE "issue_row"       "issue"%ROWTYPE; "policy_row"      "policy"%ROWTYPE; "dimension_v"     INT4; "matrix_a"        INT4[][]; "matrix_d"        "link_strength"[][]; "matrix_p"        "link_strength"[][]; "matrix_t"        "link_strength"[][]; "matrix_f"        BOOLEAN[][]; "matrix_b"        BOOLEAN[][]; "i"               INT4; "j"               INT4; "m"               INT4; "n"               INT4; "battle_row"      "battle"%ROWTYPE; "rank_ary"        INT4[]; "rank_v"          INT4; "initiative_id_v" "initiative"."id"%TYPE; BEGIN PERFORM "require_transaction_isolation"(); SELECT * INTO "issue_row" FROM "issue" WHERE "id" = "issue_id_p"; SELECT * INTO "policy_row" FROM "policy" WHERE "id" = "issue_row"."policy_id"; SELECT count(1) INTO "dimension_v" FROM "battle_participant" WHERE "issue_id" = "issue_id_p"; "matrix_a" := array_fill(NULL::INT4, ARRAY["dimension_v", "dimension_v"]); "i" := 1; "j" := 2; FOR "battle_row" IN SELECT * FROM "battle" WHERE "issue_id" = "issue_id_p" ORDER BY "winning_initiative_id" NULLS FIRST, "losing_initiative_id" NULLS FIRST LOOP "matrix_a"["i"]["j"] := "battle_row"."count"; IF "j" = "dimension_v" THEN "i" := "i" + 1; "j" := 1; ELSE "j" := "j" + 1; IF "j" = "i" THEN "j" := "j" + 1; END IF; END IF; END LOOP; IF "i" != "dimension_v" OR "j" != "dimension_v" + 1 THEN RAISE EXCEPTION ''Wrong battle count (should not happen)''; END IF; "matrix_d" := array_fill(NULL::INT8, ARRAY["dimension_v", "dimension_v"]); "i" := 1; LOOP "j" := 1; LOOP IF "i" != "j" THEN "matrix_d"["i"]["j"] := ( "defeat_strength"( "matrix_a"["i"]["j"], "matrix_a"["j"]["i"], "policy_row"."defeat_strength" ), "secondary_link_strength"( "i", "j", "policy_row"."tie_breaking" ) )::"link_strength"; END IF; EXIT WHEN "j" = "dimension_v"; "j" := "j" + 1; END LOOP; EXIT WHEN "i" = "dimension_v"; "i" := "i" + 1; END LOOP; "matrix_p" := "find_best_paths"("matrix_d"); "matrix_b" := array_fill(NULL::BOOLEAN, ARRAY["dimension_v", "dimension_v"]); "i" := 1; LOOP "j" := "i" + 1; LOOP IF "i" != "j" THEN IF "matrix_p"["i"]["j"] > "matrix_p"["j"]["i"] THEN "matrix_b"["i"]["j"] := TRUE; "matrix_b"["j"]["i"] := FALSE; ELSIF "matrix_p"["i"]["j"] < "matrix_p"["j"]["i"] THEN "matrix_b"["i"]["j"] := FALSE; "matrix_b"["j"]["i"] := TRUE; END IF; END IF; EXIT WHEN "j" = "dimension_v"; "j" := "j" + 1; END LOOP; EXIT WHEN "i" = "dimension_v" - 1; "i" := "i" + 1; END LOOP; IF "policy_row"."tie_breaking" != ''simple''::"tie_breaking" THEN "m" := 1; LOOP "n" := "m" + 1; LOOP IF "matrix_b"["m"]["n"] ISNULL THEN "matrix_t" := "matrix_p"; "matrix_f" := array_fill(FALSE, ARRAY["dimension_v", "dimension_v"]); LOOP "i" := 1; <<forbid_one_link>> LOOP "j" := 1; LOOP IF "i" != "j" THEN IF "matrix_d"["i"]["j"] = "matrix_t"["m"]["n"] THEN "matrix_f"["i"]["j"] := TRUE; EXIT forbid_one_link; END IF; END IF; EXIT WHEN "j" = "dimension_v"; "j" := "j" + 1; END LOOP; IF "i" = "dimension_v" THEN RAISE EXCEPTION ''Did not find shared weakest link for tie-breaking (should not happen)''; END IF; "i" := "i" + 1; END LOOP; "i" := 1; LOOP "j" := 1; LOOP IF "i" != "j" THEN "matrix_t"["i"]["j"] := CASE WHEN "matrix_f"["i"]["j"] THEN ((-1::INT8) << 63, 0)::"link_strength" ELSE "matrix_d"["i"]["j"] END; END IF; EXIT WHEN "j" = "dimension_v"; "j" := "j" + 1; END LOOP; EXIT WHEN "i" = "dimension_v"; "i" := "i" + 1; END LOOP; "matrix_t" := "find_best_paths"("matrix_t"); IF "matrix_t"["m"]["n"] > "matrix_t"["n"]["m"] THEN "matrix_b"["m"]["n"] := TRUE; "matrix_b"["n"]["m"] := FALSE; EXIT; ELSIF "matrix_t"["m"]["n"] < "matrix_t"["n"]["m"] THEN "matrix_b"["m"]["n"] := FALSE; "matrix_b"["n"]["m"] := TRUE; EXIT; END IF; END LOOP; END IF; EXIT WHEN "n" = "dimension_v"; "n" := "n" + 1; END LOOP; EXIT WHEN "m" = "dimension_v" - 1; "m" := "m" + 1; END LOOP; END IF; "rank_ary" := array_fill(NULL::INT4, ARRAY["dimension_v"]); "rank_v" := 1; LOOP "i" := 1; <<assign_next_rank>> LOOP IF "rank_ary"["i"] ISNULL THEN "j" := 1; LOOP IF "i" != "j" AND "rank_ary"["j"] ISNULL AND ( "matrix_b"["j"]["i"] OR ( "matrix_b"["j"]["i"] ISNULL AND "j" < "i" ) ) THEN EXIT; END IF; IF "j" = "dimension_v" THEN "rank_ary"["i"] := "rank_v"; EXIT assign_next_rank; END IF; "j" := "j" + 1; END LOOP; END IF; "i" := "i" + 1; IF "i" > "dimension_v" THEN RAISE EXCEPTION ''Schulze ranking does not compute (should not happen)''; END IF; END LOOP; EXIT WHEN "rank_v" = "dimension_v"; "rank_v" := "rank_v" + 1; END LOOP; "i" := 2; FOR "initiative_id_v" IN SELECT "id" FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "admitted" ORDER BY "id" LOOP UPDATE "initiative" SET "direct_majority" = CASE WHEN "policy_row"."direct_majority_strict" THEN "positive_votes" * "policy_row"."direct_majority_den" > "policy_row"."direct_majority_num" * ("positive_votes"+"negative_votes") ELSE "positive_votes" * "policy_row"."direct_majority_den" >= "policy_row"."direct_majority_num" * ("positive_votes"+"negative_votes") END AND "positive_votes" >= "policy_row"."direct_majority_positive" AND "issue_row"."voter_count"-"negative_votes" >= "policy_row"."direct_majority_non_negative", "indirect_majority" = CASE WHEN "policy_row"."indirect_majority_strict" THEN "positive_votes" * "policy_row"."indirect_majority_den" > "policy_row"."indirect_majority_num" * ("positive_votes"+"negative_votes") ELSE "positive_votes" * "policy_row"."indirect_majority_den" >= "policy_row"."indirect_majority_num" * ("positive_votes"+"negative_votes") END AND "positive_votes" >= "policy_row"."indirect_majority_positive" AND "issue_row"."voter_count"-"negative_votes" >= "policy_row"."indirect_majority_non_negative", "schulze_rank"           = "rank_ary"["i"], "better_than_status_quo" = "rank_ary"["i"] < "rank_ary"[1], "worse_than_status_quo"  = "rank_ary"["i"] > "rank_ary"[1], "multistage_majority"    = "rank_ary"["i"] >= "rank_ary"[1], "reverse_beat_path"      = CASE WHEN "policy_row"."defeat_strength" = ''simple''::"defeat_strength" THEN NULL ELSE "matrix_p"[1]["i"]."primary" >= 0 END, "eligible"               = FALSE, "winner"                 = FALSE, "rank"                   = NULL WHERE "id" = "initiative_id_v"; "i" := "i" + 1; END LOOP; IF "i" != "dimension_v" + 1 THEN RAISE EXCEPTION ''Wrong winner count (should not happen)''; END IF; LOOP UPDATE "initiative" SET "indirect_majority" = TRUE FROM ( SELECT "new_initiative"."id" AS "initiative_id" FROM "initiative" "old_initiative" JOIN "initiative" "new_initiative" ON "new_initiative"."issue_id" = "issue_id_p" AND "new_initiative"."indirect_majority" = FALSE JOIN "battle" "battle_win" ON "battle_win"."issue_id" = "issue_id_p" AND "battle_win"."winning_initiative_id" = "new_initiative"."id" AND "battle_win"."losing_initiative_id" = "old_initiative"."id" JOIN "battle" "battle_lose" ON "battle_lose"."issue_id" = "issue_id_p" AND "battle_lose"."losing_initiative_id" = "new_initiative"."id" AND "battle_lose"."winning_initiative_id" = "old_initiative"."id" WHERE "old_initiative"."issue_id" = "issue_id_p" AND "old_initiative"."indirect_majority" = TRUE AND CASE WHEN "policy_row"."indirect_majority_strict" THEN "battle_win"."count" * "policy_row"."indirect_majority_den" > "policy_row"."indirect_majority_num" * ("battle_win"."count"+"battle_lose"."count") ELSE "battle_win"."count" * "policy_row"."indirect_majority_den" >= "policy_row"."indirect_majority_num" * ("battle_win"."count"+"battle_lose"."count") END AND "battle_win"."count" >= "policy_row"."indirect_majority_positive" AND "issue_row"."voter_count"-"battle_lose"."count" >= "policy_row"."indirect_majority_non_negative" ) AS "subquery" WHERE "id" = "subquery"."initiative_id"; EXIT WHEN NOT FOUND; END LOOP; UPDATE "initiative" SET "multistage_majority" = TRUE FROM ( SELECT "losing_initiative"."id" AS "initiative_id" FROM "initiative" "losing_initiative" JOIN "initiative" "winning_initiative" ON "winning_initiative"."issue_id" = "issue_id_p" AND "winning_initiative"."admitted" JOIN "battle" "battle_win" ON "battle_win"."issue_id" = "issue_id_p" AND "battle_win"."winning_initiative_id" = "winning_initiative"."id" AND "battle_win"."losing_initiative_id" = "losing_initiative"."id" JOIN "battle" "battle_lose" ON "battle_lose"."issue_id" = "issue_id_p" AND "battle_lose"."losing_initiative_id" = "winning_initiative"."id" AND "battle_lose"."winning_initiative_id" = "losing_initiative"."id" WHERE "losing_initiative"."issue_id" = "issue_id_p" AND "losing_initiative"."admitted" AND "winning_initiative"."schulze_rank" < "losing_initiative"."schulze_rank" AND "battle_win"."count" > "battle_lose"."count" AND ( "battle_win"."count" > "winning_initiative"."positive_votes" OR "battle_lose"."count" < "losing_initiative"."negative_votes" ) ) AS "subquery" WHERE "id" = "subquery"."initiative_id"; UPDATE "initiative" SET "eligible" = TRUE WHERE "issue_id" = "issue_id_p" AND "initiative"."direct_majority" AND "initiative"."indirect_majority" AND "initiative"."better_than_status_quo" AND ( "policy_row"."no_multistage_majority" = FALSE OR "initiative"."multistage_majority" = FALSE ) AND ( "policy_row"."no_reverse_beat_path" = FALSE OR coalesce("initiative"."reverse_beat_path", FALSE) = FALSE ); UPDATE "initiative" SET "winner" = TRUE FROM ( SELECT "id" AS "initiative_id" FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "eligible" ORDER BY "schulze_rank", "id" LIMIT 1 ) AS "subquery" WHERE "id" = "subquery"."initiative_id"; "rank_v" := 1; FOR "initiative_id_v" IN SELECT "id" FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "admitted" ORDER BY "winner" DESC, "eligible" DESC, "schulze_rank", "id" LOOP UPDATE "initiative" SET "rank" = "rank_v" WHERE "id" = "initiative_id_v"; "rank_v" := "rank_v" + 1; END LOOP; UPDATE "issue" SET "status_quo_schulze_rank" = "rank_ary"[1], "state" = CASE WHEN EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "winner" ) THEN ''finished_with_winner''::"issue_state" ELSE ''finished_without_winner''::"issue_state" END, "closed" = "phase_finished", "phase_finished" = NULL WHERE "id" = "issue_id_p"; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody55 [
	self
		parse: 'DECLARE "system_setting_row" "system_setting"%ROWTYPE; BEGIN PERFORM "dont_require_transaction_isolation"(); SELECT * INTO "system_setting_row" FROM "system_setting"; IF "system_setting_row"."member_ttl" NOTNULL THEN UPDATE "member" SET "active" = FALSE WHERE "active" = TRUE AND "last_activity" < (now() - "system_setting_row"."member_ttl")::DATE; END IF; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody56 [
	self
		parse: 'DECLARE "issue_id_v" "issue"."id"%TYPE; "persist_v"  "check_issue_persistence"; BEGIN RAISE WARNING ''Function "check_everything" should only be used for development and debugging purposes''; DELETE FROM "expired_session"; PERFORM "check_activity"(); PERFORM "calculate_member_counts"(); FOR "issue_id_v" IN SELECT "id" FROM "open_issue" LOOP "persist_v" := NULL; LOOP "persist_v" := "check_issue"("issue_id_v", "persist_v"); EXIT WHEN "persist_v" ISNULL; END LOOP; END LOOP; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody57 [
	self
		parse: 'DECLARE "issue_row"      "issue"%ROWTYPE; "policy_row"     "policy"%ROWTYPE; "initiative_row" "initiative"%ROWTYPE; "state_v"        "issue_state"; BEGIN PERFORM "require_transaction_isolation"(); IF "persist" ISNULL THEN SELECT * INTO "issue_row" FROM "issue" WHERE "id" = "issue_id_p" FOR UPDATE; IF "issue_row"."closed" NOTNULL THEN RETURN NULL; END IF; "persist"."state" := "issue_row"."state"; IF ( "issue_row"."state" = ''admission'' AND now() >= "issue_row"."created" + "issue_row"."max_admission_time" ) OR ( "issue_row"."state" = ''discussion'' AND now() >= "issue_row"."accepted" + "issue_row"."discussion_time" ) OR ( "issue_row"."state" = ''verification'' AND now() >= "issue_row"."half_frozen" + "issue_row"."verification_time" ) OR ( "issue_row"."state" = ''voting'' AND now() >= "issue_row"."fully_frozen" + "issue_row"."voting_time" ) THEN "persist"."phase_finished" := TRUE; ELSE "persist"."phase_finished" := FALSE; END IF; IF NOT EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "revoked" ISNULL ) AND ( "persist"."state" = ''admission'' OR ( "persist"."state" = ''verification'' AND "persist"."phase_finished" ) OR NOT EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "issue_id_p" AND now() < "revoked" + "issue_row"."verification_time" ) ) THEN "persist"."issue_revoked" := TRUE; ELSE "persist"."issue_revoked" := FALSE; END IF; IF "persist"."phase_finished" OR "persist"."issue_revoked" THEN UPDATE "issue" SET "phase_finished" = now() WHERE "id" = "issue_row"."id"; RETURN "persist"; ELSIF "persist"."state" IN (''admission'', ''discussion'', ''verification'') THEN RETURN "persist"; ELSE RETURN NULL; END IF; END IF; IF "persist"."state" IN (''admission'', ''discussion'', ''verification'') AND coalesce("persist"."snapshot_created", FALSE) = FALSE THEN PERFORM "create_snapshot"("issue_id_p"); "persist"."snapshot_created" = TRUE; IF "persist"."phase_finished" THEN IF "persist"."state" = ''admission'' THEN PERFORM "set_snapshot_event"("issue_id_p", ''end_of_admission''); ELSIF "persist"."state" = ''discussion'' THEN PERFORM "set_snapshot_event"("issue_id_p", ''half_freeze''); ELSIF "persist"."state" = ''verification'' THEN PERFORM "set_snapshot_event"("issue_id_p", ''full_freeze''); SELECT * INTO "issue_row" FROM "issue" WHERE "id" = "issue_id_p"; SELECT * INTO "policy_row" FROM "policy" WHERE "id" = "issue_row"."policy_id"; FOR "initiative_row" IN SELECT * FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "revoked" ISNULL FOR UPDATE LOOP IF "initiative_row"."polling" OR ( "initiative_row"."satisfied_supporter_count" > 0 AND "initiative_row"."satisfied_supporter_count" * "policy_row"."initiative_quorum_den" >= "issue_row"."population" * "policy_row"."initiative_quorum_num" ) THEN UPDATE "initiative" SET "admitted" = TRUE WHERE "id" = "initiative_row"."id"; ELSE UPDATE "initiative" SET "admitted" = FALSE WHERE "id" = "initiative_row"."id"; END IF; END LOOP; END IF; END IF; RETURN "persist"; END IF; IF "persist"."state" IN (''admission'', ''discussion'', ''verification'') AND coalesce("persist"."harmonic_weights_set", FALSE) = FALSE THEN PERFORM "set_harmonic_initiative_weights"("issue_id_p"); "persist"."harmonic_weights_set" = TRUE; IF "persist"."phase_finished" OR "persist"."issue_revoked" OR "persist"."state" = ''admission'' THEN RETURN "persist"; ELSE RETURN NULL; END IF; END IF; IF "persist"."issue_revoked" THEN IF "persist"."state" = ''admission'' THEN "state_v" := ''canceled_revoked_before_accepted''; ELSIF "persist"."state" = ''discussion'' THEN "state_v" := ''canceled_after_revocation_during_discussion''; ELSIF "persist"."state" = ''verification'' THEN "state_v" := ''canceled_after_revocation_during_verification''; END IF; UPDATE "issue" SET "state"          = "state_v", "closed"         = "phase_finished", "phase_finished" = NULL WHERE "id" = "issue_id_p"; RETURN NULL; END IF; IF "persist"."state" = ''admission'' THEN SELECT * INTO "issue_row" FROM "issue" WHERE "id" = "issue_id_p" FOR UPDATE; SELECT * INTO "policy_row" FROM "policy" WHERE "id" = "issue_row"."policy_id"; IF ( now() >= "issue_row"."created" + "issue_row"."min_admission_time" ) AND EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "supporter_count" > 0 AND "supporter_count" * "policy_row"."issue_quorum_den" >= "issue_row"."population" * "policy_row"."issue_quorum_num" ) THEN UPDATE "issue" SET "state"          = ''discussion'', "accepted"       = coalesce("phase_finished", now()), "phase_finished" = NULL WHERE "id" = "issue_id_p"; ELSIF "issue_row"."phase_finished" NOTNULL THEN UPDATE "issue" SET "state"          = ''canceled_issue_not_accepted'', "closed"         = "phase_finished", "phase_finished" = NULL WHERE "id" = "issue_id_p"; END IF; RETURN NULL; END IF; IF "persist"."phase_finished" THEN IF "persist"."state" = ''discussion'' THEN UPDATE "issue" SET "state"          = ''verification'', "half_frozen"    = "phase_finished", "phase_finished" = NULL WHERE "id" = "issue_id_p"; RETURN NULL; END IF; IF "persist"."state" = ''verification'' THEN SELECT * INTO "issue_row" FROM "issue" WHERE "id" = "issue_id_p" FOR UPDATE; SELECT * INTO "policy_row" FROM "policy" WHERE "id" = "issue_row"."policy_id"; IF EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "admitted" = TRUE ) THEN UPDATE "issue" SET "state"          = ''voting'', "fully_frozen"   = "phase_finished", "phase_finished" = NULL WHERE "id" = "issue_id_p"; ELSE UPDATE "issue" SET "state"          = ''canceled_no_initiative_admitted'', "fully_frozen"   = "phase_finished", "closed"         = "phase_finished", "phase_finished" = NULL WHERE "id" = "issue_id_p"; DELETE FROM "direct_voter"     WHERE "issue_id" = "issue_id_p"; DELETE FROM "delegating_voter" WHERE "issue_id" = "issue_id_p"; DELETE FROM "battle"           WHERE "issue_id" = "issue_id_p"; END IF; RETURN NULL; END IF; IF "persist"."state" = ''voting'' THEN IF coalesce("persist"."closed_voting", FALSE) = FALSE THEN PERFORM "close_voting"("issue_id_p"); "persist"."closed_voting" = TRUE; RETURN "persist"; END IF; PERFORM "calculate_ranks"("issue_id_p"); RETURN NULL; END IF; END IF; RAISE WARNING ''should not happen''; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody58 [
	self
		parse: 'BEGIN IF EXISTS ( SELECT NULL FROM "issue" WHERE "id" = "issue_id_p" AND "cleaned" ISNULL ) THEN INSERT INTO "temporary_transaction_data" ("key", "value") VALUES (''override_protection_triggers'', TRUE::TEXT); DELETE FROM "delegating_voter" WHERE "issue_id" = "issue_id_p"; DELETE FROM "direct_voter" WHERE "issue_id" = "issue_id_p"; DELETE FROM "delegating_interest_snapshot" WHERE "issue_id" = "issue_id_p"; DELETE FROM "direct_interest_snapshot" WHERE "issue_id" = "issue_id_p"; DELETE FROM "delegating_population_snapshot" WHERE "issue_id" = "issue_id_p"; DELETE FROM "direct_population_snapshot" WHERE "issue_id" = "issue_id_p"; DELETE FROM "non_voter" WHERE "issue_id" = "issue_id_p"; DELETE FROM "delegation" WHERE "issue_id" = "issue_id_p"; DELETE FROM "supporter" USING "initiative" WHERE "initiative"."issue_id" = "issue_id_p" AND "supporter"."initiative_id" = "initiative_id"; UPDATE "issue" SET "cleaned" = now() WHERE "id" = "issue_id_p"; DELETE FROM "temporary_transaction_data" WHERE "key" = ''override_protection_triggers''; END IF; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody59 [
	self
		parse: 'DECLARE "area_id_v"   "area"."id"%TYPE; "unit_id_v"   "unit"."id"%TYPE; "member_id_v" "member"."id"%TYPE; BEGIN PERFORM "require_transaction_isolation"(); SELECT "area_id" INTO "area_id_v" FROM "issue" WHERE "id" = "issue_id_p"; SELECT "unit_id" INTO "unit_id_v" FROM "area"  WHERE "id" = "area_id_v"; INSERT INTO "temporary_transaction_data" ("key", "value") VALUES (''override_protection_triggers'', TRUE::TEXT); UPDATE "direct_voter" SET "comment_changed" = NULL WHERE "issue_id" = "issue_id_p"; DELETE FROM "delegating_voter" WHERE "issue_id" = "issue_id_p"; DELETE FROM "direct_voter" USING ( SELECT "direct_voter"."member_id" FROM "direct_voter" JOIN "member" ON "direct_voter"."member_id" = "member"."id" LEFT JOIN "privilege" ON "privilege"."unit_id" = "unit_id_v" AND "privilege"."member_id" = "direct_voter"."member_id" WHERE "direct_voter"."issue_id" = "issue_id_p" AND ( "member"."active" = FALSE OR "privilege"."voting_right" ISNULL OR "privilege"."voting_right" = FALSE ) ) AS "subquery" WHERE "direct_voter"."issue_id" = "issue_id_p" AND "direct_voter"."member_id" = "subquery"."member_id"; UPDATE "direct_voter" SET "weight" = 1 WHERE "issue_id" = "issue_id_p"; PERFORM "add_vote_delegations"("issue_id_p"); UPDATE "vote" SET "first_preference" = "subquery"."first_preference" FROM ( SELECT "vote"."initiative_id", "vote"."member_id", CASE WHEN "vote"."grade" > 0 THEN CASE WHEN "vote"."grade" = max("agg"."grade") THEN TRUE ELSE FALSE END ELSE NULL END AS "first_preference" FROM "vote" JOIN "initiative" ON "vote"."issue_id" = "initiative"."issue_id" JOIN "vote" AS "agg" ON "initiative"."id" = "agg"."initiative_id" AND "vote"."member_id" = "agg"."member_id" GROUP BY "vote"."initiative_id", "vote"."member_id", "vote"."grade" ) AS "subquery" WHERE "vote"."issue_id" = "issue_id_p" AND "vote"."initiative_id" = "subquery"."initiative_id" AND "vote"."member_id" = "subquery"."member_id"; DELETE FROM "temporary_transaction_data" WHERE "key" = ''override_protection_triggers''; DELETE FROM "battle" WHERE "issue_id" = "issue_id_p"; INSERT INTO "battle" ( "issue_id", "winning_initiative_id", "losing_initiative_id", "count" ) SELECT "issue_id", "winning_initiative_id", "losing_initiative_id", "count" FROM "battle_view" WHERE "issue_id" = "issue_id_p"; UPDATE "issue" SET "voter_count" = ( SELECT coalesce(sum("weight"), 0) FROM "direct_voter" WHERE "issue_id" = "issue_id_p" ) WHERE "id" = "issue_id_p"; UPDATE "initiative" SET "first_preference_votes" = 0, "positive_votes" = "battle_win"."count", "negative_votes" = "battle_lose"."count" FROM "battle" AS "battle_win", "battle" AS "battle_lose" WHERE "battle_win"."issue_id" = "issue_id_p" AND "battle_win"."winning_initiative_id" = "initiative"."id" AND "battle_win"."losing_initiative_id" ISNULL AND "battle_lose"."issue_id" = "issue_id_p" AND "battle_lose"."losing_initiative_id" = "initiative"."id" AND "battle_lose"."winning_initiative_id" ISNULL; UPDATE "initiative" SET "first_preference_votes" = "subquery"."sum" FROM ( SELECT "vote"."initiative_id", sum("direct_voter"."weight") FROM "vote" JOIN "direct_voter" ON "vote"."issue_id" = "direct_voter"."issue_id" AND "vote"."member_id" = "direct_voter"."member_id" WHERE "vote"."first_preference" GROUP BY "vote"."initiative_id" ) AS "subquery" WHERE "initiative"."issue_id" = "issue_id_p" AND "initiative"."admitted" AND "initiative"."id" = "subquery"."initiative_id"; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody6 [
	self "Fails because of EXTRACT(...)"
		parse: 'DECLARE jour INTEGER; mois INTEGER; annee INTEGER; jour_now INTEGER; mois_now INTEGER; annee_now INTEGER; BEGIN jour := EXTRACT(DAY FROM origine); mois := EXTRACT(MONTH FROM origine); annee := EXTRACT(YEAR FROM origine);  jour_now := EXTRACT(DAY FROM dateobservation); mois_now := EXTRACT(MONTH FROM dateobservation); annee_now := EXTRACT(YEAR FROM dateobservation);  annee := annee_now - annee; if mois_now <= mois THEN IF mois = mois_now THEN IF jour > jour_now THEN annee := annee - 1; END IF; ELSE annee := annee - 1; END IF; END IF;  return annee; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody60 [
	self
		parse: 'DECLARE "policy_row" "policy"%ROWTYPE; BEGIN SELECT * INTO "policy_row" FROM "policy" WHERE "id" = NEW."policy_id"; IF NEW."min_admission_time" ISNULL THEN NEW."min_admission_time" := "policy_row"."min_admission_time"; END IF; IF NEW."max_admission_time" ISNULL THEN NEW."max_admission_time" := "policy_row"."max_admission_time"; END IF; IF NEW."discussion_time" ISNULL THEN NEW."discussion_time" := "policy_row"."discussion_time"; END IF; IF NEW."verification_time" ISNULL THEN NEW."verification_time" := "policy_row"."verification_time"; END IF; IF NEW."voting_time" ISNULL THEN NEW."voting_time" := "policy_row"."voting_time"; END IF; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody61 [
	self
		parse: 'DECLARE "member_id_v" "member"."id"%TYPE; BEGIN PERFORM "require_transaction_isolation"(); DELETE FROM "direct_interest_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic''; DELETE FROM "delegating_interest_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic''; DELETE FROM "direct_supporter_snapshot" USING "initiative" WHERE "initiative"."issue_id" = "issue_id_p" AND "direct_supporter_snapshot"."initiative_id" = "initiative"."id" AND "direct_supporter_snapshot"."event" = ''periodic''; INSERT INTO "direct_interest_snapshot" ("issue_id", "event", "member_id") SELECT "issue_id_p"  AS "issue_id", ''periodic''    AS "event", "member"."id" AS "member_id" FROM "issue" JOIN "area" ON "issue"."area_id" = "area"."id" JOIN "interest" ON "issue"."id" = "interest"."issue_id" JOIN "member" ON "interest"."member_id" = "member"."id" JOIN "privilege" ON "privilege"."unit_id" = "area"."unit_id" AND "privilege"."member_id" = "member"."id" WHERE "issue"."id" = "issue_id_p" AND "member"."active" AND "privilege"."voting_right"; FOR "member_id_v" IN SELECT "member_id" FROM "direct_interest_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' LOOP UPDATE "direct_interest_snapshot" SET "weight" = 1 + "weight_of_added_delegations_for_interest_snapshot"( "issue_id_p", "member_id_v", ''{}'' ) WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "member_id_v"; END LOOP; INSERT INTO "direct_supporter_snapshot" ( "issue_id", "initiative_id", "event", "member_id", "draft_id", "informed", "satisfied" ) SELECT "issue_id_p"            AS "issue_id", "initiative"."id"       AS "initiative_id", ''periodic''              AS "event", "supporter"."member_id" AS "member_id", "supporter"."draft_id"  AS "draft_id", "supporter"."draft_id" = "current_draft"."id" AS "informed", NOT EXISTS ( SELECT NULL FROM "critical_opinion" WHERE "initiative_id" = "initiative"."id" AND "member_id" = "supporter"."member_id" ) AS "satisfied" FROM "initiative" JOIN "supporter" ON "supporter"."initiative_id" = "initiative"."id" JOIN "current_draft" ON "initiative"."id" = "current_draft"."initiative_id" JOIN "direct_interest_snapshot" ON "supporter"."member_id" = "direct_interest_snapshot"."member_id" AND "initiative"."issue_id" = "direct_interest_snapshot"."issue_id" AND "event" = ''periodic'' WHERE "initiative"."issue_id" = "issue_id_p"; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody62 [
	self
		parse: 'DECLARE "member_id_v" "member"."id"%TYPE; BEGIN PERFORM "require_transaction_isolation"(); DELETE FROM "direct_population_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic''; DELETE FROM "delegating_population_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic''; INSERT INTO "direct_population_snapshot" ("issue_id", "event", "member_id") SELECT "issue_id_p"                 AS "issue_id", ''periodic''::"snapshot_event" AS "event", "member"."id"                AS "member_id" FROM "issue" JOIN "area" ON "issue"."area_id" = "area"."id" JOIN "membership" ON "area"."id" = "membership"."area_id" JOIN "member" ON "membership"."member_id" = "member"."id" JOIN "privilege" ON "privilege"."unit_id" = "area"."unit_id" AND "privilege"."member_id" = "member"."id" WHERE "issue"."id" = "issue_id_p" AND "member"."active" AND "privilege"."voting_right" UNION SELECT "issue_id_p"                 AS "issue_id", ''periodic''::"snapshot_event" AS "event", "member"."id"                AS "member_id" FROM "issue" JOIN "area" ON "issue"."area_id" = "area"."id" JOIN "interest" ON "issue"."id" = "interest"."issue_id" JOIN "member" ON "interest"."member_id" = "member"."id" JOIN "privilege" ON "privilege"."unit_id" = "area"."unit_id" AND "privilege"."member_id" = "member"."id" WHERE "issue"."id" = "issue_id_p" AND "member"."active" AND "privilege"."voting_right"; FOR "member_id_v" IN SELECT "member_id" FROM "direct_population_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' LOOP UPDATE "direct_population_snapshot" SET "weight" = 1 + "weight_of_added_delegations_for_population_snapshot"( "issue_id_p", "member_id_v", ''{}'' ) WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "member_id_v"; END LOOP; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody63 [
	self
		parse: 'DECLARE "initiative_id_v"    "initiative"."id"%TYPE; "suggestion_id_v"    "suggestion"."id"%TYPE; BEGIN PERFORM "require_transaction_isolation"(); PERFORM "create_population_snapshot"("issue_id_p"); PERFORM "create_interest_snapshot"("issue_id_p"); UPDATE "issue" SET "snapshot" = coalesce("phase_finished", now()), "latest_snapshot_event" = ''periodic'', "population" = ( SELECT coalesce(sum("weight"), 0) FROM "direct_population_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' ) WHERE "id" = "issue_id_p"; FOR "initiative_id_v" IN SELECT "id" FROM "initiative" WHERE "issue_id" = "issue_id_p" LOOP UPDATE "initiative" SET "supporter_count" = ( SELECT coalesce(sum("di"."weight"), 0) FROM "direct_interest_snapshot" AS "di" JOIN "direct_supporter_snapshot" AS "ds" ON "di"."member_id" = "ds"."member_id" WHERE "di"."issue_id" = "issue_id_p" AND "di"."event" = ''periodic'' AND "ds"."initiative_id" = "initiative_id_v" AND "ds"."event" = ''periodic'' ), "informed_supporter_count" = ( SELECT coalesce(sum("di"."weight"), 0) FROM "direct_interest_snapshot" AS "di" JOIN "direct_supporter_snapshot" AS "ds" ON "di"."member_id" = "ds"."member_id" WHERE "di"."issue_id" = "issue_id_p" AND "di"."event" = ''periodic'' AND "ds"."initiative_id" = "initiative_id_v" AND "ds"."event" = ''periodic'' AND "ds"."informed" ), "satisfied_supporter_count" = ( SELECT coalesce(sum("di"."weight"), 0) FROM "direct_interest_snapshot" AS "di" JOIN "direct_supporter_snapshot" AS "ds" ON "di"."member_id" = "ds"."member_id" WHERE "di"."issue_id" = "issue_id_p" AND "di"."event" = ''periodic'' AND "ds"."initiative_id" = "initiative_id_v" AND "ds"."event" = ''periodic'' AND "ds"."satisfied" ), "satisfied_informed_supporter_count" = ( SELECT coalesce(sum("di"."weight"), 0) FROM "direct_interest_snapshot" AS "di" JOIN "direct_supporter_snapshot" AS "ds" ON "di"."member_id" = "ds"."member_id" WHERE "di"."issue_id" = "issue_id_p" AND "di"."event" = ''periodic'' AND "ds"."initiative_id" = "initiative_id_v" AND "ds"."event" = ''periodic'' AND "ds"."informed" AND "ds"."satisfied" ) WHERE "id" = "initiative_id_v"; FOR "suggestion_id_v" IN SELECT "id" FROM "suggestion" WHERE "initiative_id" = "initiative_id_v" LOOP UPDATE "suggestion" SET "minus2_unfulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = -2 AND "opinion"."fulfilled" = FALSE ), "minus2_fulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = -2 AND "opinion"."fulfilled" = TRUE ), "minus1_unfulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = -1 AND "opinion"."fulfilled" = FALSE ), "minus1_fulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = -1 AND "opinion"."fulfilled" = TRUE ), "plus1_unfulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = 1 AND "opinion"."fulfilled" = FALSE ), "plus1_fulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = 1 AND "opinion"."fulfilled" = TRUE ), "plus2_unfulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = 2 AND "opinion"."fulfilled" = FALSE ), "plus2_fulfilled_count" = ( SELECT coalesce(sum("snapshot"."weight"), 0) FROM "issue" CROSS JOIN "opinion" JOIN "direct_interest_snapshot" AS "snapshot" ON "snapshot"."issue_id" = "issue"."id" AND "snapshot"."event" = "issue"."latest_snapshot_event" AND "snapshot"."member_id" = "opinion"."member_id" WHERE "issue"."id" = "issue_id_p" AND "opinion"."suggestion_id" = "suggestion_id_v" AND "opinion"."degree" = 2 AND "opinion"."fulfilled" = TRUE ) WHERE "suggestion"."id" = "suggestion_id_v"; END LOOP; END LOOP; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody64 [
	self
		parse: 'BEGIN IF NEW."draft_id" ISNULL THEN SELECT "id" INTO NEW."draft_id" FROM "current_draft" WHERE "initiative_id" = NEW."initiative_id"; END IF; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody65 [
	self
		parse: 'BEGIN IF "defeat_strength_p" = ''simple''::"defeat_strength" THEN IF "positive_votes_p" > "negative_votes_p" THEN RETURN "positive_votes_p"; ELSE RETURN 0; END IF; ELSE IF "positive_votes_p" > "negative_votes_p" THEN RETURN ("positive_votes_p"::INT8 << 31) - "negative_votes_p"::INT8; ELSIF "positive_votes_p" = "negative_votes_p" THEN RETURN 0; ELSE RETURN -1; END IF; END IF; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody66 [
	self
		parse: 'DECLARE "scope_v"            "delegation_scope"; "unit_id_v"          "unit"."id"%TYPE; "area_id_v"          "area"."id"%TYPE; "issue_row"          "issue"%ROWTYPE; "visited_member_ids" INT4[]; "loop_member_id_v"   "member"."id"%TYPE; "output_row"         "delegation_chain_row"; "output_rows"        "delegation_chain_row"[]; "simulate_v"         BOOLEAN; "simulate_here_v"    BOOLEAN; "delegation_row"     "delegation"%ROWTYPE; "row_count"          INT4; "i"                  INT4; "loop_v"             BOOLEAN; BEGIN IF "simulate_trustee_id_p" NOTNULL AND "simulate_default_p" THEN RAISE EXCEPTION ''Both "simulate_trustee_id_p" is set, and "simulate_default_p" is true''; END IF; IF "simulate_trustee_id_p" NOTNULL OR "simulate_default_p" THEN "simulate_v" := TRUE; ELSE "simulate_v" := FALSE; END IF; IF "unit_id_p" NOTNULL AND "area_id_p" ISNULL AND "issue_id_p" ISNULL THEN "scope_v" := ''unit''; "unit_id_v" := "unit_id_p"; ELSIF "unit_id_p" ISNULL AND "area_id_p" NOTNULL AND "issue_id_p" ISNULL THEN "scope_v" := ''area''; "area_id_v" := "area_id_p"; SELECT "unit_id" INTO "unit_id_v" FROM "area" WHERE "id" = "area_id_v"; ELSIF "unit_id_p" ISNULL AND "area_id_p" ISNULL AND "issue_id_p" NOTNULL THEN SELECT INTO "issue_row" * FROM "issue" WHERE "id" = "issue_id_p"; IF "issue_row"."id" ISNULL THEN RETURN; END IF; IF "issue_row"."closed" NOTNULL THEN IF "simulate_v" THEN RAISE EXCEPTION ''Tried to simulate delegation chain for closed issue.''; END IF; FOR "output_row" IN SELECT * FROM "delegation_chain_for_closed_issue"("member_id_p", "issue_id_p") LOOP RETURN NEXT "output_row"; END LOOP; RETURN; END IF; "scope_v" := ''issue''; SELECT "area_id" INTO "area_id_v" FROM "issue" WHERE "id" = "issue_id_p"; SELECT "unit_id" INTO "unit_id_v" FROM "area"  WHERE "id" = "area_id_v"; ELSE RAISE EXCEPTION ''Exactly one of unit_id_p, area_id_p, or issue_id_p must be NOTNULL.''; END IF; "visited_member_ids" := ''{}''; "loop_member_id_v"   := NULL; "output_rows"        := ''{}''; "output_row"."index"         := 0; "output_row"."member_id"     := "member_id_p"; "output_row"."member_valid"  := TRUE; "output_row"."participation" := FALSE; "output_row"."overridden"    := FALSE; "output_row"."disabled_out"  := FALSE; "output_row"."scope_out"     := NULL; LOOP IF "visited_member_ids" @> ARRAY["output_row"."member_id"] THEN "loop_member_id_v" := "output_row"."member_id"; ELSE "visited_member_ids" := "visited_member_ids" || "output_row"."member_id"; END IF; IF "output_row"."participation" ISNULL THEN "output_row"."overridden" := NULL; ELSIF "output_row"."participation" THEN "output_row"."overridden" := TRUE; END IF; "output_row"."scope_in" := "output_row"."scope_out"; "output_row"."member_valid" := EXISTS ( SELECT NULL FROM "member" JOIN "privilege" ON "privilege"."member_id" = "member"."id" AND "privilege"."unit_id" = "unit_id_v" WHERE "id" = "output_row"."member_id" AND "member"."active" AND "privilege"."voting_right" ); "simulate_here_v" := ( "simulate_v" AND "output_row"."member_id" = "member_id_p" ); "delegation_row" := ROW(NULL); IF "output_row"."member_valid" OR "simulate_here_v" THEN IF "scope_v" = ''unit'' THEN IF NOT "simulate_here_v" THEN SELECT * INTO "delegation_row" FROM "delegation" WHERE "truster_id" = "output_row"."member_id" AND "unit_id" = "unit_id_v"; END IF; ELSIF "scope_v" = ''area'' THEN "output_row"."participation" := EXISTS ( SELECT NULL FROM "membership" WHERE "area_id" = "area_id_p" AND "member_id" = "output_row"."member_id" ); IF "simulate_here_v" THEN IF "simulate_trustee_id_p" ISNULL THEN SELECT * INTO "delegation_row" FROM "delegation" WHERE "truster_id" = "output_row"."member_id" AND "unit_id" = "unit_id_v"; END IF; ELSE SELECT * INTO "delegation_row" FROM "delegation" WHERE "truster_id" = "output_row"."member_id" AND ( "unit_id" = "unit_id_v" OR "area_id" = "area_id_v" ) ORDER BY "scope" DESC; END IF; ELSIF "scope_v" = ''issue'' THEN IF "issue_row"."fully_frozen" ISNULL THEN "output_row"."participation" := EXISTS ( SELECT NULL FROM "interest" WHERE "issue_id" = "issue_id_p" AND "member_id" = "output_row"."member_id" ); ELSE IF "output_row"."member_id" = "member_id_p" THEN "output_row"."participation" := EXISTS ( SELECT NULL FROM "direct_voter" WHERE "issue_id" = "issue_id_p" AND "member_id" = "output_row"."member_id" ); ELSE "output_row"."participation" := NULL; END IF; END IF; IF "simulate_here_v" THEN IF "simulate_trustee_id_p" ISNULL THEN SELECT * INTO "delegation_row" FROM "delegation" WHERE "truster_id" = "output_row"."member_id" AND ( "unit_id" = "unit_id_v" OR "area_id" = "area_id_v" ) ORDER BY "scope" DESC; END IF; ELSE SELECT * INTO "delegation_row" FROM "delegation" WHERE "truster_id" = "output_row"."member_id" AND ( "unit_id" = "unit_id_v" OR "area_id" = "area_id_v" OR "issue_id" = "issue_id_p" ) ORDER BY "scope" DESC; END IF; END IF; ELSE "output_row"."participation" := FALSE; END IF; IF "simulate_here_v" AND "simulate_trustee_id_p" NOTNULL THEN "output_row"."scope_out" := "scope_v"; "output_rows" := "output_rows" || "output_row"; "output_row"."member_id" := "simulate_trustee_id_p"; ELSIF "delegation_row"."trustee_id" NOTNULL THEN "output_row"."scope_out" := "delegation_row"."scope"; "output_rows" := "output_rows" || "output_row"; "output_row"."member_id" := "delegation_row"."trustee_id"; ELSIF "delegation_row"."scope" NOTNULL THEN "output_row"."scope_out" := "delegation_row"."scope"; "output_row"."disabled_out" := TRUE; "output_rows" := "output_rows" || "output_row"; EXIT; ELSE "output_row"."scope_out" := NULL; "output_rows" := "output_rows" || "output_row"; EXIT; END IF; EXIT WHEN "loop_member_id_v" NOTNULL; "output_row"."index" := "output_row"."index" + 1; END LOOP; "row_count" := array_upper("output_rows", 1); "i"      := 1; "loop_v" := FALSE; LOOP "output_row" := "output_rows"["i"]; EXIT WHEN "output_row" ISNULL; IF "loop_v" THEN IF "i" + 1 = "row_count" THEN "output_row"."loop" := ''last''; ELSIF "i" = "row_count" THEN "output_row"."loop" := ''repetition''; ELSE "output_row"."loop" := ''intermediate''; END IF; ELSIF "output_row"."member_id" = "loop_member_id_v" THEN "output_row"."loop" := ''first''; "loop_v" := TRUE; END IF; IF "scope_v" = ''unit'' THEN "output_row"."participation" := NULL; END IF; RETURN NEXT "output_row"; "i" := "i" + 1; END LOOP; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody67 [
	self
		parse: 'DECLARE "output_row"           "delegation_chain_row"; "direct_voter_row"     "direct_voter"%ROWTYPE; "delegating_voter_row" "delegating_voter"%ROWTYPE; BEGIN "output_row"."index"         := 0; "output_row"."member_id"     := "member_id_p"; "output_row"."member_valid"  := TRUE; "output_row"."participation" := FALSE; "output_row"."overridden"    := FALSE; "output_row"."disabled_out"  := FALSE; LOOP SELECT INTO "direct_voter_row" * FROM "direct_voter" WHERE "issue_id" = "issue_id_p" AND "member_id" = "output_row"."member_id"; IF "direct_voter_row"."member_id" NOTNULL THEN "output_row"."participation" := TRUE; "output_row"."scope_out"     := NULL; "output_row"."disabled_out"  := NULL; RETURN NEXT "output_row"; RETURN; END IF; SELECT INTO "delegating_voter_row" * FROM "delegating_voter" WHERE "issue_id" = "issue_id_p" AND "member_id" = "output_row"."member_id"; IF "delegating_voter_row"."member_id" ISNULL THEN RETURN; END IF; "output_row"."scope_out" := "delegating_voter_row"."scope"; RETURN NEXT "output_row"; "output_row"."member_id" := "delegating_voter_row"."delegate_member_ids"[1]; "output_row"."scope_in"  := "output_row"."scope_out"; END LOOP; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody68 [
	self
		parse: 'DECLARE "current_row" "delegation_chain_row"; "result"      "delegation_info_type"; BEGIN "result"."own_participation" := FALSE; FOR "current_row" IN SELECT * FROM "delegation_chain"( "member_id_p", "unit_id_p", "area_id_p", "issue_id_p", "simulate_trustee_id_p", "simulate_default_p") LOOP IF "result"."participating_member_id" ISNULL AND "current_row"."participation" THEN "result"."participating_member_id" := "current_row"."member_id"; END IF; IF "current_row"."member_id" = "member_id_p" THEN "result"."own_participation"    := "current_row"."participation"; "result"."own_delegation_scope" := "current_row"."scope_out"; IF "current_row"."loop" = ''first'' THEN "result"."delegation_loop" := ''own''; END IF; ELSIF "current_row"."member_valid" AND ( "current_row"."loop" ISNULL OR "current_row"."loop" != ''repetition'' ) THEN IF "result"."first_trustee_id" ISNULL THEN "result"."first_trustee_id"            := "current_row"."member_id"; "result"."first_trustee_participation" := "current_row"."participation"; "result"."first_trustee_ellipsis"      := FALSE; IF "current_row"."loop" = ''first'' THEN "result"."delegation_loop" := ''first''; END IF; ELSIF "result"."other_trustee_id" ISNULL THEN IF "current_row"."participation" AND NOT "current_row"."overridden" THEN "result"."other_trustee_id"            := "current_row"."member_id"; "result"."other_trustee_participation" := TRUE; "result"."other_trustee_ellipsis"      := FALSE; IF "current_row"."loop" = ''first'' THEN "result"."delegation_loop" := ''other''; END IF; ELSE "result"."first_trustee_ellipsis" := TRUE; IF "current_row"."loop" = ''first'' THEN "result"."delegation_loop" := ''first_ellipsis''; END IF; END IF; ELSE "result"."other_trustee_ellipsis" := TRUE; IF "current_row"."loop" = ''first'' THEN "result"."delegation_loop" := ''other_ellipsis''; END IF; END IF; END IF; END LOOP; RETURN "result"; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody69 [
	self
		parse: 'BEGIN UPDATE "member" SET "last_login"                   = NULL, "last_delegation_check"        = NULL, "login"                        = NULL, "password"                     = NULL, "authority"                    = NULL, "authority_uid"                = NULL, "authority_login"              = NULL, "locked"                       = TRUE, "active"                       = FALSE, "notify_email"                 = NULL, "notify_email_unconfirmed"     = NULL, "notify_email_secret"          = NULL, "notify_email_secret_expiry"   = NULL, "notify_email_lock_expiry"     = NULL, "login_recovery_expiry"        = NULL, "password_reset_secret"        = NULL, "password_reset_secret_expiry" = NULL, "organizational_unit"          = NULL, "internal_posts"               = NULL, "realname"                     = NULL, "birthday"                     = NULL, "address"                      = NULL, "email"                        = NULL, "xmpp_address"                 = NULL, "website"                      = NULL, "phone"                        = NULL, "mobile_phone"                 = NULL, "profession"                   = NULL, "external_memberships"         = NULL, "external_posts"               = NULL, "statement"                    = NULL WHERE "id" = "member_id_p"; -- "text_search_data" is updated by triggers DELETE FROM "setting"            WHERE "member_id" = "member_id_p"; DELETE FROM "setting_map"        WHERE "member_id" = "member_id_p"; DELETE FROM "member_relation_setting" WHERE "member_id" = "member_id_p"; DELETE FROM "member_image"       WHERE "member_id" = "member_id_p"; DELETE FROM "contact"            WHERE "member_id" = "member_id_p"; DELETE FROM "ignored_member"     WHERE "member_id" = "member_id_p"; DELETE FROM "session"            WHERE "member_id" = "member_id_p"; DELETE FROM "area_setting"       WHERE "member_id" = "member_id_p"; DELETE FROM "issue_setting"      WHERE "member_id" = "member_id_p"; DELETE FROM "ignored_initiative" WHERE "member_id" = "member_id_p"; DELETE FROM "initiative_setting" WHERE "member_id" = "member_id_p"; DELETE FROM "suggestion_setting" WHERE "member_id" = "member_id_p"; DELETE FROM "membership"         WHERE "member_id" = "member_id_p"; DELETE FROM "delegation"         WHERE "truster_id" = "member_id_p"; DELETE FROM "non_voter"          WHERE "member_id" = "member_id_p"; DELETE FROM "direct_voter" USING "issue" WHERE "direct_voter"."issue_id" = "issue"."id" AND "issue"."closed" ISNULL AND "member_id" = "member_id_p"; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody7 [
	self
		parse: 'BEGIN if (photo IS NULL) THEN RETURN ''photos/membreSansPhoto.jpg''; ELSE return photo; END IF; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody70 [
	self
		parse: 'BEGIN DELETE FROM "temporary_transaction_data"; DELETE FROM "member" WHERE "activated" ISNULL; UPDATE "member" SET "invite_code"                  = NULL, "invite_code_expiry"           = NULL, "admin_comment"                = NULL, "last_login"                   = NULL, "last_delegation_check"        = NULL, "login"                        = NULL, "password"                     = NULL, "authority"                    = NULL, "authority_uid"                = NULL, "authority_login"              = NULL, "lang"                         = NULL, "notify_email"                 = NULL, "notify_email_unconfirmed"     = NULL, "notify_email_secret"          = NULL, "notify_email_secret_expiry"   = NULL, "notify_email_lock_expiry"     = NULL, "notify_level"                 = NULL, "login_recovery_expiry"        = NULL, "password_reset_secret"        = NULL, "password_reset_secret_expiry" = NULL, "organizational_unit"          = NULL, "internal_posts"               = NULL, "realname"                     = NULL, "birthday"                     = NULL, "address"                      = NULL, "email"                        = NULL, "xmpp_address"                 = NULL, "website"                      = NULL, "phone"                        = NULL, "mobile_phone"                 = NULL, "profession"                   = NULL, "external_memberships"         = NULL, "external_posts"               = NULL, "formatting_engine"            = NULL, "statement"                    = NULL; -- "text_search_data" is updated by triggers DELETE FROM "setting"; DELETE FROM "setting_map"; DELETE FROM "member_relation_setting"; DELETE FROM "member_image"; DELETE FROM "contact"; DELETE FROM "ignored_member"; DELETE FROM "session"; DELETE FROM "area_setting"; DELETE FROM "issue_setting"; DELETE FROM "ignored_initiative"; DELETE FROM "initiative_setting"; DELETE FROM "suggestion_setting"; DELETE FROM "non_voter"; DELETE FROM "direct_voter" USING "issue" WHERE "direct_voter"."issue_id" = "issue"."id" AND "issue"."closed" ISNULL; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody71 [
	self
		parse: 'BEGIN DELETE FROM "non_voter" WHERE "issue_id" = NEW."issue_id" AND "member_id" = NEW."member_id"; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody72 [
	self
		parse: 'BEGIN IF current_setting(''transaction_isolation'') IN (''repeatable read'', ''serializable'') THEN RAISE WARNING ''Unneccessary transaction isolation level: %'', current_setting(''transaction_isolation''); END IF; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody73 [
	self
		parse: 'DECLARE "dimension_v" INT4; "matrix_p"    "link_strength"[][]; "i"           INT4; "j"           INT4; "k"           INT4; BEGIN "dimension_v" := array_upper("matrix_d", 1); "matrix_p" := "matrix_d"; "i" := 1; LOOP "j" := 1; LOOP IF "i" != "j" THEN "k" := 1; LOOP IF "i" != "k" AND "j" != "k" THEN IF "matrix_p"["j"]["i"] < "matrix_p"["i"]["k"] THEN IF "matrix_p"["j"]["i"] > "matrix_p"["j"]["k"] THEN "matrix_p"["j"]["k"] := "matrix_p"["j"]["i"]; END IF; ELSE IF "matrix_p"["i"]["k"] > "matrix_p"["j"]["k"] THEN "matrix_p"["j"]["k"] := "matrix_p"["i"]["k"]; END IF; END IF; END IF; EXIT WHEN "k" = "dimension_v"; "k" := "k" + 1; END LOOP; END IF; EXIT WHEN "j" = "dimension_v"; "j" := "j" + 1; END LOOP; EXIT WHEN "i" = "dimension_v"; "i" := "i" + 1; END LOOP; RETURN "matrix_p"; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody74 [
	self
		parse: 'DECLARE "issue_id_v" "issue"."id"%TYPE; "issue_row"  "issue"%ROWTYPE; BEGIN IF EXISTS ( SELECT NULL FROM "temporary_transaction_data" WHERE "txid" = txid_current() AND "key" = ''override_protection_triggers'' AND "value" = TRUE::TEXT ) THEN RETURN NULL; END IF; IF TG_OP = ''DELETE'' THEN "issue_id_v" := OLD."issue_id"; ELSE "issue_id_v" := NEW."issue_id"; END IF; SELECT INTO "issue_row" * FROM "issue" WHERE "id" = "issue_id_v" FOR SHARE; IF ( "issue_row"."closed" NOTNULL OR ( "issue_row"."state" = ''voting'' AND "issue_row"."phase_finished" NOTNULL ) ) THEN IF TG_RELID = ''direct_voter''::regclass AND TG_OP = ''UPDATE'' THEN IF OLD."issue_id"  = NEW."issue_id"  AND OLD."member_id" = NEW."member_id" AND OLD."weight" = NEW."weight" THEN RETURN NULL;  -- allows changing of voter comment END IF; END IF; RAISE EXCEPTION ''Tried to modify data after voting has been closed.''; END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody75 [
	self
		parse: 'BEGIN RETURN ts_headline( ''pg_catalog.simple'', replace(replace("body_p", e''\\'', e''\\\\''), ''*'', e''\\*''), "text_search_query"("query_text_p"), ''StartSel=* StopSel=* HighlightAll=TRUE'' ); END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody76 [
	self
		parse: 'BEGIN IF NOT EXISTS ( SELECT NULL FROM "draft" WHERE "initiative_id" = NEW."id" ) THEN RAISE EXCEPTION ''Cannot create initiative without an initial draft.''; END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody77 [
	self
		parse: 'BEGIN IF NOT EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = NEW."id" ) THEN --RAISE ''Cannot create issue without an initial initiative.'' USING --  ERRCODE = ''integrity_constraint_violation'', --  HINT    = ''Create issue, initiative, and draft within the same transaction.''; RAISE EXCEPTION ''Cannot create issue without an initial initiative.''; END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody78 [
	self
		parse: 'DECLARE "reference_lost" BOOLEAN; BEGIN IF TG_OP = ''DELETE'' THEN "reference_lost" := TRUE; ELSE "reference_lost" := NEW."initiative_id" != OLD."initiative_id"; END IF; IF "reference_lost" AND NOT EXISTS ( SELECT NULL FROM "draft" WHERE "initiative_id" = OLD."initiative_id" ) THEN DELETE FROM "initiative" WHERE "id" = OLD."initiative_id"; END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody79 [
	self
		parse: 'DECLARE "reference_lost" BOOLEAN; BEGIN IF TG_OP = ''DELETE'' THEN "reference_lost" := TRUE; ELSE "reference_lost" := NEW."issue_id" != OLD."issue_id"; END IF; IF "reference_lost" AND NOT EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = OLD."issue_id" ) THEN DELETE FROM "issue" WHERE "id" = OLD."issue_id"; END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody8 [
	self
		parse: 'DECLARE clepersonne int4;  BEGIN SELECT cle INTO clepersonne FROM personne WHERE uidpersonne = uid;  RETURN clepersonne; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody80 [
	self
		parse: 'DECLARE "reference_lost" BOOLEAN; BEGIN IF TG_OP = ''DELETE'' THEN "reference_lost" := TRUE; ELSE "reference_lost" := NEW."suggestion_id" != OLD."suggestion_id"; END IF; IF "reference_lost" AND NOT EXISTS ( SELECT NULL FROM "opinion" WHERE "suggestion_id" = OLD."suggestion_id" ) THEN DELETE FROM "suggestion" WHERE "id" = OLD."suggestion_id"; END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody81 [
	self
		parse: 'BEGIN RETURN "membership_weight_with_skipping"( "area_id_p", "member_id_p", ARRAY["member_id_p"] ); END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody82 [
	self
		parse: 'DECLARE "sum_v"          INT4; "delegation_row" "area_delegation"%ROWTYPE; BEGIN "sum_v" := 1; FOR "delegation_row" IN SELECT "area_delegation".* FROM "area_delegation" LEFT JOIN "membership" ON "membership"."area_id" = "area_id_p" AND "membership"."member_id" = "area_delegation"."truster_id" WHERE "area_delegation"."area_id" = "area_id_p" AND "area_delegation"."trustee_id" = "member_id_p" AND "membership"."member_id" ISNULL LOOP IF NOT "skip_member_ids_p" @> ARRAY["delegation_row"."truster_id"] THEN "sum_v" := "sum_v" + "membership_weight_with_skipping"( "area_id_p", "delegation_row"."truster_id", "skip_member_ids_p" || "delegation_row"."truster_id" ); END IF; END LOOP; RETURN "sum_v"; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody83 [
	self
		parse: 'BEGIN DELETE FROM "direct_voter" WHERE "issue_id" = NEW."issue_id" AND "member_id" = NEW."member_id"; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody84 [
	self
		parse: 'BEGIN IF current_setting(''transaction_isolation'') NOT IN (''repeatable read'', ''serializable'') THEN RAISE EXCEPTION ''Insufficient transaction isolation level''; END IF; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody85 [
	self
		parse: 'BEGIN IF "initiative1_ord_p" = "initiative2_ord_p" THEN RAISE EXCEPTION ''Identical initiative ids passed to "secondary_link_strength" function (should not happen)''; END IF; RETURN ( CASE WHEN "tie_breaking_p" = ''simple''::"tie_breaking" THEN 0 ELSE CASE WHEN "initiative1_ord_p" < "initiative2_ord_p" THEN 1::INT8 << 62 ELSE 0 END + CASE WHEN "tie_breaking_p" = ''variant2''::"tie_breaking" THEN ("initiative2_ord_p"::INT8 << 31) - "initiative1_ord_p"::INT8 ELSE "initiative2_ord_p"::INT8 - ("initiative1_ord_p"::INT8 << 31) END END ); END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody86 [
	self
		parse: 'DECLARE "weight_row"   "remaining_harmonic_initiative_weight_summands"%ROWTYPE; "i"            INT4; "count_v"      INT4; "summand_v"    FLOAT; "id_ary"       INT4[]; "weight_ary"   FLOAT[]; "min_weight_v" FLOAT; BEGIN PERFORM "require_transaction_isolation"(); UPDATE "initiative" SET "harmonic_weight" = NULL WHERE "issue_id" = "issue_id_p"; LOOP "min_weight_v" := NULL; "i" := 0; "count_v" := 0; FOR "weight_row" IN SELECT * FROM "remaining_harmonic_initiative_weight_summands" WHERE "issue_id" = "issue_id_p" AND ( coalesce("admitted", FALSE) = FALSE OR NOT EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "harmonic_weight" ISNULL AND coalesce("admitted", FALSE) = FALSE ) ) UNION ALL SELECT * FROM "remaining_harmonic_initiative_weight_dummies" WHERE "issue_id" = "issue_id_p" AND ( coalesce("admitted", FALSE) = FALSE OR NOT EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "issue_id_p" AND "harmonic_weight" ISNULL AND coalesce("admitted", FALSE) = FALSE ) ) ORDER BY "initiative_id" DESC, "weight_den" DESC LOOP "summand_v" := "weight_row"."weight_num"::FLOAT / "weight_row"."weight_den"::FLOAT; IF "i" = 0 OR "weight_row"."initiative_id" != "id_ary"["i"] THEN "i" := "i" + 1; "count_v" := "i"; "id_ary"["i"] := "weight_row"."initiative_id"; "weight_ary"["i"] := "summand_v"; ELSE "weight_ary"["i"] := "weight_ary"["i"] + "summand_v"; END IF; END LOOP; EXIT WHEN "count_v" = 0; "i" := 1; LOOP "weight_ary"["i"] := "weight_ary"["i"]::NUMERIC(18,9)::NUMERIC(12,3); IF "min_weight_v" ISNULL OR "weight_ary"["i"] < "min_weight_v" THEN "min_weight_v" := "weight_ary"["i"]; END IF; "i" := "i" + 1; EXIT WHEN "i" > "count_v"; END LOOP; "i" := 1; LOOP IF "weight_ary"["i"] = "min_weight_v" THEN UPDATE "initiative" SET "harmonic_weight" = "min_weight_v" WHERE "id" = "id_ary"["i"]; EXIT; END IF; "i" := "i" + 1; END LOOP; END LOOP; UPDATE "initiative" SET "harmonic_weight" = 0 WHERE "issue_id" = "issue_id_p" AND "harmonic_weight" ISNULL; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody87 [
	self
		parse: 'DECLARE "event_v" "issue"."latest_snapshot_event"%TYPE; BEGIN PERFORM "require_transaction_isolation"(); SELECT "latest_snapshot_event" INTO "event_v" FROM "issue" WHERE "id" = "issue_id_p" FOR UPDATE; UPDATE "issue" SET "latest_snapshot_event" = "event_p" WHERE "id" = "issue_id_p"; UPDATE "direct_population_snapshot" SET "event" = "event_p" WHERE "issue_id" = "issue_id_p" AND "event" = "event_v"; UPDATE "delegating_population_snapshot" SET "event" = "event_p" WHERE "issue_id" = "issue_id_p" AND "event" = "event_v"; UPDATE "direct_interest_snapshot" SET "event" = "event_p" WHERE "issue_id" = "issue_id_p" AND "event" = "event_v"; UPDATE "delegating_interest_snapshot" SET "event" = "event_p" WHERE "issue_id" = "issue_id_p" AND "event" = "event_v"; UPDATE "direct_supporter_snapshot" SET "event" = "event_p" FROM "initiative" WHERE "initiative"."issue_id" = "issue_id_p" AND "direct_supporter_snapshot"."initiative_id" = "initiative"."id" AND "direct_supporter_snapshot"."event" = "event_v"; RETURN; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody88 [
	self
		parse: 'BEGIN IF NOT EXISTS ( SELECT NULL FROM "opinion" WHERE "suggestion_id" = NEW."id" ) THEN RAISE EXCEPTION ''Cannot create a suggestion without an opinion.''; END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody89 [
	self
		parse: 'BEGIN RETURN plainto_tsquery(''pg_catalog.simple'', "query_text_p"); END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody9 [
	self
		parse: 'BEGIN RETURN join(str1,str2,'' / ''); END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody90 [
	self
		parse: 'BEGIN IF NEW."comment" ISNULL THEN NEW."comment_changed" := NULL; NEW."formatting_engine" := NULL; END IF; RETURN NEW; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody91 [
	self
		parse: 'DECLARE "issue_delegation_row"  "issue_delegation"%ROWTYPE; "delegate_member_ids_v" "delegating_interest_snapshot"."delegate_member_ids"%TYPE; "weight_v"              INT4; "sub_weight_v"          INT4; BEGIN PERFORM "require_transaction_isolation"(); "weight_v" := 0; FOR "issue_delegation_row" IN SELECT * FROM "issue_delegation" WHERE "trustee_id" = "member_id_p" AND "issue_id" = "issue_id_p" LOOP IF NOT EXISTS ( SELECT NULL FROM "direct_interest_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "issue_delegation_row"."truster_id" ) AND NOT EXISTS ( SELECT NULL FROM "delegating_interest_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "issue_delegation_row"."truster_id" ) THEN "delegate_member_ids_v" := "member_id_p" || "delegate_member_ids_p"; INSERT INTO "delegating_interest_snapshot" ( "issue_id", "event", "member_id", "scope", "delegate_member_ids" ) VALUES ( "issue_id_p", ''periodic'', "issue_delegation_row"."truster_id", "issue_delegation_row"."scope", "delegate_member_ids_v" ); "sub_weight_v" := 1 + "weight_of_added_delegations_for_interest_snapshot"( "issue_id_p", "issue_delegation_row"."truster_id", "delegate_member_ids_v" ); UPDATE "delegating_interest_snapshot" SET "weight" = "sub_weight_v" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "issue_delegation_row"."truster_id"; "weight_v" := "weight_v" + "sub_weight_v"; END IF; END LOOP; RETURN "weight_v"; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody92 [
	self
		parse: 'DECLARE "issue_delegation_row"  "issue_delegation"%ROWTYPE; "delegate_member_ids_v" "delegating_population_snapshot"."delegate_member_ids"%TYPE; "weight_v"              INT4; "sub_weight_v"          INT4; BEGIN PERFORM "require_transaction_isolation"(); "weight_v" := 0; FOR "issue_delegation_row" IN SELECT * FROM "issue_delegation" WHERE "trustee_id" = "member_id_p" AND "issue_id" = "issue_id_p" LOOP IF NOT EXISTS ( SELECT NULL FROM "direct_population_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "issue_delegation_row"."truster_id" ) AND NOT EXISTS ( SELECT NULL FROM "delegating_population_snapshot" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "issue_delegation_row"."truster_id" ) THEN "delegate_member_ids_v" := "member_id_p" || "delegate_member_ids_p"; INSERT INTO "delegating_population_snapshot" ( "issue_id", "event", "member_id", "scope", "delegate_member_ids" ) VALUES ( "issue_id_p", ''periodic'', "issue_delegation_row"."truster_id", "issue_delegation_row"."scope", "delegate_member_ids_v" ); "sub_weight_v" := 1 + "weight_of_added_delegations_for_population_snapshot"( "issue_id_p", "issue_delegation_row"."truster_id", "delegate_member_ids_v" ); UPDATE "delegating_population_snapshot" SET "weight" = "sub_weight_v" WHERE "issue_id" = "issue_id_p" AND "event" = ''periodic'' AND "member_id" = "issue_delegation_row"."truster_id"; "weight_v" := "weight_v" + "sub_weight_v"; END IF; END LOOP; RETURN "weight_v"; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody93 [
	self
		parse: 'DECLARE "issue_delegation_row"  "issue_delegation"%ROWTYPE; "delegate_member_ids_v" "delegating_voter"."delegate_member_ids"%TYPE; "weight_v"              INT4; "sub_weight_v"          INT4; BEGIN PERFORM "require_transaction_isolation"(); "weight_v" := 0; FOR "issue_delegation_row" IN SELECT * FROM "issue_delegation" WHERE "trustee_id" = "member_id_p" AND "issue_id" = "issue_id_p" LOOP IF NOT EXISTS ( SELECT NULL FROM "direct_voter" WHERE "member_id" = "issue_delegation_row"."truster_id" AND "issue_id" = "issue_id_p" ) AND NOT EXISTS ( SELECT NULL FROM "delegating_voter" WHERE "member_id" = "issue_delegation_row"."truster_id" AND "issue_id" = "issue_id_p" ) THEN "delegate_member_ids_v" := "member_id_p" || "delegate_member_ids_p"; INSERT INTO "delegating_voter" ( "issue_id", "member_id", "scope", "delegate_member_ids" ) VALUES ( "issue_id_p", "issue_delegation_row"."truster_id", "issue_delegation_row"."scope", "delegate_member_ids_v" ); "sub_weight_v" := 1 + "weight_of_added_vote_delegations"( "issue_id_p", "issue_delegation_row"."truster_id", "delegate_member_ids_v" ); UPDATE "delegating_voter" SET "weight" = "sub_weight_v" WHERE "issue_id" = "issue_id_p" AND "member_id" = "issue_delegation_row"."truster_id"; "weight_v" := "weight_v" + "sub_weight_v"; END IF; END LOOP; RETURN "weight_v"; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody94 [
	self
		parse: 'DECLARE "initiative_row" "initiative"%ROWTYPE; "issue_row"      "issue"%ROWTYPE; "event_v"        "event_type"; BEGIN SELECT * INTO "initiative_row" FROM "initiative" WHERE "id" = NEW."initiative_id"; SELECT * INTO "issue_row" FROM "issue" WHERE "id" = "initiative_row"."issue_id"; IF EXISTS ( SELECT NULL FROM "draft" WHERE "initiative_id" = NEW."initiative_id" AND "id" != NEW."id" ) THEN "event_v" := ''new_draft_created''; ELSE IF EXISTS ( SELECT NULL FROM "initiative" WHERE "issue_id" = "initiative_row"."issue_id" AND "id" != "initiative_row"."id" ) THEN "event_v" := ''initiative_created_in_existing_issue''; ELSE "event_v" := ''initiative_created_in_new_issue''; END IF; END IF; INSERT INTO "event" ( "event", "member_id", "issue_id", "state", "initiative_id", "draft_id" ) VALUES ( "event_v", NEW."author_id", "initiative_row"."issue_id", "issue_row"."state", "initiative_row"."id", NEW."id" ); RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody95 [
	self
		parse: 'DECLARE "issue_row"  "issue"%ROWTYPE; "draft_id_v" "draft"."id"%TYPE; BEGIN IF OLD."revoked" ISNULL AND NEW."revoked" NOTNULL THEN SELECT * INTO "issue_row" FROM "issue" WHERE "id" = NEW."issue_id"; SELECT "id" INTO "draft_id_v" FROM "current_draft" WHERE "initiative_id" = NEW."id"; INSERT INTO "event" ( "event", "member_id", "issue_id", "state", "initiative_id", "draft_id" ) VALUES ( ''initiative_revoked'', NEW."revoked_by_member_id", NEW."issue_id", "issue_row"."state", NEW."id", "draft_id_v"); END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody96 [
	self
		parse: 'BEGIN IF NEW."state" != OLD."state" THEN INSERT INTO "event" ("event", "issue_id", "state") VALUES (''issue_state_changed'', NEW."id", NEW."state"); END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody97 [
	self
		parse: 'DECLARE "initiative_row" "initiative"%ROWTYPE; "issue_row"      "issue"%ROWTYPE; BEGIN SELECT * INTO "initiative_row" FROM "initiative" WHERE "id" = NEW."initiative_id"; SELECT * INTO "issue_row" FROM "issue" WHERE "id" = "initiative_row"."issue_id"; INSERT INTO "event" ( "event", "member_id", "issue_id", "state", "initiative_id", "suggestion_id" ) VALUES ( ''suggestion_created'', NEW."author_id", "initiative_row"."issue_id", "issue_row"."state", "initiative_row"."id", NEW."id" ); RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #'as yet unclassified' }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody98 [
	self
		parse: 'BEGIN IF ( NEW."active" != OLD."active" OR NEW."name"   != OLD."name" ) AND OLD."activated" NOTNULL THEN INSERT INTO "member_history" ("member_id", "active", "name") VALUES (NEW."id", OLD."active", OLD."name"); END IF; RETURN NULL; END;' rule: #plpgsqlBody
]

{ #category : #tests }
PSQLGrammarPLpgSQLBodyCrashTest >> testBody99 [
	self
		parse: 'BEGIN IF NEW.filename <> '''' THEN INSERT INTO journal(cle_campagne,fichier,acronyme_doc,uid,action,gestionnaire,cle_document) VALUES(NEW.cle_campagne,nomfichier(NEW.filename),NEW.acronyme,NEW.uid,''DEPOT'',NEW.gestionnaire,NEW.cle); END IF;  return NEW;END;' rule: #plpgsqlBody
]
