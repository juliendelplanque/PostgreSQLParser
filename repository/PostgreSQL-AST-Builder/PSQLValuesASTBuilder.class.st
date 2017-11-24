"
I process VALUS command source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLValuesASTBuilder,
	#superclass : #PSQLValuesGrammar,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLValuesASTBuilder class >> dependencies [
	^ { PSQLASTBuilder }
]

{ #category : #accessing }
PSQLValuesASTBuilder >> expression [
	^ (self dependencyAt: PSQLASTBuilder) expression
]

{ #category : #'values command' }
PSQLValuesASTBuilder >> valuesCommand [
	^ super valuesCommand ==> [ :tokens |
		tokens second
			reject: [ :item | item = $, ]
			thenCollect: [ :item | 
				item first second
					reject: [ :subitem | subitem = $, ]
					thenCollect: [ :subItem |
						subItem first = 'DEFAULT'
							ifTrue: [ PSQLASTDefaultValue new ]
							ifFalse: [ subItem first ] ] ] ]
]
