"
I parse PostgreSQL FROM clause for queries using this clause.
"
Class {
	#name : #PSQLFromClauseGrammar,
	#superclass : #PPCompositeParser,
	#traits : 'PSQLTExpressionDependingGrammar',
	#classTraits : 'PSQLTExpressionDependingGrammar classTrait',
	#instVars : [
		'columnReference',
		'expression',
		'functionCall',
		'selectCommand',
		'valuesCommand',
		'columnDefinition',
		'fromClause',
		'fromItems',
		'fromItems1',
		'fromItems2',
		'fromItems3',
		'fromItems4',
		'fromItems5',
		'fromItems6',
		'fromItems7',
		'joinType',
		'parenthesedFromItems',
		'kw',
		'identifier',
		'comma',
		'identifierWithOptionalFieldAccess',
		'asterik',
		'openParenthesis',
		'closeParenthesis'
	],
	#category : #'PostgreSQL-Parser-Grammars-Others'
}

{ #category : #accessing }
PSQLFromClauseGrammar class >> dependencies [
	^ { self expressionParser . self selectQueryParser . self valuesCommandParser . self tokenParser }
]

{ #category : #accessing }
PSQLFromClauseGrammar class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLFromClauseGrammar class >> selectQueryParser [
	^ PSQLSelectQueryGrammar
]

{ #category : #accessing }
PSQLFromClauseGrammar class >> tokenParser [
	^ PSQLTokenizer
]

{ #category : #accessing }
PSQLFromClauseGrammar class >> valuesCommandParser [
	^ PSQLValuesGrammar
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> asterik [
	^ (self dependencyAt: self class tokenParser) asterik
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> closeParenthesis [
	^ (self dependencyAt: self class tokenParser) closeParenthesis
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> columnDefinition [
	^ identifier trim , (identifier separatedBy: #space asParser plus)
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> columnReference [
	^ self expressionParser columnReference
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> comma [
	^ (self dependencyAt: self class tokenParser) comma
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> expression [
	^ self expressionParser expression
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromClause [
	^ kw from trim , (fromItems plus separatedBy: comma trim)
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromItems [
	"Have a look at #fromItems6 if you wonder why #fromItems6 is not treated as the others.
	
	[ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
                [ TABLESAMPLE sampling_method ( argument [, ...] ) [ REPEATABLE ( seed ) ] ] <- #fromItems1
    [ LATERAL ] ( select ) [ AS ] alias [ ( column_alias [, ...] ) ] <- #fromItems2
    with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ] <- #fromItems3
    [ LATERAL ] function_name ( [ argument [, ...] ] )
                [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ] <- #fromItems 7
    [ LATERAL ] function_name ( [ argument [, ...] ] ) [ AS ] alias ( column_definition [, ...] ) <- #fromItems4
    [ LATERAL ] function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] ) <- #fromItems5
    [ LATERAL ] ROWS FROM( function_name ( [ argument [, ...] ] ) [ AS ( column_definition [, ...] ) ] [, ...] )
                [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ] <- This is not implemented yet
    from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ] <- #fromItems6"
	^ (parenthesedFromItems / ( fromItems4 / fromItems5 / fromItems7 / fromItems1 / fromItems2 / fromItems3)) , fromItems6 star
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromItems1 [
	"[ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
                [ TABLESAMPLE sampling_method ( argument [, ...] ) [ REPEATABLE ( seed ) ] ]"
	self flag: 'Not fully implemented'.
	^ kw only trim optional ,
			identifierWithOptionalFieldAccess trim , asterik trim optional ,
				(kw as trim optional , identifier trim ,
					(openParenthesis trim ,
					(identifier separatedBy: comma trim),
					closeParenthesis trim) optional) optional
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromItems2 [
	"This should be implemented as:
		[ LATERAL ] ( select ) [ AS ] alias [ ( column_alias [, ...] ) ]
	But is implemented as:
		[ LATERAL ] ( values | select ) [ AS ] alias [ ( column_alias [, ...] ) ]
	since using a VALUES query is just like if a select query is used except
	that the results are defined directly in the query."
	^ kw lateral trim optional ,
		openParenthesis trim , (valuesCommand / selectCommand) , closeParenthesis trim , kw as trim optional ,
			identifier trim ,
			(openParenthesis trim,
			 (identifier separatedBy: comma trim),
			 closeParenthesis trim) optional
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromItems3 [
	"with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ identifier trim , (
			kw as trim optional , identifier trim , 
			(openParenthesis trim,
			(identifier separatedBy: comma trim),
			closeParenthesis trim) optional) optional
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromItems4 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) [ AS ] alias ( column_definition [, ...] )"
	^ kw lateral trim optional , 
		functionCall trim ,
		kw as trim optional ,
		identifier trim,
		openParenthesis trim ,
			(columnDefinition plus separatedBy: comma trim),
		closeParenthesis trim
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromItems5 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )"
	^ kw lateral trim optional , 
		functionCall trim ,
		kw as trim ,
		openParenthesis trim ,
			(columnDefinition plus separatedBy: comma trim),
		closeParenthesis trim
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromItems6 [
	"from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	Normally it should behaves as precedently described ^ BUT, because of recursivity problems, it is defined here as:
	
	[ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	and the 'from_item' is managed in #fromItems parser."
	
	^ kw natural trim optional , joinType trim , fromItems trim , 
		((kw on trim , expression) / 
		(kw using trim ,
			openParenthesis trim , 
			(columnReference plus separatedBy: comma trim),
			closeParenthesis trim)) optional
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> fromItems7 [
	"[ LATERAL ] function_name ( [ argument [, ...] ] ) [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ kw lateral trim optional , 
		functionCall trim ,
		(kw with trim , kw ordinality trim) optional ,
		(kw as trim optional ,
		identifier trim,
		(openParenthesis trim ,
			(identifier plus separatedBy: comma trim),
		closeParenthesis trim) optional ) optional
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> functionCall [
	^ (self expressionParser) functionCall
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> identifier [
	^ (self dependencyAt: self class tokenParser) identifier
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> identifierWithOptionalFieldAccess [
	^ (self dependencyAt: self class tokenParser) identifierWithOptionalFieldAccess
]

{ #category : #initialization }
PSQLFromClauseGrammar >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> joinType [
	^ (kw inner trim optional, kw join trim) /
	(kw left trim , kw outer trim optional , kw join trim) /
	(kw right trim , kw outer trim optional , kw join trim) /
	(kw full trim , kw outer trim optional , kw join trim) /
	(kw cross trim , kw join trim)
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> openParenthesis [
	^ (self dependencyAt: self class tokenParser) openParenthesis
]

{ #category : #'shared - from clause' }
PSQLFromClauseGrammar >> parenthesedFromItems [
	"Have a look at #fromItems6 if you wonder why #fromItems6 is not treated as the others."
	^ openParenthesis trim , fromItems trim , closeParenthesis trim
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> selectCommand [
	^ (self dependencyAt: self class selectQueryParser) selectCommand
]

{ #category : #accessing }
PSQLFromClauseGrammar >> start [
	^ fromClause end
]

{ #category : #dependencies }
PSQLFromClauseGrammar >> valuesCommand [
	^ (self dependencyAt: self class valuesCommandParser) valuesCommand
]
