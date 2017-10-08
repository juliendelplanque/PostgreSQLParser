as yet unclassified
testCreateView59
	self
		parse: 'CREATE VIEW expired_session AS SELECT session.ident, session.additional_secret, session.expiry, session.member_id, session.authority, session.authority_uid, session.authority_login, session.needs_delegation_check, session.lang FROM session WHERE (now() > session.expiry)' rule: #createViewCommand