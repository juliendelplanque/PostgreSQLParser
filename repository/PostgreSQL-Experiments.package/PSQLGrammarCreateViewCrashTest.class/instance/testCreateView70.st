as yet unclassified
testCreateView70
	self
		parse: 'CREATE VIEW remaining_harmonic_initiative_weight_dummies AS SELECT initiative.issue_id, initiative.id AS initiative_id, initiative.admitted, 0 AS weight_num, 1 AS weight_den FROM initiative WHERE (initiative.harmonic_weight IS NULL)' rule: #createViewCommand