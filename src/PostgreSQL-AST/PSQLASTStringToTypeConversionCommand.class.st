Class {
	#name : #PSQLASTStringToTypeConversionCommand,
	#superclass : #PSQLASTNode,
	#instVars : [
		'identifiersBefore',
		'stringConstant',
		'identifiersAfter'
	],
	#category : #'PostgreSQL-AST'
}

{ #category : #visiting }
PSQLASTStringToTypeConversionCommand >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTStringToTypeConversionCommand: self
]

{ #category : #accessing }
PSQLASTStringToTypeConversionCommand >> identifiersAfter [
	^ identifiersAfter
]

{ #category : #accessing }
PSQLASTStringToTypeConversionCommand >> identifiersAfter: anObject [
	identifiersAfter := anObject
]

{ #category : #accessing }
PSQLASTStringToTypeConversionCommand >> identifiersBefore [
	^ identifiersBefore
]

{ #category : #accessing }
PSQLASTStringToTypeConversionCommand >> identifiersBefore: anObject [
	identifiersBefore := anObject
]

{ #category : #accessing }
PSQLASTStringToTypeConversionCommand >> stringConstant [
	^ stringConstant
]

{ #category : #accessing }
PSQLASTStringToTypeConversionCommand >> stringConstant: anObject [
	stringConstant := anObject
]
