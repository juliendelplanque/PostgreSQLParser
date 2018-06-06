Extension { #name : #FmxSQLLocalVariable }

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLLocalVariable >> createReferenceEntityFrom: aFmxSQLEntity [
	| localVariableAccess |
	localVariableAccess := FmxSQLLocalVariableAccess new
		localVariable: self;
		yourself.
	aFmxSQLEntity references add: localVariableAccess.
	^ localVariableAccess
]

{ #category : #'*PostgreSQL-AST-Visitors' }
FmxSQLLocalVariable >> reachableEntities [
	^ self type ifNil: [ #() ] ifNotNil: [ :aType | aType reachableEntities ]
]
