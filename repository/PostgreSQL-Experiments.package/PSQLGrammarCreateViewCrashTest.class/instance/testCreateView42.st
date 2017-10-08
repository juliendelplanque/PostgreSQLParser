as yet unclassified
testCreateView42
	self
		parse: 'CREATE VIEW web_noms_longs_equipes_by_equipeexterne AS SELECT equipe.nomlong, equipe.nomlong_en, r_equextequ.cle_equipe_externe FROM ((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL)) AND ((equipe.fin >= now()) OR (equipe.fin IS NULL)))' rule: #createViewCommand