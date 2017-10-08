accessing
isNull
	^ super isNull ==> [ :tokens | tokens joinUsing: ' ' ]