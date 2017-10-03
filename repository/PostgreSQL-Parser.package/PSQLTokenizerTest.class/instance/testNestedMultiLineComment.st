tests
testNestedMultiLineComment
	self
		parse: '/* multiline comment
 * with nesting: /* nested block comment */
 */' rule: #multiLineComment