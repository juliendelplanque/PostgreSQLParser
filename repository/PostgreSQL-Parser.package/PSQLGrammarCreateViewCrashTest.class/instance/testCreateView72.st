as yet unclassified
testCreateView72
	self
		parse: 'CREATE VIEW remaining_harmonic_initiative_weight_summands AS SELECT initiative.issue_id, initiative.id AS initiative_id, initiative.admitted, sum(remaining_harmonic_supporter_weight.weight_num) AS weight_num, remaining_harmonic_supporter_weight.weight_den FROM ((remaining_harmonic_supporter_weight JOIN initiative ON (((remaining_harmonic_supporter_weight.issue_id = initiative.issue_id) AND (initiative.harmonic_weight IS NULL)))) JOIN direct_supporter_snapshot ON (((((initiative.id = direct_supporter_snapshot.initiative_id) AND (remaining_harmonic_supporter_weight.event = direct_supporter_snapshot.event)) AND (remaining_harmonic_supporter_weight.member_id = direct_supporter_snapshot.member_id)) AND ((direct_supporter_snapshot.satisfied = true) OR (COALESCE(initiative.admitted, false) = false))))) GROUP BY initiative.issue_id, initiative.id, initiative.admitted, remaining_harmonic_supporter_weight.weight_den' rule: #createViewCommand