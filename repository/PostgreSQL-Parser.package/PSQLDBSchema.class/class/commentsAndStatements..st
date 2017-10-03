instance creation
commentsAndStatements: commentsAndStatements
	^ self new
		commentsAndStatements: commentsAndStatements;
		yourself