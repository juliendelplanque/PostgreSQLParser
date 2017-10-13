update command
updateCommand
	self flag: #todo.
	^ kw update , (semicolon not , #any asParser) plus