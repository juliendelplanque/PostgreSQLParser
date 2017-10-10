accessing
identifierOrKeyword
	| str |
	^ super identifierOrKeyword ==> [ :items |
		str := String newFrom: items.
		(PSQLKeyword isKeyword: str)
			ifTrue: [ PSQLKeyword new contents: str; yourself ]
			ifFalse: [ PSQLIdentifier new contents: str; yourself ]  ]