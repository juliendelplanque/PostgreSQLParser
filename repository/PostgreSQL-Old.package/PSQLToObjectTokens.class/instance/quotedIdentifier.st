accessing
quotedIdentifier
	^ super quotedIdentifier ==> [ :items | String newFrom: items allButFirst allButLast flattened ]