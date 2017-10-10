as yet unclassified
testCreateView74
	self
		parse: 'CREATE VIEW unit_delegation AS SELECT unit.id AS unit_id, delegation.id, delegation.truster_id, delegation.trustee_id, delegation.scope FROM (((unit JOIN delegation ON ((delegation.unit_id = unit.id))) JOIN member ON ((delegation.truster_id = member.id))) JOIN privilege ON (((delegation.unit_id = privilege.unit_id) AND (delegation.truster_id = privilege.member_id)))) WHERE (member.active AND privilege.voting_right)' rule: #createViewCommand