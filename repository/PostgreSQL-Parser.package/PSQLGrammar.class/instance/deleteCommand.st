delete command
deleteCommand
	self flag: #todo.
	^  kw delete , (semicolon not , #any asParser) plus