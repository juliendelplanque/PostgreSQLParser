tests
testSelect57
	self
		parse: 'SELECT subquery.string, subquery.major, subquery.minor, subquery.revision FROM ( VALUES (''3.1.0''::text,3,1,0)) subquery(string, major, minor, revision)' rule: #selectCommand