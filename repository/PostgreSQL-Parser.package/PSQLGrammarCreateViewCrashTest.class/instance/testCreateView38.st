as yet unclassified
testCreateView38
	self
		parse: 'CREATE VIEW web_gt_cristal AS SELECT theme.cle, theme.nom, theme.description, theme.nom_en, theme.description_en, theme.cle_responsable, theme.debut, theme.fin, personne.nom AS nom_resp, personne.prenom AS prenom_resp, theme.nomcourt FROM (theme JOIN personne ON ((theme.cle_responsable = personne.cle))) WHERE (theme.debut > ''2014-12-31''::date)' rule: #createViewCommand