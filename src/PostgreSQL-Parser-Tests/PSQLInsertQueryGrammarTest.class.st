Class {
	#name : #PSQLInsertQueryGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #'PostgreSQL-Parser-Tests'
}

{ #category : #accessing }
PSQLInsertQueryGrammarTest >> parserClass [
	^ PSQLInsertQueryGrammar
]

{ #category : #'tests-insert command' }
PSQLInsertQueryGrammarTest >> testConflictTarget [
	self
		parse: '(did)' rule: #conflictTarget
]

{ #category : #'tests-insert command' }
PSQLInsertQueryGrammarTest >> testInsertCommand [
	self
		parse: 'INSERT INTO films VALUES
    (''UA502'', ''Bananas'', 105, ''1971-07-13'', ''Comedy'', ''82 minutes'')' rule: #insertCommand;
		parse: 'INSERT INTO films (code, title, did, date_prod, kind) VALUES (''T_601'', ''Yojimbo'', 106, ''1961-06-16'', ''Drama'')' rule: #insertCommand;
		parse: 'INSERT INTO films VALUES (''UA502'', ''Bananas'', 105, DEFAULT, ''Comedy'', ''82 minutes'')' rule: #insertCommand;
		parse: 'INSERT INTO films (code, title, did, date_prod, kind) VALUES (''T_601'', ''Yojimbo'', 106, DEFAULT, ''Drama'')' rule: #insertCommand;
		parse: 'INSERT INTO films DEFAULT VALUES' rule: #insertCommand;
		parse: 'INSERT INTO films (code, title, did, date_prod, kind) VALUES (''B6717'', ''Tampopo'', 110, ''1985-02-10'', ''Comedy''), (''HG120'', ''The Dinner Game'', 140, DEFAULT, ''Comedy'')' rule: #insertCommand;
		parse: 'INSERT INTO films SELECT * FROM tmp_films WHERE date_prod < ''2004-05-07''' rule: #insertCommand;
		parse: 'INSERT INTO tictactoe (game, board[1:3][1:3]) VALUES (1, ''{{" "," "," "},{" "," "," "},{" "," "," "}}'')' rule: #insertCommand;
		parse: 'INSERT INTO tictactoe (game, board) VALUES (2, ''{{X," "," "},{" ",O," "},{" ",X," "}}'')' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (DEFAULT, ''XYZ Widgets'') RETURNING did' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (5, ''Gizmo Transglobal''), (6, ''Associated Computing, Inc'') ON CONFLICT (did) DO UPDATE SET dname = EXCLUDED.dname' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (7, ''Redline GmbH'') ON CONFLICT (did) DO NOTHING' rule: #insertCommand;
		parse: 'INSERT INTO distributors AS d (did, dname) VALUES (8, ''Anvil Distribution'') ON CONFLICT (did) DO UPDATE SET dname = EXCLUDED.dname || '' (formerly '' || d.dname || '')'' WHERE d.zipcode <> ''21201''' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (9, ''Antwerp Design'') ON CONFLICT ON CONSTRAINT distributors_pkey DO NOTHING' rule: #insertCommand;
		parse: 'INSERT INTO distributors (did, dname) VALUES (10, ''Conrad International'') ON CONFLICT (did) WHERE is_active DO NOTHING' rule: #insertCommand;
		parse: 'WITH upd AS (
  UPDATE employees SET sales_count = sales_count + 1 WHERE id =
    (SELECT sales_person FROM accounts WHERE name = ''Acme Corporation'')
    RETURNING *
)
INSERT INTO employees_log SELECT *, current_timestamp FROM upd' rule: #insertCommand
]
