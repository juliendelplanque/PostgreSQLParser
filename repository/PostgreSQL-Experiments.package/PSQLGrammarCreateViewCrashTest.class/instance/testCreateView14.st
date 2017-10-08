as yet unclassified
testCreateView14
	self
		parse: 'CREATE VIEW vue_responsable_de_theses AS SELECT personne.cle, personne.nom, personne.prenom FROM personne WHERE (personne.cle IN (SELECT these.cle_responsable FROM these))' rule: #createViewCommand