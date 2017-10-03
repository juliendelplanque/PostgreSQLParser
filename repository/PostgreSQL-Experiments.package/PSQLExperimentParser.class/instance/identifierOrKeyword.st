accessing
identifierOrKeyword
	^ super identifierOrKeyword ==> [ :items |
		|iOrK|
		iOrK := String newFrom: items flattened.
		(self class postgresql96Keywords includes: iOrK)
			ifTrue: [ PSQLKeyword new
							contents: iOrK;
							yourself ]
			ifFalse: [ PSQLIdentifier new
							contents: iOrK;
							yourself ] ]