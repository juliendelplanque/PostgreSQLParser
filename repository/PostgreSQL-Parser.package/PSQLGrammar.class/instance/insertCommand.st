insert command
insertCommand
	self flag: #todo.
	^ kw insert , (semicolon not , #any asParser) plus