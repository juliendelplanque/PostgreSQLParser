Class {
	#name : #PSQLDeleteQueryGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Parser-Tests
}

{ #category : #accessing }
PSQLDeleteQueryGrammarTest >> parserClass [
	^ PSQLDeleteQueryGrammar
]

{ #category : #'tests-delete command' }
PSQLDeleteQueryGrammarTest >> testDeleteCommand [
	self
		parse: 'DELETE FROM films USING producers WHERE producer_id = producers.id AND producers.name = ''foo''' rule: #deleteCommand;
		parse: 'DELETE FROM films WHERE producer_id IN (SELECT id FROM producers WHERE name = ''foo'')' rule: #deleteCommand;
		parse: 'DELETE FROM films WHERE kind <> ''Musical''' rule: #deleteCommand;
		parse: 'DELETE FROM films' rule: #deleteCommand;
		parse: 'DELETE FROM tasks WHERE status = ''DONE'' RETURNING *' rule: #deleteCommand;
		parse: 'DELETE FROM tasks WHERE CURRENT OF c_tasks' rule: #deleteCommand;
		parse: 'WITH t AS (
    DELETE FROM foo
)
DELETE FROM bar' rule: #deleteCommand
]
