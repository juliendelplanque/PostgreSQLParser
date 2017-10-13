delete command
deleteCommand
	self flag: #todo.
	^ 'DELETE' asParser caseInsensitive , (semicolon not , #any asParser) plus