tests
testCreateView4
	self
		parse: 'CREATE VIEW vue_clenomprenom_des_membres AS SELECT personne.cle, (((personne.nom)::text || '' ''::text) || (personne.prenom)::text) AS nomprenom FROM personne ORDER BY personne.nom, personne.prenom' rule: #createViewCommand