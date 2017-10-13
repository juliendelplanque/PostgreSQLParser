insert command
insertCommand
	self flag: #todo.
	^ ('INSERT' asParser caseInsensitive , (semicolon not , #any asParser) plus)