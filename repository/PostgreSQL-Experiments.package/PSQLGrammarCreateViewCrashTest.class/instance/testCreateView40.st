as yet unclassified
testCreateView40
	self
		parse: 'CREATE VIEW web_localisations_par_membre AS SELECT localisation.cle_personne, localisation.bureau, localisation.etage, localisation.telephone, batiment.nom AS batiment, site.nom AS site, batiment.latitude, batiment.longitude, batiment.cle AS batid FROM ((localisation LEFT JOIN batiment ON ((localisation.cle_batiment = batiment.cle))) LEFT JOIN site ON ((batiment.cle_site = site.cle)))' rule: #createViewCommand