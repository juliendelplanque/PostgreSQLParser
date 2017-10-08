as yet unclassified
testCreateView67
	self
		parse: 'CREATE VIEW member_contingent_left AS SELECT member_contingent.member_id, member_contingent.polling, max((member_contingent.text_entry_limit - member_contingent.text_entry_count)) AS text_entries_left, max((member_contingent.initiative_limit - member_contingent.initiative_count)) AS initiatives_left FROM member_contingent GROUP BY member_contingent.member_id, member_contingent.polling' rule: #createViewCommand