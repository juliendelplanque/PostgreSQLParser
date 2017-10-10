tests
testFromItems4
	self
		parse: 'function(1, "a") AS aliasName (c1, C2, "C3")' rule: #fromItems4;
		parse: 'function(1, "a") aliasName (c1, C2, "C3")' rule: #fromItems4;
		parse: 'function(1, "a") AS aliasName' rule: #fromItems4;
		parse: 'function(1, "a") aliasName' rule: #fromItems4;
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE) AS mbrs( clepersonne INTEGER, datearrivee DATE, sexe VARCHAR, nompersonne VARCHAR, prenompersonne VARCHAR, datenaissance DATE, paysorigine VARCHAR, nomcategorie VARCHAR, corps VARCHAR, typedusupport VARCHAR, numsection INT2, numcmu INT2, debutsupport DATE, finsupport DATE, nomequipes TEXT, nomemployeur VARCHAR, nomenseignement VARCHAR, typefinancement VARCHAR, financeurs TEXT, reffinancement VARCHAR, responsablethese TEXT )' rule: #fromItems4