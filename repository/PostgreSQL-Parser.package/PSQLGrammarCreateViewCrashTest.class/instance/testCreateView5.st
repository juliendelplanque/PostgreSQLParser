tests
testCreateView5
	self
		parse: 'CREATE VIEW vue_coencadrant_de_theses AS SELECT personne.cle, personne.nom, personne.prenom FROM personne WHERE (personne.cle IN (SELECT these.cle_coencadrant FROM these))' rule: #createViewCommand