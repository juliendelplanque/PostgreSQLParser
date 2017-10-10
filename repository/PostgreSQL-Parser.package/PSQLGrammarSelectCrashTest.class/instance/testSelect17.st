tests
testSelect17
	self
		parse: 'SELECT date_part(''year''::text, support.debut) AS annee, count(*) AS total, (sum(est_un_homme(personne.civilite)))::integer AS homme, (sum(est_une_femme(personne.civilite)))::integer AS femme FROM personne, support WHERE ((personne.cle = support.cle_personne) AND (date_part(''year''::text, support.debut) IN (SELECT DISTINCT date_part(''year''::text, support.debut) AS annee FROM support ORDER BY date_part(''year''::text, support.debut)))) GROUP BY date_part(''year''::text, support.debut) ORDER BY date_part(''year''::text, support.debut)' rule: #selectCommand