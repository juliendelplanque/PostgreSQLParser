as yet unclassified
testCreateView32
	self
		parse: 'CREATE VIEW vue_types_affectations AS SELECT typeaffectation.cle, typeaffectation.nom FROM typeaffectation ORDER BY typeaffectation.defaut DESC' rule: #createViewCommand