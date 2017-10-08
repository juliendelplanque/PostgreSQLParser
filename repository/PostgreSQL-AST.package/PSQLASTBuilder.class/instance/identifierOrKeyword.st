accessing
identifierOrKeyword
	^ super identifierOrKeyword ==> [ :tokens | String newFrom: tokens flattened ]