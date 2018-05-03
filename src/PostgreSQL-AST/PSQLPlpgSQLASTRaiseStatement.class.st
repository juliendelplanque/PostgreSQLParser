"
I am a RAISE statement. I hold data about what is raised. Some of my attributes may be nil, it is ok depending on the RAISE form that has been parsed.
"
Class {
	#name : #PSQLPlpgSQLASTRaiseStatement,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'level',
		'usingAssocs',
		'formatString',
		'formatExpressions',
		'conditionName',
		'sqlState'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTRaiseStatement >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTRaiseStatement: self
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> conditionName [
	^ conditionName
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> conditionName: anObject [
	conditionName := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> formatExpressions [
	^ formatExpressions
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> formatExpressions: anObject [
	formatExpressions := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> formatString [
	^ formatString
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> formatString: anObject [
	formatString := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> level [
	^ level
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> level: anObject [
	level := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> sqlState [
	^ sqlState
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> sqlState: anObject [
	sqlState := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> usingAssocs [
	^ usingAssocs
]

{ #category : #accessing }
PSQLPlpgSQLASTRaiseStatement >> usingAssocs: anObject [
	usingAssocs := anObject
]
