tests
testSelect2
	self
		parse: 'SELECT * FROM membres(labo,dateobservation::DATE,dateobservation::DATE) AS ( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #selectCommand