"
I am an abstract node of the AST. I define the common behaviour and state of all AST nodes.
"
Class {
	#name : #PSQLASTNode,
	#superclass : #Object,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #accessing }
PSQLASTNode class >> abstractSubClassNames [
	^ #(#PSQLASTCRUDQuery #PSQLASTConstant #PSQLASTExpressionASTNode #PSQLASTFromClauseItem #PSQLASTOperator #PSQLASTSetClauseItem #PSQLASTSetOperatorClause #PSQLPlpgSQLASTNode #PSQLPlpgSQLASTConditional #PSQLPlpgSQLASTDeclaration #PSQLPlpgSQLASTLoop #PSQLASTNode)
]

{ #category : #testing }
PSQLASTNode class >> isAbstract [
	^ self name = #PSQLASTNode or: [ self abstractSubClassNames includes: self name ]
]

{ #category : #accessing }
PSQLASTNode class >> withAllConcreteSubclasses [
	^ self withAllSubclasses reject: #isAbstract
]

{ #category : #printing }
PSQLASTNode >> innerPrintOn: aStream [
	"To override if needed."
]

{ #category : #printing }
PSQLASTNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $(.
	self innerPrintOn: aStream.
	aStream
		<< $)
]
