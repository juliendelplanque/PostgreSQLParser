tests
testColumnsAndAliasesSelected
	self
		parse: 'kind, sum(len) AS total' rule: #columnsAndAliasesSelected;
		parse: 'actors.name' rule: #columnsAndAliasesSelected