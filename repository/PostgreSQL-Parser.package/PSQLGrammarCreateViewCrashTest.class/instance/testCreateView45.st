as yet unclassified
testCreateView45
	self
		parse: 'CREATE VIEW web_responsables_by_equipeexterne AS SELECT DISTINCT personne.nom, personne.prenom, r_equextequ.cle_equipe_externe FROM (((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN chefequipe ON ((chefequipe.cle_equipe = equipe.cle))) JOIN personne ON ((chefequipe.cle_personne = personne.cle))) WHERE ((chefequipe.fin >= ''2015-01-01''::date) OR (chefequipe.fin IS NULL)) ORDER BY r_equextequ.cle_equipe_externe' rule: #createViewCommand