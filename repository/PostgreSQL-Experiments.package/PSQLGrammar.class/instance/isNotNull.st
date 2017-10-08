expression
isNotNull
	^ (self buildKeyword: 'is') trim , (self buildKeyword: 'not') trim , (self buildKeyword: 'null')