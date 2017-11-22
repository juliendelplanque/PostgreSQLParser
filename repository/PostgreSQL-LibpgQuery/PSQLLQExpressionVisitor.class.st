Class {
	#name : #PSQLLQExpressionVisitor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #visiting }
PSQLLQExpressionVisitor >> visitDictionary: aDictionary [
	self assert: aDictionary keys size = 1.
	self assert: (#('A_Expr' 'A_Const') includes: aDictionary keys first)
]
