as yet unclassified
testCreateView46
	self
		parse: 'CREATE VIEW web_sitesweb_by_equipeexterne AS SELECT equipe.siteweb, r_equextequ.cle_equipe_externe FROM ((equipe JOIN r_equextequ ON ((equipe.cle = r_equextequ.cle_equipe_interne))) JOIN equipeexterne ON ((equipeexterne.cle = r_equextequ.cle_equipe_externe))) WHERE (((equipeexterne.fin >= now()) OR (equipeexterne.fin IS NULL)) AND ((equipe.fin >= now()) OR (equipe.fin IS NULL)))' rule: #createViewCommand