accessing
statements
	^ self commentsAndStatements select: [ :commentOrStatement | commentOrStatement class = PSQLStatement ]