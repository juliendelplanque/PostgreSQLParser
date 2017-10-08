as yet unclassified
testCreateView54
	self
		parse: 'CREATE VIEW battle_participant AS SELECT initiative.id, initiative.issue_id FROM (issue JOIN initiative ON ((issue.id = initiative.issue_id))) WHERE initiative.admitted UNION ALL SELECT NULL::integer AS id, issue.id AS issue_id FROM issue' rule: #createViewCommand