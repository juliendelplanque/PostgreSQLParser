Class {
	#name : #PSQLASTReflectiveVisitor,
	#superclass : #PSQLASTVisitor,
	#instVars : [
		'model',
		'function'
	],
	#category : #'PostgreSQL-AST-Visitors'
}

{ #category : #'instance creation' }
PSQLASTReflectiveVisitor class >> model: aMooseModel function: aFunction [
	^ self new
		model: aMooseModel;
		function: aFunction;
		yourself
]

{ #category : #children }
PSQLASTReflectiveVisitor >> childrenFor: aNode [
	^ aNode class instanceVariables
		flatCollect: [ :instanceVar | 
			(aNode perform: instanceVar)
				in: [ :varContent | 
					varContent isPSQLASTNode
						ifFalse: [ (varContent isString not and: [ varContent isCollection ])
								ifTrue: [ varContent ]
								ifFalse: [ {} ] ]
						ifTrue: [ varContent asCollection ] ] ]
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> function [
	^ function
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> function: anObject [
	function := anObject
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> model [
	^ model
]

{ #category : #accessing }
PSQLASTReflectiveVisitor >> model: anObject [
	model := anObject
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAggregateFunctionCall: aPSQLASTAggregateFunctionCall [
	(self childrenFor: aPSQLASTAggregateFunctionCall) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAllClause: aPSQLASTAllClause [
	(self childrenFor: aPSQLASTAllClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAlternativeSelectIntoQuery: aPSQLASTAlternativeSelectIntoQuery [
	(self childrenFor: aPSQLASTAlternativeSelectIntoQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTArrayConstructor: aPSQLASTArrayConstructor [
	(self childrenFor: aPSQLASTArrayConstructor) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTAttributeAccess: aPSQLASTAttributeAccess [
	(self childrenFor: aPSQLASTAttributeAccess) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTBinaryOperator: aPSQLASTBinaryOperator [
	(self childrenFor: aPSQLASTBinaryOperator) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTColumnDefinition: aPSQLASTColumnDefinition [
	(self childrenFor: aPSQLASTColumnDefinition) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTCompositeValue: aPSQLASTCompositeValue [
	(self childrenFor: aPSQLASTCompositeValue) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTConditionalExpression: aPSQLASTConditionalExpression [
	(self childrenFor: aPSQLASTConditionalExpression) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTConflictAction: aPSQLASTConflictAction [
	(self childrenFor: aPSQLASTConflictAction) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDefaultValue: aPSQLASTDefaultValue [
	(self childrenFor: aPSQLASTDefaultValue) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDefaultValues: aPSQLASTDefaultValues [
	(self childrenFor: aPSQLASTDefaultValues) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDeleteQuery: aPSQLASTDeleteQuery [
	(self childrenFor: aPSQLASTDeleteQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTDistinctClause: aPSQLASTDistinctClause [
	(self childrenFor: aPSQLASTDistinctClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTExceptClause: aPSQLASTExceptClause [
	(self childrenFor: aPSQLASTExceptClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFetchClause: aPSQLASTFetchClause [
	(self childrenFor: aPSQLASTFetchClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTForClause: aPSQLASTForClause [
	(self childrenFor: aPSQLASTForClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClause: aPSQLASTFromClause [
	(self childrenFor: aPSQLASTFromClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType1: aPSQLASTFromClauseItemType1 [
	(self childrenFor: aPSQLASTFromClauseItemType1) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType2: aPSQLASTFromClauseItemType2 [
	(self childrenFor: aPSQLASTFromClauseItemType2) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType3: aPSQLASTFromClauseItemType3 [
	(self childrenFor: aPSQLASTFromClauseItemType3) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType4: aPSQLASTFromClauseItemType4 [
	(self childrenFor: aPSQLASTFromClauseItemType4) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType5: aPSQLASTFromClauseItemType5 [
	(self childrenFor: aPSQLASTFromClauseItemType5) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType6: aPSQLASTFromClauseItemType6 [
	(self childrenFor: aPSQLASTFromClauseItemType6) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFromClauseItemType7: aPSQLASTFromClauseItemType7 [
	(self childrenFor: aPSQLASTFromClauseItemType7) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTFunctionCall: aPSQLASTFunctionCall [
	(self childrenFor: aPSQLASTFunctionCall) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTGroupByClause: aPSQLASTGroupByClause [
	(self childrenFor: aPSQLASTGroupByClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTHavingClause: aPSQLASTHavingClause [
	(self childrenFor: aPSQLASTHavingClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTIdentifier: aPSQLASTIdentifier [
	function
		addCallTargeting: ((self model allWithType: FmxSQLStoredProcedure) detect: [ :procedure | procedure name = aPSQLASTIdentifier identifier ])
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTInsertQuery: aPSQLASTInsertQuery [
	(self childrenFor: aPSQLASTInsertQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTIntersectClause: aPSQLASTIntersectClause [
	(self childrenFor: aPSQLASTIntersectClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTIntoClause: aPSQLASTIntoClause [
	(self childrenFor: aPSQLASTIntoClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTLimitClause: aPSQLASTLimitClause [
	(self childrenFor: aPSQLASTLimitClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTNumericConstant: aPSQLASTNumericConstant [
	(self childrenFor: aPSQLASTNumericConstant) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOffsetClause: aPSQLASTOffsetClause [
	(self childrenFor: aPSQLASTOffsetClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOnConflictClause: aPSQLASTOnConflictClause [
	(self childrenFor: aPSQLASTOnConflictClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOrderByClause: aPSQLASTOrderByClause [
	(self childrenFor: aPSQLASTOrderByClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTOrderByClauseItem: aPSQLASTOrderByClauseItem [
	(self childrenFor: aPSQLASTOrderByClauseItem) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTParenthesedExpression: aPSQLASTParenthesedExpression [
	(self childrenFor: aPSQLASTParenthesedExpression) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTPostfixOperator: aPSQLASTPostfixOperator [
	(self childrenFor: aPSQLASTPostfixOperator) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTPrefixOperator: aPSQLASTPrefixOperator [
	(self childrenFor: aPSQLASTPrefixOperator) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTReturningClause: aPSQLASTReturningClause [
	(self childrenFor: aPSQLASTReturningClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSelectIntoQuery: aPSQLASTSelectIntoQuery [
	(self childrenFor: aPSQLASTSelectIntoQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSelectQuery: aPSQLASTSelectQuery [
	(self childrenFor: aPSQLASTSelectQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSelectWhereClause: aPSQLASTSelectWhereClause [
	(self childrenFor: aPSQLASTSelectWhereClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSetClause: aPSQLASTSetClause [
	(self childrenFor: aPSQLASTSetClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSetClauseItemType1: aPSQLASTSetClauseItemType1 [
	(self childrenFor: aPSQLASTSetClauseItemType1) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSetClauseItemType2: aPSQLASTSetClauseItemType2 [
	(self childrenFor: aPSQLASTSetClauseItemType2) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSetClauseItemType3: aPSQLASTSetClauseItemType3 [
	(self childrenFor: aPSQLASTSetClauseItemType3) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTStringConstant: aPSQLASTStringConstant [
	(self childrenFor: aPSQLASTStringConstant) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTSubscript: aPSQLASTSubscript [
	(self childrenFor: aPSQLASTSubscript) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTTableAlias: aPSQLASTTableAlias [
	(self childrenFor: aPSQLASTTableAlias) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUnionClause: aPSQLASTUnionClause [
	(self childrenFor: aPSQLASTUnionClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUpdateDeleteWhereClause: aPSQLASTUpdateDeleteWhereClause [
	(self childrenFor: aPSQLASTUpdateDeleteWhereClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTUpdateQuery: aPSQLASTUpdateQuery [
	(self childrenFor: aPSQLASTUpdateQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTWildCard: aPSQLASTWildCard [
	(self childrenFor: aPSQLASTWildCard) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLASTWithClause: aPSQLASTWithClause [
	(self childrenFor: aPSQLASTWithClause) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTAliasDeclaration: aPSQLPlpgSQLASTAliasDeclaration [
	(self childrenFor: aPSQLPlpgSQLASTAliasDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTArrayLoop: aPSQLPlpgSQLASTArrayLoop [
	(self childrenFor: aPSQLPlpgSQLASTArrayLoop) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTAssignment: aPSQLPlpgSQLASTAssignment [
	(self childrenFor: aPSQLPlpgSQLASTAssignment) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTBlock: aPSQLPlpgSQLASTBlock [
	(self childrenFor: aPSQLPlpgSQLASTBlock) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTBlockLabel: aPSQLPlpgSQLASTBlockLabel [
	(self childrenFor: aPSQLPlpgSQLASTBlockLabel) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTClassicDeclaration: aPSQLPlpgSQLASTClassicDeclaration [
	(self childrenFor: aPSQLPlpgSQLASTClassicDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTContinue: aPSQLPlpgSQLASTContinue [
	(self childrenFor: aPSQLPlpgSQLASTContinue) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCopyTypeDeclaration: aPSQLPlpgSQLASTCopyTypeDeclaration [
	(self childrenFor: aPSQLPlpgSQLASTCopyTypeDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorClose: aPSQLPlpgSQLASTCursorClose [
	(self childrenFor: aPSQLPlpgSQLASTCursorClose) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorDeclaration: aPSQLPlpgSQLASTCursorDeclaration [
	(self childrenFor: aPSQLPlpgSQLASTCursorDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorDelete: aPSQLPlpgSQLASTCursorDelete [
	(self childrenFor: aPSQLPlpgSQLASTCursorDelete) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorFetch: aPSQLPlpgSQLASTCursorFetch [
	(self childrenFor: aPSQLPlpgSQLASTCursorFetch) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorFetchDirection: aPSQLPlpgSQLASTCursorFetchDirection [
	(self childrenFor: aPSQLPlpgSQLASTCursorFetchDirection) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorMove: aPSQLPlpgSQLASTCursorMove [
	(self childrenFor: aPSQLPlpgSQLASTCursorMove) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorMoveDirection: aPSQLPlpgSQLASTCursorMoveDirection [
	(self childrenFor: aPSQLPlpgSQLASTCursorMoveDirection) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorOpenForQuery: aPSQLPlpgSQLASTCursorOpenForQuery [
	(self childrenFor: aPSQLPlpgSQLASTCursorOpenForQuery) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTCursorStatement: aPSQLPlpgSQLASTCursorStatement [
	(self childrenFor: aPSQLPlpgSQLASTCursorStatement) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTForLoop: aPSQLPlpgSQLASTForLoop [
	(self childrenFor: aPSQLPlpgSQLASTForLoop) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTIf: aPSQLPlpgSQLASTIf [
	(self childrenFor: aPSQLPlpgSQLASTIf) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTPositionalParameter: aPSQLPlpgSQLASTPositionalParameter [
	(self childrenFor: aPSQLPlpgSQLASTPositionalParameter) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTQueryResultsLoop: aPSQLPlpgSQLASTQueryResultsLoop [
	(self childrenFor: aPSQLPlpgSQLASTQueryResultsLoop) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTRaiseStatement: aPSQLPlpgSQLASTRaiseStatement [
	(self childrenFor: aPSQLPlpgSQLASTRaiseStatement) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTRecordDeclaration: aPSQLPlpgSQLASTRecordDeclaration [
	(self childrenFor: aPSQLPlpgSQLASTRecordDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTReturnStatement: aPSQLPlpgSQLASTReturnStatement [
	(self childrenFor: aPSQLPlpgSQLASTReturnStatement) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTRowTypeDeclaration: aPSQLPlpgSQLASTRowTypeDeclaration [
	(self childrenFor: aPSQLPlpgSQLASTRowTypeDeclaration) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTSearchedCase: aPSQLPlpgSQLASTSearchedCase [
	(self childrenFor: aPSQLPlpgSQLASTSearchedCase) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTSimpleCase: aPSQLPlpgSQLASTSimpleCase [
	(self childrenFor: aPSQLPlpgSQLASTSimpleCase) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTType: aPSQLPlpgSQLASTType [
	(self childrenFor: aPSQLPlpgSQLASTType) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLASTWhileLoop: aPSQLPlpgSQLASTWhileLoop [
	(self childrenFor: aPSQLPlpgSQLASTWhileLoop) do: [:aChild | aChild acceptVisitor: self]
]

{ #category : #visiting }
PSQLASTReflectiveVisitor >> visitPSQLPlpgSQLCursorUpdate: aPSQLPlpgSQLCursorUpdate [
	(self childrenFor: aPSQLPlpgSQLCursorUpdate) do: [:aChild | aChild acceptVisitor: self]
]
