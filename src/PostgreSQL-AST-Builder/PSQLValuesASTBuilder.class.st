"
I process VALUES command source code as input and build an AST using PSQLASTNode subclasses.
"
Class {
	#name : #PSQLValuesASTBuilder,
	#superclass : #PSQLValuesGrammar,
	#category : #'PostgreSQL-AST-Builder'
}

{ #category : #accessing }
PSQLValuesASTBuilder class >> sqlParser [
	^ PSQLExpressionASTBuilder
]

{ #category : #accessing }
PSQLValuesASTBuilder class >> tokenParser [
	^ PSQLTokenASTBuilder
]

{ #category : #accessing }
PSQLValuesASTBuilder >> expression [
	^ (self dependencyAt: PSQLExpressionASTBuilder) expression
]

{ #category : #'values command' }
PSQLValuesASTBuilder >> valuesCommand [
	^ super valuesCommand psqlASTBuild: [ :tokens |
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
