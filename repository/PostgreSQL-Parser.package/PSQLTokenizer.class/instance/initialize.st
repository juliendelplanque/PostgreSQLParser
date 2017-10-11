initialization
initialize
	super initialize.
	kw := PSQLExtendedCompositeParserWrapper new extendedCompositeParser: PSQLKeywordsParser new
