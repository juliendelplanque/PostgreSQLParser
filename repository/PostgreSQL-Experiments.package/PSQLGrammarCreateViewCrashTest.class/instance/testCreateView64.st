as yet unclassified
testCreateView64
	self
		parse: 'CREATE VIEW liquid_feedback_version AS SELECT subquery.string, subquery.major, subquery.minor, subquery.revision FROM ( VALUES (''3.1.0''::text,3,1,0)) subquery(string, major, minor, revision)' rule: #createViewCommand