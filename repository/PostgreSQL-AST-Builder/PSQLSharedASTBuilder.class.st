Class {
	#name : #PSQLSharedASTBuilder,
	#superclass : #PSQLSharedGrammar,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLSharedASTBuilder class >> deleteQueryParser [
	^ PSQLDeleteQueryASTBuilder
]

{ #category : #accessing }
PSQLSharedASTBuilder class >> insertQueryParser [
	^ PSQLInsertQueryASTBuilder
]

{ #category : #accessing }
PSQLSharedASTBuilder class >> selectQueryParser [
	^ PSQLSelectQueryASTBuilder
]

{ #category : #accessing }
PSQLSharedASTBuilder class >> sqlParser [
	^ PSQLASTBuilder
]

{ #category : #accessing }
PSQLSharedASTBuilder class >> updateQueryParser [
	^ PSQLUpdateQueryASTBuilder
]

{ #category : #shared }
PSQLSharedASTBuilder >> orderByClause [
	^ super orderByClause ==> [ :tokens |
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
	^ super returningClause ==> [ :tokens |
		PSQLASTReturningClause new
			returnedList: (tokens second reject: [ :token | token = $, ]);
			yourself ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> setClause [
	^ super setClause ==> [ :tokens |
		PSQLASTSetClause new
			items: (tokens second reject: [ :item | item = $, ]);
			yourself ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> setItem1 [
	^ super setItem1 ==> [ :tokens |
		PSQLASTSetClauseItemType1 new
			left: tokens first;
			right: (tokens third isString
						ifFalse: [ tokens third ]
						ifTrue: [ PSQLASTDefaultValue new ]) ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> setItem2 [
	^ super setItem2 ==> [ :tokens |
		PSQLASTSetClauseItemType2 new
			left: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
			right: (tokens sixth 
						reject: [ :item | item = $, ]
						thenCollect: [ :item | item first isString ifTrue: [ PSQLASTDefaultValue new ] ifFalse: [ item first ] ]);
			yourself ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> setItem3 [
	^ super setItem3 ==> [ :tokens |
		PSQLASTSetClauseItemType3 new
			left: (tokens second reject: [ :item | item = $, ] thenCollect: #first);
			right: tokens sixth;
			yourself ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> updateDeleteWhereClause [
	^ super updateDeleteWhereClause ==> [ :tokens |
		|node|
		node := PSQLASTUpdateDeleteWhereClause new.
		tokens second isArray
			ifTrue: [ node currentOfCursor: tokens second third ]
			ifFalse: [ node condition: tokens second ].
		node ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> withClause [
	^ super withClause ==> [ :tokens |
		PSQLASTWithClause new
			isRecursive: tokens second isNotNil;
			queries: (tokens third reject: [ :item | item = $, ]);
			yourself ]
]

{ #category : #shared }
PSQLSharedASTBuilder >> withQuery [
	^ super withQuery ==> [ :tokens |
		(PSQLASTTableAlias new
			identifier: tokens first;
			columnAliases: (tokens second ifNotNil: [ :array | array second reject: [ :token | token = $, ] ]  ifNil: [ #() ]);
			yourself) -> tokens fifth ]
]
