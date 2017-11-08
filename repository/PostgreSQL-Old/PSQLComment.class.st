"
I represent an abstract comment.
"
Class {
	#name : #PSQLComment,
	#superclass : #PSQLToken,
	#category : 'PostgreSQL-Old'
}

{ #category : #gt-inspector-extension }
PSQLComment >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite text
		title: 'String';
		display: [ self contents ]
]

{ #category : #testing }
PSQLComment >> isComment [
	^ true
]
