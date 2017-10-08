as yet unclassified
testCreateView57
	self
		parse: 'CREATE VIEW current_draft AS SELECT draft.initiative_id, draft.id, draft.created, draft.author_id, draft.formatting_engine, draft.content, draft.external_reference, draft.text_search_data FROM (( SELECT initiative.id AS initiative_id, max(draft_1.id) AS draft_id FROM (initiative JOIN draft draft_1 ON ((initiative.id = draft_1.initiative_id))) GROUP BY initiative.id) subquery JOIN draft ON ((subquery.draft_id = draft.id)))' rule: #createViewCommand