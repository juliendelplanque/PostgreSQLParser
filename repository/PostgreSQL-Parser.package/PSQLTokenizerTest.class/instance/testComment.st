tests
testComment
	self
		parse: '-- One line comment.' rule: #comment.

	self
		parse: '/* multiline comment
 * lol
 */' rule: #comment.	