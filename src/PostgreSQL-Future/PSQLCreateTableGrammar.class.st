Class {
	#name : #PSQLCreateTableGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'kw',
		'tableCreationAttributes',
		'ifNotExists',
		'identifier',
		'openParenthesis',
		'tableDefinitionItem',
		'comma',
		'closeParenthesis',
		'inheritsClause',
		'withClause',
		'onCommitClause',
		'tablespaceClause',
		'createTableCommandForm1',
		'createTableCommandForm2',
		'keyValues',
		'withOids',
		'withoutOids',
		'expression',
		'columnDefinitionItem',
		'tableConstraintDefinitionItem',
		'likeDefinitionItem',
		'columnConstraint',
		'columnConstraint1',
		'columnConstraint2',
		'columnConstraint3',
		'columnConstraint4',
		'columnConstraint5',
		'columnConstraint6',
		'columnConstraint7',
		'indexParameters',
		'action',
		'identifierOrKeyword',
		'numericConstant',
		'openBracket',
		'closeBracket',
		'declarationType',
		'createTableCommand'
	],
	#category : #PostgreSQL-Future
}

{ #category : #accessing }
PSQLCreateTableGrammar class >> dependencies [
	^ { self tokenParser . self expressionParser }
]

{ #category : #accessing }
PSQLCreateTableGrammar class >> expressionParser [
	^ PSQLExpressionGrammar
]

{ #category : #accessing }
PSQLCreateTableGrammar class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLCreateTableGrammar class >> tokenParser [
	^ PSQLTokenizer
]

{ #category : #rules }
PSQLCreateTableGrammar >> action [
	^ 'NO ACTION' asParser caseInsensitive /
	'RESTRICT' asParser caseInsensitive /
	'CASCADE' asParser caseInsensitive /
	'SET NULL' asParser caseInsensitive /
	'SET DEFAULT' asParser caseInsensitive
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> closeBracket [
	^ (self dependencyAt: self class tokenParser) closeBracket
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> closeParenthesis [
	^ (self dependencyAt: self class tokenParser) closeParenthesis
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnConstraint [
	"[ CONSTRAINT constraint_name ]
	{ NOT NULL |
  		NULL |
  		CHECK ( expression ) [ NO INHERIT ] |
  		DEFAULT default_expr |
  		UNIQUE index_parameters |
  		PRIMARY KEY index_parameters |
  		REFERENCES reftable [ ( refcolumn ) ] [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ]
    		[ ON DELETE action ] [ ON UPDATE action ] }
	[ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]"
	^ (kw constraint trim , identifier) trim optional ,
	(
		columnConstraint1 /
		columnConstraint2 /
		columnConstraint3 /
		columnConstraint4 /
		columnConstraint5 /
		columnConstraint6 /
		columnConstraint7
	) trim plus ,
	('DEFERRABLE' asParser caseInsensitive / 'NOT DEFERRABLE' asParser caseInsensitive) trim optional ,
	('INITIALLY DEFERRED' asParser caseInsensitive / 'INITIALLY IMMEDIATE' asParser caseInsensitive) trim optional
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnConstraint1 [
	"NOT NULL"
	^ 'NOT NULL' asParser caseInsensitive
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnConstraint2 [
	"NULL"
	^ 'NULL' asParser caseInsensitive
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnConstraint3 [
	"CHECK ( expression ) [ NO INHERIT ]"
	^ 'CHECK' asParser caseInsensitive trim ,
	openParenthesis trim ,
		expression trim ,
	closeParenthesis trim ,
	'NO INHERIT' asParser caseInsensitive optional
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnConstraint4 [
	"DEFAULT default_expr"
	^ kw default trim , expression
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnConstraint5 [
	"UNIQUE index_parameters"
	^ 'UNIQUE' asParser caseInsensitive trim , indexParameters
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnConstraint6 [
	"PRIMARY KEY index_parameters"
	^ 'PRIMARY KEY' asParser caseInsensitive trim , indexParameters optional
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnConstraint7 [
	"REFERENCES reftable [ ( refcolumn ) ] [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ] [ ON DELETE action ] [ ON UPDATE action ]"
	^ 'REFERENCES' asParser caseInsensitive trim ,
	identifier trim ,
	(openParenthesis trim , identifier trim , closeParenthesis) trim optional ,
	(
		'MATCH FULL' asParser caseInsensitive /
		'MATCH PARTIAL' asParser caseInsensitive /
		'MATCH SIMPLE' asParser caseInsensitive
	) trim optional ,
	('ON DELETE' asParser caseInsensitive trim , action) trim optional ,
	('ON UPDATE' asParser caseInsensitive trim , action) trim optional
]

{ #category : #rules }
PSQLCreateTableGrammar >> columnDefinitionItem [
	"column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]"
	^ identifier , 
	(declarationType plus separatedBy: #space asParser plus) trim ,
	(kw collate , expression) trim optional , 
	columnConstraint trim optional
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> comma [
	^ (self dependencyAt: self class tokenParser) comma
]

{ #category : #rules }
PSQLCreateTableGrammar >> createTableCommand [
	^ createTableCommandForm1 / createTableCommandForm2
]

{ #category : #rules }
PSQLCreateTableGrammar >> createTableCommandForm1 [
	"CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name ( [
  { column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
    | table_constraint
    | LIKE source_table [ like_option ... ] }
    [, ... ]
] )
[ INHERITS ( parent_table [, ... ] ) ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITH OIDS | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]"
	^ kw create trim ,
	tableCreationAttributes trim optional ,
	kw table trim ,
	ifNotExists trim optional ,
	identifier trim ,
	openParenthesis trim ,
	(tableDefinitionItem star separatedBy: comma trim) trim ,
	closeParenthesis trim ,
	inheritsClause trim optional ,
	withClause trim optional ,
	onCommitClause trim optional ,
	tablespaceClause trim optional
]

{ #category : #rules }
PSQLCreateTableGrammar >> createTableCommandForm2 [
	"CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    OF type_name [ (
  { column_name WITH OPTIONS [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITH OIDS | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]"
	^ PPFailingParser new
]

{ #category : #rules }
PSQLCreateTableGrammar >> declarationType [
	^ (kw collate not , kw notKeyword not , kw default not , 'PRIMARY' asParser caseInsensitive not , identifierOrKeyword) trim plus , 
	(openParenthesis trim , numericConstant trim , closeParenthesis trim) optional ,
	(openBracket trim , closeBracket trim) plus optional
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> expression [
	^ (self dependencyAt: self class expressionParser) expression
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> identifier [
	^ (self dependencyAt: self class tokenParser) identifier
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> identifierOrKeyword [
	^ (self dependencyAt: self class tokenParser) identifierOrKeyword
]

{ #category : #rules }
PSQLCreateTableGrammar >> ifNotExists [
	"IF NOT EXISTS"
	^ kw if trim , kw notKeyword trim , kw exists
]

{ #category : #rules }
PSQLCreateTableGrammar >> indexParameters [
	"[ WITH ( storage_parameter [= value] [, ... ] ) ]
	 [ USING INDEX TABLESPACE tablespace_name ]"
	^ keyValues optional trim ,
	('USING INDEX TABLESPACE' asParser caseInsensitive trim , identifier) optional trim
]

{ #category : #rules }
PSQLCreateTableGrammar >> inheritsClause [
	"INHERITS ( parent_table [, ... ] )"
	^ kw inherits trim , openParenthesis trim , (identifier plus separatedBy: comma trim) trim , closeParenthesis
]

{ #category : #initialization }
PSQLCreateTableGrammar >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new
]

{ #category : #rules }
PSQLCreateTableGrammar >> keyValues [
	^ kw with trim , ((identifier trim , ($= asParser trim , expression) optional) plus separatedBy: comma trim)
]

{ #category : #rules }
PSQLCreateTableGrammar >> likeDefinitionItem [
	"LIKE source_table [ like_option ... ]"
	self flag: 'TODO'.
	^ PPFailingParser new
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> numericConstant [
	^ (self dependencyAt: self class tokenParser) numericConstant
]

{ #category : #rules }
PSQLCreateTableGrammar >> onCommitClause [
	"ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP }"
	^ kw on trim , kw commit trim ,
	(
		'PRESERVE ROWS' asParser caseInsensitive /
		'DELETE ROWS' asParser caseInsensitive /
		'DROP' asParser caseInsensitive
	)
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> openBracket [
	^ (self dependencyAt: self class tokenParser) openBracket
]

{ #category : #dependencies }
PSQLCreateTableGrammar >> openParenthesis [
	^ (self dependencyAt: self class tokenParser) openParenthesis
]

{ #category : #accessing }
PSQLCreateTableGrammar >> start [
	^ createTableCommand
]

{ #category : #rules }
PSQLCreateTableGrammar >> tableConstraintDefinitionItem [
	"[ CONSTRAINT constraint_name ]
	{ CHECK ( expression ) [ NO INHERIT ] |
  		UNIQUE ( column_name [, ... ] ) index_parameters |
  		PRIMARY KEY ( column_name [, ... ] ) index_parameters |
  		EXCLUDE [ USING index_method ] ( exclude_element WITH operator [, ... ] ) index_parameters [ WHERE ( predicate ) ] |
  		FOREIGN KEY ( column_name [, ... ] ) REFERENCES reftable [ ( refcolumn [, ... ] ) ]
    	[ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ] [ ON DELETE action ] [ ON UPDATE action ]
	}
	[ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]"
	self flag: 'TODO'.
	^ PPFailingParser new
]

{ #category : #rules }
PSQLCreateTableGrammar >> tableCreationAttributes [
	"[ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED"
	^ (kw global / kw local) trim optional , ((kw temporary / kw temp) / kw unlogged)
]

{ #category : #rules }
PSQLCreateTableGrammar >> tableDefinitionItem [
	"column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
    | table_constraint
    | LIKE source_table [ like_option ... ]"
	^ columnDefinitionItem / tableConstraintDefinitionItem / likeDefinitionItem
]

{ #category : #rules }
PSQLCreateTableGrammar >> tablespaceClause [
	"TABLESPACE tablespace_name"
	^ kw tablespace trim , identifier
]

{ #category : #rules }
PSQLCreateTableGrammar >> withClause [
	"WITH ( storage_parameter [= value] [, ... ] ) | WITH OIDS | WITHOUT OIDS"
	^ keyValues / withOids / withoutOids
]

{ #category : #rules }
PSQLCreateTableGrammar >> withOids [
	^ 'WITH OIDS' asParser caseInsensitive
]

{ #category : #rules }
PSQLCreateTableGrammar >> withoutOids [
	^ 'WITHOUT OIDS' asParser caseInsensitive
]
