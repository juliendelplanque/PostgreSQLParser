printing
printOn: aStream
	super printOn: aStream.
	aStream << $(.
	self tokensWithoutWhitespaces do: [ :token |
		aStream << token contents ] separatedBy: [ aStream space ].
	aStream << $)