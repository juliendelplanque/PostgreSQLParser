Class {
	#name : #PSQLCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'PostgreSQL-CommandLine'
}

{ #category : #activation }
PSQLCommandLineHandler >> activate [
	[
		STONJSON
			put: ((PostgreSQLParser parseCRUDQuery: self inputStream upToEnd)
					acceptVisitor: PSQLASTToJSONObjectsVisitor new)
			onStreamPretty: self outputStream
	] ensure: [
		self inputStream close.
		self outputStream close.
	].
]

{ #category : #'as yet unclassified' }
PSQLCommandLineHandler >> inputStream [
	^ self stdin
]

{ #category : #'as yet unclassified' }
PSQLCommandLineHandler >> outputStream [
	^ self stdout
]

{ #category : #accessing }
PSQLCommandLineHandler >> stdin [
	^ ZnCharacterReadStream on: Stdio stdin encoding: 'utf8'
]
