as yet unclassified
testCreateView56
	self
		parse: 'CREATE VIEW critical_opinion AS SELECT opinion.initiative_id, opinion.suggestion_id, opinion.member_id, opinion.degree, opinion.fulfilled FROM opinion WHERE (((opinion.degree = 2) AND (opinion.fulfilled = false)) OR ((opinion.degree = (-2)) AND (opinion.fulfilled = true)))' rule: #createViewCommand