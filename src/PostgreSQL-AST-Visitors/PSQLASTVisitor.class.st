"
I am an abstract visitor, superclass of all visitors of PSQL ast.
"
Class {
	#name : #PSQLASTVisitor,
	#superclass : #Object,
	#category : #'PostgreSQL-AST-Visitors'
}

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTAggregateFunctionCall: aPSQLASTAggregateFunctionCall [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTAllClause: aPSQLASTAllClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTAlternativeSelectIntoQuery: aPSQLASTAlternativeSelectIntoQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTArrayConstructor: aPSQLASTArrayConstructor [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTAttributeAccess: aPSQLASTAttributeAccess [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTBinaryOperator: aPSQLASTBinaryOperator [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTColumnDefinition: aPSQLASTColumnDefinition [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTCompositeValue: aPSQLASTCompositeValue [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTConditionalExpression: aPSQLASTConditionalExpression [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTConflictAction: aPSQLASTConflictAction [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTDefaultValue: aPSQLASTDefaultValue [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTDefaultValues: aPSQLASTDefaultValues [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTDeleteQuery: aPSQLASTDeleteQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTDistinctClause: aPSQLASTDistinctClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTExceptClause: aPSQLASTExceptClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFetchClause: aPSQLASTFetchClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTForClause: aPSQLASTForClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFromClause: aPSQLASTFromClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFromClauseItemType1: aPSQLASTFromClauseItemType1 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFromClauseItemType2: aPSQLASTFromClauseItemType2 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFromClauseItemType3: aPSQLASTFromClauseItemType3 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFromClauseItemType4: aPSQLASTFromClauseItemType4 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFromClauseItemType5: aPSQLASTFromClauseItemType5 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFromClauseItemType6: aPSQLASTFromClauseItemType6 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFromClauseItemType7: aPSQLASTFromClauseItemType7 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTFunctionCall: aPSQLASTFunctionCall [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTGroupByClause: aPSQLASTGroupByClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTHavingClause: aPSQLASTHavingClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTIdentifier: aPSQLASTIdentifier [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTInsertQuery: aPSQLASTInsertQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTIntersectClause: aPSQLASTIntersectClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTIntoClause: aPSQLASTIntoClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTLimitClause: aPSQLASTLimitClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTNumericConstant: aPSQLASTNumericConstant [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTOffsetClause: aPSQLASTOffsetClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTOnConflictClause: aPSQLASTOnConflictClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTOrderByClause: aPSQLASTOrderByClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTOrderByClauseItem: aPSQLASTOrderByClauseItem [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTParenthesedExpression: aPSQLASTParenthesedExpression [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTPostfixOperator: aPSQLASTPostfixOperator [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTPrefixOperator: aPSQLASTPrefixOperator [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTReturningClause: aPSQLASTReturningClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTSelectIntoQuery: aPSQLASTSelectIntoQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTSelectQuery: aPSQLASTSelectQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTSelectWhereClause: aPSQLASTSelectWhereClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTSetClause: aPSQLASTSetClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTSetClauseItemType1: aPSQLASTSetClauseItemType1 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTSetClauseItemType2: aPSQLASTSetClauseItemType2 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTSetClauseItemType3: aPSQLASTSetClauseItemType3 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTStringConstant: aPSQLASTStringConstant [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTSubscript: aPSQLASTSubscript [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTTableAlias: aPSQLASTTableAlias [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTUnionClause: aPSQLASTUnionClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTUpdateDeleteWhereClause: aPSQLASTUpdateDeleteWhereClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTUpdateQuery: aPSQLASTUpdateQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTWildCard: aPSQLASTWildCard [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLASTWithClause: aPSQLASTWithClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTAliasDeclaration: aPSQLPlpgSQLASTAliasDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTArrayLoop: aPSQLPlpgSQLASTArrayLoop [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTAssignment: aPSQLPlpgSQLASTAssignment [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTBlock: aPSQLPlpgSQLASTBlock [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTBlockLabel: aPSQLPlpgSQLASTBlockLabel [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTClassicDeclaration: aPSQLPlpgSQLASTClassicDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTContinue: aPSQLPlpgSQLASTContinue [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCopyTypeDeclaration: aPSQLPlpgSQLASTCopyTypeDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorClose: aPSQLPlpgSQLASTCursorClose [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorDeclaration: aPSQLPlpgSQLASTCursorDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorDelete: aPSQLPlpgSQLASTCursorDelete [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorFetch: aPSQLPlpgSQLASTCursorFetch [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorFetchDirection: aPSQLPlpgSQLASTCursorFetchDirection [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorMove: aPSQLPlpgSQLASTCursorMove [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorMoveDirection: aPSQLPlpgSQLASTCursorMoveDirection [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorOpenForQuery: aPSQLPlpgSQLASTCursorOpenForQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTCursorStatement: aPSQLPlpgSQLASTCursorStatement [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTForLoop: aPSQLPlpgSQLASTForLoop [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTIf: aPSQLPlpgSQLASTIf [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTLoop: aPSQLPlpgSQLASTLoop [ 
	self subclassResponsibility.
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTPerform: aPSQLPlpgSQLASTPerform [ 
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTPositionalParameter: aPSQLPlpgSQLASTPositionalParameter [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTQueryResultsLoop: aPSQLPlpgSQLASTQueryResultsLoop [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTRaiseStatement: aPSQLPlpgSQLASTRaiseStatement [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTRecordDeclaration: aPSQLPlpgSQLASTRecordDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTReturnStatement: aPSQLPlpgSQLASTReturnStatement [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTRowTypeDeclaration: aPSQLPlpgSQLASTRowTypeDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTSearchedCase: aPSQLPlpgSQLASTSearchedCase [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTSimpleCase: aPSQLPlpgSQLASTSimpleCase [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTType: aPSQLPlpgSQLASTType [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLASTWhileLoop: aPSQLPlpgSQLASTWhileLoop [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTVisitor >> visitPSQLPlpgSQLCursorUpdate: aPSQLPlpgSQLCursorUpdate [
	^ self subclassResponsibility
]
