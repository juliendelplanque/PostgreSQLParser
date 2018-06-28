Class {
	#name : #PSQLSharedGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #'PostgreSQL-Parser-Tests'
}

{ #category : #accessing }
PSQLSharedGrammarTest >> parserClass [
	^ PSQLSharedGrammar
]

{ #category : #'tests-accessing' }
PSQLSharedGrammarTest >> testOrderByClause [
	self
		parse: 'ORDER BY a + b, c' rule: #orderByClause;
		parse: 'ORDER BY sum' rule: #orderByClause;
		parse: 'ORDER BY 1 ASC NULLS LAST' rule: #orderByClause
]

{ #category : #'tests-shared' }
PSQLSharedGrammarTest >> testReturningClause [
	self
		parse: 'RETURNING *' rule: #returningClause;
		parse: 'RETURNING id, name' rule: #returningClause;
		parse: 'RETURNING *,id' rule: #returningClause
]

{ #category : #'tests-shared' }
PSQLSharedGrammarTest >> testSetClause [
	self
		parse: 'SET "reverse_beat_path" = CASE WHEN "policy_row"."defeat_strength" = ''simple''::"defeat_strength" THEN NULL ELSE "matrix_p"[1]["i"]."primary" >= 0 END' rule: #setClause
]

{ #category : #'tests-update command' }
PSQLSharedGrammarTest >> testUpdateDeleteWhereClause [
	self
		parse: 'WHERE id = 5' rule: #updateDeleteWhereClause;
		parse: 'WHERE CURRENT OF curs1' rule: #updateDeleteWhereClause
]

{ #category : #'tests-shared' }
PSQLSharedGrammarTest >> testWithClause [
	self
		parse: 'WITH table AS (SELECT * FROM foo), table2(id,text) AS (SELECT * FROM bar)' rule: #withClause;
		parse: 'WITH RECURSIVE table AS (SELECT * FROM foo), table2(id,text) AS (SELECT * FROM bar)' rule: #withClause
]

{ #category : #'tests-shared' }
PSQLSharedGrammarTest >> testWithQuery [
	self
		parse: 'table AS (SELECT * FROM foo)' rule: #withQuery;
		parse: 'table(id,bar) AS (SELECT * FROM foo)' rule: #withQuery
]
