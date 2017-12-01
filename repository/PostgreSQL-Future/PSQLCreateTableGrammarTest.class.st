Class {
	#name : #PSQLCreateTableGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #PostgreSQL-Future
}

{ #category : #accessing }
PSQLCreateTableGrammarTest >> parserClass [
	^ PSQLCreateTableGrammar
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testColumnConstraint1 [
	self
		parse: 'NOT NULL' rule: #columnConstraint1;
		parse: 'not null' rule: #columnConstraint1
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testColumnConstraint2 [
	self
		parse: 'NULL' rule: #columnConstraint2;
		parse: 'null' rule: #columnConstraint2
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testColumnDefinitionItem [
	self
		parse: 'code char(5) CONSTRAINT firstkey PRIMARY KEY' rule: #columnDefinitionItem;
		parse: 'title varchar(40) NOT NULL' rule: #columnDefinitionItem;
		parse: 'did integer NOT NULL' rule: #columnDefinitionItem;
		parse: 'date_prod date' rule: #columnDefinitionItem;
		parse: 'kind varchar(10)' rule: #columnDefinitionItem;
		parse: 'len interval hour to minute' rule: #columnDefinitionItem;
		parse: 'did    integer PRIMARY KEY DEFAULT nextval(''serial'')' rule: #columnDefinitionItem
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testCreateTableCommandForm1 [
	self
		parse: 'CREATE TABLE films (
    code        char(5) CONSTRAINT firstkey PRIMARY KEY,
    title       varchar(40) NOT NULL,
    did         integer NOT NULL,
    date_prod   date,
    kind        varchar(10),
    len         interval hour to minute
)' rule: #createTableCommandForm1;
		parse: 'CREATE TABLE distributors (
     did    integer PRIMARY KEY DEFAULT nextval(''serial''),
     name   varchar(40) NOT NULL CHECK (name <> '''')
)' rule: #createTableCommandForm1
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testDeclarationType [
	self
		fail: 'x primary' rule: #declarationType
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testIfNotExists [
	self parse: 'IF NOT EXISTS' rule: #ifNotExists
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testInheritsClause [
	self
		parse: 'INHERITS (t)' rule: #inheritsClause;
		parse: 'INHERITS (t1 , t2)' rule: #inheritsClause;
		parse: 'INHERITS (t, t2 , t3)' rule: #inheritsClause
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testKeyValues [
	self
		parse: 'WITH key = 1' rule: #keyValues;
		parse: 'WITH key = 1 , key2 = 42.3, otherKey' rule: #keyValues
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testOnCommitClause [
	self
		parse: 'ON COMMIT PRESERVE ROWS' rule: #onCommitClause;
		parse: 'ON COMMIT DELETE ROWS' rule: #onCommitClause;
		parse: 'ON COMMIT DROP' rule: #onCommitClause
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testTableCreationAttributes [
	self
		parse: 'GLOBAL TEMPORARY' rule: #tableCreationAttributes;
		parse: 'LOCAL TEMP' rule: #tableCreationAttributes;
		parse: 'GLOBAL UNLOGGED' rule: #tableCreationAttributes;
		parse: 'UNLOGGED' rule: #tableCreationAttributes;
		parse: 'TEMPORARY' rule: #tableCreationAttributes
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testTablespaceClause [
	self
		parse: 'TABLESPACE test' rule: #tablespaceClause
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testWithClause [
	self
		parse: 'WITH OIDS' rule: #withClause;
		parse: 'WITHOUT OIDS' rule: #withClause;
		parse: 'WITH key = 1 , key2 = 42.3, otherKey' rule: #withClause
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testWithOids [
	self
		parse: 'WITH OIDS' rule: #withOids
]

{ #category : #tests-rules }
PSQLCreateTableGrammarTest >> testWithoutOids [
	self
		parse: 'WITHOUT OIDS' rule: #withoutOids
]
