Class {
	#name : #PSQLAliasScope,
	#superclass : #PSQLScope,
	#instVars : [
		'aliasDefinition'
	],
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #'instance creation' }
PSQLAliasScope class >> alias: anAlias entity: aCorrespondingEntity [
	^ self new
		aliasDefinition:
			(PSQLAliasDefinition new
				alias: anAlias;
				entity: aCorrespondingEntity;
				yourself);
		yourself
]

{ #category : #accessing }
PSQLAliasScope >> aliasDefinition [
	^ aliasDefinition
]

{ #category : #accessing }
PSQLAliasScope >> aliasDefinition: anObject [
	aliasDefinition := anObject
]

{ #category : #accessing }
PSQLAliasScope >> isAlias [
	^ true
]

{ #category : #accessing }
PSQLAliasScope >> reachableEntities [
	^ {aliasDefinition}
]
