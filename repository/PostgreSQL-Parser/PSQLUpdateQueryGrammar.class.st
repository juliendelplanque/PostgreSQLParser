"
I parse PostgreSQL UPDATE query.
"
Class {
	#name : #PSQLUpdateQueryGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'updateCommand',
		'fromClause',
		'returningClause',
		'withClause',
		'updateDeleteWhereClause',
		'setClause',
		'kw',
		'identifierWithOptionalFieldAccess',
		'asterik',
		'identifier'
	],
	#category : #PostgreSQL-Parser-Grammars-CRUD
}

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> dependencies [
	^ { self sqlParser . self fromClauseParser . self sharedParser . self tokenParser }
]

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> fromClauseParser [
	^ PSQLFromClauseGrammar
]

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> sharedParser [
	^ PSQLSharedGrammar
]

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> sqlParser [
	^ PSQLExpressionGrammar
]

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> tokenParser [
	^ PSQLTokenizer
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> asterik [
	^ (self dependencyAt: self class tokenParser) asterik
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> fromClause [
	^ (self dependencyAt: self class fromClauseParser) fromClause
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> identifier [
	^ (self dependencyAt: self class tokenParser) identifier
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> identifierOrKeyword [
	^ (self dependencyAt: self class sqlParser) identifierOrKeyword
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> identifierWithOptionalFieldAccess [
	^ (self dependencyAt: self class tokenParser) identifierWithOptionalFieldAccess
]

{ #category : #initialization }
PSQLUpdateQueryGrammar >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> returningClause [
	^ (self dependencyAt: self class sharedParser) returningClause
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> setClause [
	^ (self dependencyAt: self class sharedParser) setClause
]

{ #category : #accessing }
PSQLUpdateQueryGrammar >> start [
		^ updateCommand end
]

{ #category : #'update command' }
PSQLUpdateQueryGrammar >> updateCommand [
	"https://www.postgresql.org/docs/9.6/static/sql-update.html
	[ WITH [ RECURSIVE ] with_query [, ...] ]
		UPDATE [ ONLY ] table_name [ * ] [ [ AS ] alias ]
    	SET { column_name = { expression | DEFAULT } |
          ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
          ( column_name [, ...] ) = ( sub-SELECT )
        } [, ...]
    	[ FROM from_list ]
    	[ WHERE condition | WHERE CURRENT OF cursor_name ]
    	[ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]"
	^ withClause trim optional ,
		kw update trim , kw only trim optional , identifierWithOptionalFieldAccess trim , asterik trim optional , (kw as trim optional , identifier) optional ,
		setClause trim ,
		fromClause trim optional , 
		updateDeleteWhereClause trim optional ,
		returningClause trim optional
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> updateDeleteWhereClause [
	^ (self dependencyAt: self class sharedParser) updateDeleteWhereClause
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> withClause [
	^ (self dependencyAt: self class sharedParser) withClause
]
