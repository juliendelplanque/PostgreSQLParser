Class {
	#name : #PSQLScope,
	#superclass : #Object,
	#category : #'PostgreSQL-AST-Visitors-Solver'
}

{ #category : #testing }
PSQLScope >> hasCurrentEntity [
	^ false
]

{ #category : #testing }
PSQLScope >> isAlias [
	^ false
]

{ #category : #accessing }
PSQLScope >> reachableEntities [
	^ self subclassResponsibility 
]
