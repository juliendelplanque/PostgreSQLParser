"
I build an AST for various subsets of the PSQL grammar that are shared between multiple ast builders.
"
Class {
	#name : #PSQLSharedASTBuilder,
	#superclass : #PSQLSharedGrammar,
	#traits : 'PSQLTExpressionDependingBuilder',
	#classTraits : 'PSQLTExpressionDependingBuilder classTrait',
	#category : #'PostgreSQL-AST-Builder'
}

{ #category : #accessing }
PSQLSharedASTBuilder class >> crudQueryParser [
	^ PSQLCRUDQueryASTBuilder
]

{ #category : #accessing }
PSQLSharedASTBuilder class >> tokenParser [
	^ PSQLTokenASTBuilder
]

{ #category : #shared }
PSQLSharedASTBuilder >> orderByClause [
	^ super orderByClause psqlASTBuild: [ :tokens |
		PSQLASTOrderByClause new
			items: (tokens third reject: [ :item | item = $, ] thenCollect: [ :array |
				|item|
				item := array first.
				PSQLASTOrderByClauseItem new
					expression: item first;
					isAsc: (item second ifNotNil: [ item second asUppercase = 'ASC' ]);
					isNullsFirst: (item third ifNotNil: [ item third second asUppercase = 'FIRST' ]);
					yourself ]);
			yourself ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> returningClause [
	^ super returningClause psqlASTBuild: [ :tokens |
		PSQLASTReturningClause new
			returnedList: (tokens second reject: [ :token | token = $, ]);
			yourself ]
]

{ #category : #'shared - set clause' }
PSQLSharedASTBuilder >> setClause [
	^ super setClause psqlASTBuild: [ :tokens |
		PSQLASTSetClause new
			items: (tokens second reject: [ :item | item = $, ]);
			yourself ]
]

{ #category : #'shared - set clause' }
PSQLSharedASTBuilder >> setItem1 [
	^ super setItem1 psqlASTBuild: [ :tokens |
		PSQLASTSetClauseItemType1 new
			left: tokens first;
			right: (tokens third isString
						ifFalse: [ tokens third ]
						ifTrue: [ PSQLASTDefaultValue new ]) ]
]

{ #category : #'shared - set clause' }
PSQLSharedASTBuilder >> setItem2 [
	^ super setItem2 psqlASTBuild: [ :tokens |
		PSQLASTSetClauseItemType2 new
			left: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
			right: (tokens sixth 
						reject: [ :item | item = $, ]
						thenCollect: [ :item | item first isString ifTrue: [ PSQLASTDefaultValue new ] ifFalse: [ item first ] ]);
			yourself ]
]

{ #category : #'shared - set clause' }
PSQLSharedASTBuilder >> setItem3 [
	^ super setItem3 psqlASTBuild: [ :tokens |
		PSQLASTSetClauseItemType3 new
			left: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
			right: tokens sixth;
			yourself ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> updateDeleteWhereClause [
	^ super updateDeleteWhereClause psqlASTBuild: [ :tokens |
		|node|
		node := PSQLASTUpdateDeleteWhereClause new.
		tokens second isArray
			ifTrue: [ node currentOfCursor: tokens second third ]
			ifFalse: [ node condition: tokens second ].
		node ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> withClause [
	^ super withClause psqlASTBuild: [ :tokens |
		PSQLASTWithClause new
			isRecursive: tokens second isNotNil;
			queries: (tokens third reject: [ :item | item = $, ]);
			yourself ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> withQuery [
	^ super withQuery psqlASTBuild: [ :tokens |
		(PSQLASTTableAlias new
			identifier: tokens first;
			columnAliases: (tokens second ifNotNil: [ :array | array second reject: [ :token | token = $, ] ]  ifNil: [ #() ]);
			yourself) -> tokens fifth ]
]
