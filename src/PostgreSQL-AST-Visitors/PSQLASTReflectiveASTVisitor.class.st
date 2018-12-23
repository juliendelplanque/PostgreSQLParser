"
Use reflexivity to visit all nodes in an uniform way through #visitPSQLASTNode: method.
"
Class {
	#name : #PSQLASTReflectiveASTVisitor,
	#superclass : #PSQLASTVisitor,
	#category : #'PostgreSQL-AST-Visitors'
}

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQASTNull: aPSQLASTNull [
	^ self visitPSQLASTNode: aPSQLASTNull
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTAggregateFunctionCall: aPSQLASTAggregateFunctionCall [
	^ self visitPSQLASTNode: aPSQLASTAggregateFunctionCall
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTAliasDefinition: aPSQLASTAliasDefinition [
	^ self visitPSQLASTNode: aPSQLASTAliasDefinition
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTAllClause: aPSQLASTAllClause [
	^ self visitPSQLASTNode: aPSQLASTAllClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTAlternativeSelectIntoQuery: aPSQLASTAlternativeSelectIntoQuery [
	^ self visitPSQLASTNode: aPSQLASTAlternativeSelectIntoQuery
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTArgument: aPSQLASTArgument [
	^ self visitPSQLASTNode: aPSQLASTArgument
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTArrayConstructor: aPSQLASTArrayConstructor [
	^ self visitPSQLASTNode: aPSQLASTArrayConstructor
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTAttributeAccess: aPSQLASTAttributeAccess [
	^ self visitPSQLASTNode: aPSQLASTAttributeAccess
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTBinaryOperator: aPSQLASTBinaryOperator [
	^ self visitPSQLASTNode: aPSQLASTBinaryOperator
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTCaseExpression: aPSQLASTCaseExpression [
	^ self visitPSQLASTNode: aPSQLASTCaseExpression
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTCaseToExpression: aPSQLASTCaseToExpression [
	^ self visitPSQLASTNode: aPSQLASTCaseToExpression
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTCastExpression: aPSQLASTCastExpression [
	^ self visitPSQLASTNode: aPSQLASTCastExpression
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTColumnDefinition: aPSQLASTColumnDefinition [
	^ self visitPSQLASTNode: aPSQLASTColumnDefinition
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTCompositeValue: aPSQLASTCompositeValue [
	^ self visitPSQLASTNode: aPSQLASTCompositeValue
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTConditionToExpression: aPSQLASTConditionToExpression [
	^ self visitPSQLASTNode: aPSQLASTConditionToExpression
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTConditionalExpression: aPSQLASTConditionalExpression [
	^ self visitPSQLASTNode: aPSQLASTConditionalExpression
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTConflictAction: aPSQLASTConflictAction [
	^ self visitPSQLASTNode: aPSQLASTConflictAction
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTCursorParameter: aPSQLASTCursorParameter [
	^ self visitPSQLASTNode: aPSQLASTCursorParameter
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTDefaultValue: aPSQLASTDefaultValue [
	^ self visitPSQLASTNode: aPSQLASTDefaultValue
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTDefaultValues: aPSQLASTDefaultValues [
	^ self visitPSQLASTNode: aPSQLASTDefaultValues
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTDeleteQuery: aPSQLASTDeleteQuery [
	^ self visitPSQLASTNode: aPSQLASTDeleteQuery
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTDistinctClause: aPSQLASTDistinctClause [
	^ self visitPSQLASTNode: aPSQLASTDistinctClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTExceptClause: aPSQLASTExceptClause [
	^ self visitPSQLASTNode: aPSQLASTExceptClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTExceptionCase: aPSQLASTExceptionCase [
	^ self visitPSQLASTNode: aPSQLASTExceptionCase
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTExceptionHandler: aPSQLASTExceptionHandler [
	^ self visitPSQLASTNode: aPSQLASTExceptionHandler
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTExtractFunctionCall: aPSQLASTExtractFunctionCall [
	^ self visitPSQLASTNode: aPSQLASTExtractFunctionCall
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFetchClause: aPSQLASTFetchClause [
	^ self visitPSQLASTNode: aPSQLASTFetchClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTForClause: aPSQLASTForClause [
	^ self visitPSQLASTNode: aPSQLASTForClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFromClause: aPSQLASTFromClause [
	^ self visitPSQLASTNode: aPSQLASTFromClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFromClauseItemType1: aPSQLASTFromClauseItemType1 [
	^ self visitPSQLASTNode: aPSQLASTFromClauseItemType1
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFromClauseItemType2: aPSQLASTFromClauseItemType2 [
	^ self visitPSQLASTNode: aPSQLASTFromClauseItemType2
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFromClauseItemType3: aPSQLASTFromClauseItemType3 [
	^ self visitPSQLASTNode: aPSQLASTFromClauseItemType3
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFromClauseItemType4: aPSQLASTFromClauseItemType4 [
	^ self visitPSQLASTNode: aPSQLASTFromClauseItemType4
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFromClauseItemType5: aPSQLASTFromClauseItemType5 [
	^ self visitPSQLASTNode: aPSQLASTFromClauseItemType5
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFromClauseItemType6: aPSQLASTFromClauseItemType6 [
	^ self visitPSQLASTNode: aPSQLASTFromClauseItemType6
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFromClauseItemType7: aPSQLASTFromClauseItemType7 [
	^ self visitPSQLASTNode: aPSQLASTFromClauseItemType7
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTFunctionCall: aPSQLASTFunctionCall [
	^ self visitPSQLASTNode: aPSQLASTFunctionCall
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTGroupByClause: aPSQLASTGroupByClause [
	^ self visitPSQLASTNode: aPSQLASTGroupByClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTHavingClause: aPSQLASTHavingClause [
	^ self visitPSQLASTNode: aPSQLASTHavingClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTIdentifier: aPSQLASTIdentifier [
	^ self visitPSQLASTNode: aPSQLASTIdentifier
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTInsertQuery: aPSQLASTInsertQuery [
	^ self visitPSQLASTNode: aPSQLASTInsertQuery
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTIntersectClause: aPSQLASTIntersectClause [
	^ self visitPSQLASTNode: aPSQLASTIntersectClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTIntoClause: aPSQLASTIntoClause [
	^ self visitPSQLASTNode: aPSQLASTIntoClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTLimitClause: aPSQLASTLimitClause [
	^ self visitPSQLASTNode: aPSQLASTLimitClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTNode: aPSQLASTNode [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTNumericConstant: aPSQLASTNumericConstant [
	^ self visitPSQLASTNode: aPSQLASTNumericConstant
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTOffsetClause: aPSQLASTOffsetClause [
	^ self visitPSQLASTNode: aPSQLASTOffsetClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTOnConflictClause: aPSQLASTOnConflictClause [
	^ self visitPSQLASTNode: aPSQLASTOnConflictClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTOrderByClause: aPSQLASTOrderByClause [
	^ self visitPSQLASTNode: aPSQLASTOrderByClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTOrderByClauseItem: aPSQLASTOrderByClauseItem [
	^ self visitPSQLASTNode: aPSQLASTOrderByClauseItem
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTParenthesedExpression: aPSQLASTParenthesedExpression [
	^ self visitPSQLASTNode: aPSQLASTParenthesedExpression
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTPostfixOperator: aPSQLASTPostfixOperator [
	^ self visitPSQLASTNode: aPSQLASTPostfixOperator
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTPrefixOperator: aPSQLASTPrefixOperator [
	^ self visitPSQLASTNode: aPSQLASTPrefixOperator
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTReturningClause: aPSQLASTReturningClause [
	^ self visitPSQLASTNode: aPSQLASTReturningClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTSelectIntoQuery: aPSQLASTSelectIntoQuery [
	^ self visitPSQLASTNode: aPSQLASTSelectIntoQuery
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTSelectQuery: aPSQLASTSelectQuery [
	^ self visitPSQLASTNode: aPSQLASTSelectQuery
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTSelectWhereClause: aPSQLASTSelectWhereClause [
	^ self visitPSQLASTNode: aPSQLASTSelectWhereClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTSetClause: aPSQLASTSetClause [
	^ self visitPSQLASTNode: aPSQLASTSetClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTSetClauseItemType1: aPSQLASTSetClauseItemType1 [
	^ self visitPSQLASTNode: aPSQLASTSetClauseItemType1
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTSetClauseItemType2: aPSQLASTSetClauseItemType2 [
	^ self visitPSQLASTNode: aPSQLASTSetClauseItemType2
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTSetClauseItemType3: aPSQLASTSetClauseItemType3 [
	^ self visitPSQLASTNode: aPSQLASTSetClauseItemType3
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTStringConstant: aPSQLASTStringConstant [
	^ self visitPSQLASTNode: aPSQLASTStringConstant
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTSubscript: aPSQLASTSubscript [
	^ self visitPSQLASTNode: aPSQLASTSubscript
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTTableAlias: aPSQLASTTableAlias [
	^ self visitPSQLASTNode: aPSQLASTTableAlias
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTUnionClause: aPSQLASTUnionClause [
	^ self visitPSQLASTNode: aPSQLASTUnionClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTUpdateDeleteWhereClause: aPSQLASTUpdateDeleteWhereClause [
	^ self visitPSQLASTNode: aPSQLASTUpdateDeleteWhereClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTUpdateQuery: aPSQLASTUpdateQuery [
	^ self visitPSQLASTNode: aPSQLASTUpdateQuery
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTUsingClause: aPSQLASTUsingClause [
	^ self visitPSQLASTNode: aPSQLASTUsingClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTValuesClause: aPSQLASTValuesClause [
	^ self visitPSQLASTNode: aPSQLASTValuesClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTValuesCommand: aPSQLASTValuesCommand [
	^ self visitPSQLASTNode: aPSQLASTValuesCommand
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTWhenExpression: aPSQLASTWhenExpression [
	^ self visitPSQLASTNode: aPSQLASTWhenExpression
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTWildCard: aPSQLASTWildCard [
	^ self visitPSQLASTNode: aPSQLASTWildCard
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLASTWithClause: aPSQLASTWithClause [
	^ self visitPSQLASTNode: aPSQLASTWithClause
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTAliasDeclaration: aPSQLPlpgSQLASTAliasDeclaration [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTAliasDeclaration
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTArrayLoop: aPSQLPlpgSQLASTArrayLoop [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTArrayLoop
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTAssignment: aPSQLPlpgSQLASTAssignment [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTAssignment
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTBlock: aPSQLPlpgSQLASTBlock [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTBlock
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTBlockLabel: aPSQLPlpgSQLASTBlockLabel [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTBlockLabel
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCasesToStatements: aPSQLPlpgSQLASTCasesToStatements [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCasesToStatements
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTClassicDeclaration: aPSQLPlpgSQLASTClassicDeclaration [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTClassicDeclaration
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTConditionToStatements: aPSQLPlpgSQLASTConditionToStatements [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTConditionToStatements
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTContinue: aPSQLPlpgSQLASTContinue [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTContinue
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCopyTypeDeclaration: aPSQLPlpgSQLASTCopyTypeDeclaration [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCopyTypeDeclaration
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorClose: aPSQLPlpgSQLASTCursorClose [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorClose
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorDeclaration: aPSQLPlpgSQLASTCursorDeclaration [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorDeclaration
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorDelete: aPSQLPlpgSQLASTCursorDelete [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorDelete
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorFetch: aPSQLPlpgSQLASTCursorFetch [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorFetch
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorFetchDirection: aPSQLPlpgSQLASTCursorFetchDirection [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorFetchDirection
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorMove: aPSQLPlpgSQLASTCursorMove [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorMove
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorMoveDirection: aPSQLPlpgSQLASTCursorMoveDirection [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorMoveDirection
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorOpen: aPSQLPlpgSQLASTCursorOpen [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorOpen
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorOpenForQuery: aPSQLPlpgSQLASTCursorOpenForQuery [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorOpenForQuery
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTCursorStatement: aPSQLPlpgSQLASTCursorStatement [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTCursorStatement
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTForLoop: aPSQLPlpgSQLASTForLoop [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTForLoop
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTIf: aPSQLPlpgSQLASTIf [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTIf
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTLoop: aPSQLPlpgSQLASTLoop [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTLoop
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTPerform: aPSQLPlpgSQLASTPerform [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTPerform
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTPositionalParameter: aPSQLPlpgSQLASTPositionalParameter [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTPositionalParameter
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTQueryResultsLoop: aPSQLPlpgSQLASTQueryResultsLoop [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTQueryResultsLoop
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTRaiseStatement: aPSQLPlpgSQLASTRaiseStatement [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTRaiseStatement
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTRecordDeclaration: aPSQLPlpgSQLASTRecordDeclaration [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTRecordDeclaration
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTReturnStatement: aPSQLPlpgSQLASTReturnStatement [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTReturnStatement
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTRowTypeDeclaration: aPSQLPlpgSQLASTRowTypeDeclaration [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTRowTypeDeclaration
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTSearchedCase: aPSQLPlpgSQLASTSearchedCase [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTSearchedCase
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTSimpleCase: aPSQLPlpgSQLASTSimpleCase [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTSimpleCase
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTType: aPSQLPlpgSQLASTType [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTType
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLASTWhileLoop: aPSQLPlpgSQLASTWhileLoop [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTWhileLoop
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQLPlpgSQLCursorUpdate: aPSQLPlpgSQLCursorUpdate [
	^ self visitPSQLASTNode: aPSQLPlpgSQLCursorUpdate
]

{ #category : #visiting }
PSQLASTReflectiveASTVisitor >> visitPSQPlpgSQLASTExit: aPSQLPlpgSQLASTExit [
	^ self visitPSQLASTNode: aPSQLPlpgSQLASTExit
]
