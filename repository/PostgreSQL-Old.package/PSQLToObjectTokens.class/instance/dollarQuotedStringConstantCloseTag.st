accessing
dollarQuotedStringConstantCloseTag
	^ super dollarQuotedStringConstantCloseTag ==> [ :items |
		(items second ifNil: [ '' ]) asString ]