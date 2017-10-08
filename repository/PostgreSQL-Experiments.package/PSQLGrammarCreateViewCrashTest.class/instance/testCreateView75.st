as yet unclassified
testCreateView75
	self
		parse: 'CREATE VIEW unit_member_count AS SELECT unit.id AS unit_id, count(member.id) AS member_count FROM ((unit LEFT JOIN privilege ON (((privilege.unit_id = unit.id) AND privilege.voting_right))) LEFT JOIN member ON (((member.id = privilege.member_id) AND member.active))) GROUP BY unit.id' rule: #createViewCommand