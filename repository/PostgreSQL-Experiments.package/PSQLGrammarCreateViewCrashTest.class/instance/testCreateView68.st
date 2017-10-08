as yet unclassified
testCreateView68
	self
		parse: 'CREATE VIEW member_count_view AS SELECT count(1) AS total_count FROM member WHERE member.active' rule: #createViewCommand