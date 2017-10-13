update command
updateCommand
	self flag: #todo.
	^ 'UPDATE' asParser caseInsensitive , (semicolon not , #any asParser) plus