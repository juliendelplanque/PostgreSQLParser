as yet unclassified
testCreateView61
	self
		parse: 'CREATE VIEW initiative_suggestion_order_calculation AS SELECT initiative.id AS initiative_id, ((issue.closed IS NOT NULL) OR (issue.fully_frozen IS NOT NULL)) AS final FROM (initiative JOIN issue ON ((initiative.issue_id = issue.id))) WHERE (((issue.closed IS NULL) AND (issue.fully_frozen IS NULL)) OR (initiative.final_suggestion_order_calculated = false))' rule: #createViewCommand