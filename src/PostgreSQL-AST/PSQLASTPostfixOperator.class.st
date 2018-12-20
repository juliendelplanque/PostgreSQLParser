"
I represent a postfix operator.
"
Class {
	#name : #PSQLASTPostfixOperator,
	#superclass : #PSQLASTOperator,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTPostfixOperator >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTPostfixOperator: self
]

{ #category : #printing }
PSQLASTPostfixOperator >> innerPrintOn: aStream [
	self expression innerPrintOn: aStream.
	aStream
		<< Character space.
		
	self flag: #TODO.
	"Might be a PSQLASTArrayConstructor because of tricks in the parser."
	self operator class = PSQLASTArrayConstructor
		ifTrue: [ self operator innerPrintOn: aStream ]
		ifFalse: [ aStream << self operator ]
]
