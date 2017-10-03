accessing
dollarQuotedStringConstantOpenTag
	^ super dollarQuotedStringConstantOpenTag ==> [ :items | 
		(items second ifNil: [ '' ]) asString ]