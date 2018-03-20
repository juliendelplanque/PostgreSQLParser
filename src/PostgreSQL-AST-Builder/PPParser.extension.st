Extension { #name : #PPParser }

{ #category : #'*PostgreSQL-AST-Builder' }
PPParser >> psqlASTBuild: aBlock [
	^ self token ==> [ :petitToken |
		|result|
		result := aBlock value: petitToken parsedValue.
		result isPSQLASTNode
			ifFalse: [ result ]
			ifTrue: [ 
				result
					startPosition: petitToken start;
					endPosition: petitToken stop;
					yourself ] ]
]
