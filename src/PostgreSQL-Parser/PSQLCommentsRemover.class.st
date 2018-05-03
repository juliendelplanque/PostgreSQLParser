"
I remove the comments tokens from the input string provided.
"
Class {
	#name : #PSQLCommentsRemover,
	#superclass : #PSQLTokenizer,
	#category : #'PostgreSQL-Parser-Core'
}

{ #category : #example }
PSQLCommentsRemover class >> example [
	^ self parse: '-- sql comment
SELECT * FROM table'
]

{ #category : #accessing }
PSQLCommentsRemover >> comment [
	^ super comment ==> [ :tokens | nil ]
]

{ #category : #accessing }
PSQLCommentsRemover >> start [
	^ super start ==> [ :tokens | String newFrom: (tokens flattened reject: #isNil) ]
]
