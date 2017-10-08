accessing
isNotNull
	^ super isNotNull ==> [ :tokens | tokens joinUsing: ' ' ]