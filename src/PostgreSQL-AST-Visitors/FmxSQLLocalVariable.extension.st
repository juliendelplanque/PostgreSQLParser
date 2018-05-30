Extension { #name : #FmxSQLLocalVariable }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLLocalVariable >> createReferenceEntityTo: aFmxSQLEntity [
	| localVariableAccess |
	localVariableAccess := FmxSQLLocalVariableAccess new
		localVariable: self;
		yourself.
	aFmxSQLEntity references add: localVariableAccess.
	^ localVariableAccess
]

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLLocalVariable >> reachableEntities [
	^ self type reachableEntities
]
