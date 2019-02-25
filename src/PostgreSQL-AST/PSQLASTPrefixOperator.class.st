"
I represent a prefix operator.
"
Class {
	#name : #PSQLASTPrefixOperator,
	#superclass : #PSQLASTOperator,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTPrefixOperator >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTPrefixOperator: self
]

{ #category : #printing }
PSQLASTPrefixOperator >> innerPrintOn: aStream [
	aStream
		<< self operator;
		<< Character space.
		
	self expression innerPrintOn: aStream.
]

{ #category : #testing }
PSQLASTPrefixOperator >> isPrefixOperator [
	^ true
]
