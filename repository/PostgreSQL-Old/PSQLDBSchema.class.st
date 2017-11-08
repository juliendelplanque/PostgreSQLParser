Class {
	#name : #PSQLDBSchema,
	#superclass : #Object,
	#instVars : [
		'commentsAndStatements'
	],
	#category : 'PostgreSQL-Old'
}

{ #category : #'instance creation' }
PSQLDBSchema class >> commentsAndStatements: commentsAndStatements [
	^ self new
		commentsAndStatements: commentsAndStatements;
		yourself
]

{ #category : #accessing }
PSQLDBSchema >> commentsAndStatements [
	^ commentsAndStatements
]

{ #category : #accessing }
PSQLDBSchema >> commentsAndStatements: anObject [
	commentsAndStatements := anObject
]

{ #category : #gt-inspector-extension }
PSQLDBSchema >> gtDisplayCommentsAndStatementsOn: composite [
	<gtInspectorPresentationOrder: 0>  
	^ (composite list)
		title: 'Comments and statements';
		display: [ :aCollection | self commentsAndStatements ];
		yourself
]

{ #category : #accessing }
PSQLDBSchema >> statements [
	^ self commentsAndStatements select: [ :commentOrStatement | commentOrStatement class = PSQLStatement ]
]
