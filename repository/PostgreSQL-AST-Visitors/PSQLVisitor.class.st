"
I am an abstract visitor defining the interface common to all AST visitors.
"
Class {
	#name : #PSQLVisitor,
	#superclass : #Object,
	#category : #PostgreSQL-AST-Visitors-Core
}

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTAggregateFunctionCall: aPSQLASTAggregateFunctionCall [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTAllClause: aPSQLASTAllClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTAlternativeSelectIntoQuery: aPSQLASTAlternativeSelectIntoQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTArrayConstructor: aPSQLASTArrayConstructor [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTAttributeAccess: aPSQLASTAttributeAccess [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTBinaryOperator: aPSQLASTBinaryOperator [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTColumnDefinition: aPSQLASTColumnDefinition [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTCompositeValue: aPSQLASTCompositeValue [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTConditionalExpression: aPSQLASTConditionalExpression [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTConflictAction: aPSQLASTConflictAction [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTDefaultValue: aPSQLASTDefaultValue [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTDefaultValues: aPSQLASTDefaultValues [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTDeleteQuery: aPSQLASTDeleteQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTDistinctClause: aPSQLASTDistinctClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTExceptClause: aPSQLASTExceptClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFetchClause: aPSQLASTFetchClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTForClause: aPSQLASTForClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFromClause: aPSQLASTFromClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFromClauseItemType1: aPSQLASTFromClauseItemType1 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFromClauseItemType2: aPSQLASTFromClauseItemType2 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFromClauseItemType3: aPSQLASTFromClauseItemType3 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFromClauseItemType4: aPSQLASTFromClauseItemType4 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFromClauseItemType5: aPSQLASTFromClauseItemType5 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFromClauseItemType6: aPSQLASTFromClauseItemType6 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFromClauseItemType7: aPSQLASTFromClauseItemType7 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTFunctionCall: aPSQLASTFunctionCall [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTGroupByClause: aPSQLASTGroupByClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTHavingClause: aPSQLASTHavingClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTIdentifier: aPSQLASTIdentifier [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTInsertQuery: aPSQLASTInsertQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTIntersectClause: aPSQLASTIntersectClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTIntoClause: aPSQLASTIntoClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTLimitClause: aPSQLASTLimitClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTNumericConstant: aPSQLASTNumericConstant [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTOffsetClause: aPSQLASTOffsetClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTOnConflictClause: aPSQLASTOnConflictClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTOrderByClause: aPSQLASTOrderByClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTOrderByClauseItem: aPSQLASTOrderByClauseItem [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTParenthesedExpression: aPSQLASTParenthesedExpression [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTPostfixOperator: aPSQLASTPostfixOperator [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTPrefixOperator: aPSQLASTPrefixOperator [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTReturningClause: aPSQLASTReturningClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTSelectIntoQuery: aPSQLASTSelectIntoQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTSelectQuery: aPSQLASTSelectQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTSelectWhereClause: aPSQLASTSelectWhereClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTSetClause: aPSQLASTSetClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTSetClauseItemType1: aPSQLASTSetClauseItemType1 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTSetClauseItemType2: aPSQLASTSetClauseItemType2 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTSetClauseItemType3: aPSQLASTSetClauseItemType3 [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTStringConstant: aPSQLASTStringConstant [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTSubscript: aPSQLASTSubscript [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTTableAlias: aPSQLASTTableAlias [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTUnionClause: aPSQLASTUnionClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTUpdateDeleteWhereClause: aPSQLASTUpdateDeleteWhereClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTUpdateQuery: aPSQLASTUpdateQuery [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTWildCard: aPSQLASTWildCard [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLASTWithClause: aPSQLASTWithClause [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTAliasDeclaration: aPSQLPlpgSQLASTAliasDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTArrayLoop: aPSQLPlpgSQLASTArrayLoop [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTAssignment: aPSQLPlpgSQLASTAssignment [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTBlock: aPSQLPlpgSQLASTBlock [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTBlockLabel: aPSQLPlpgSQLASTBlockLabel [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTClassicDeclaration: aPSQLPlpgSQLASTClassicDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTContinue: aPSQLPlpgSQLASTContinue [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTCopyTypeDeclaration: aPSQLPlpgSQLASTCopyTypeDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTForLoop: aPSQLPlpgSQLASTForLoop [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTIf: aPSQLPlpgSQLASTIf [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTPositionalParameter: aPSQLPlpgSQLASTPositionalParameter [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTQueryResultsLoop: aPSQLPlpgSQLASTQueryResultsLoop [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTRaiseStatement: aPSQLPlpgSQLASTRaiseStatement [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTRecordDeclaration: aPSQLPlpgSQLASTRecordDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTReturnStatement: aPSQLPlpgSQLASTReturnStatement [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTRowTypeDeclaration: aPSQLPlpgSQLASTRowTypeDeclaration [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTSearchedCase: aPSQLPlpgSQLASTSearchedCase [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTSimpleCase: aPSQLPlpgSQLASTSimpleCase [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTType: aPSQLPlpgSQLASTType [
	^ self subclassResponsibility
]

{ #category : #visiting }
PSQLVisitor >> visitPSQLPlpgSQLASTWhileLoop: aPSQLPlpgSQLASTWhileLoop [
	^ self subclassResponsibility
]
