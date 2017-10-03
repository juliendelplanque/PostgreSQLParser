accessing
dollarQuotedStringConstantCloseTag
	"There is no really close tag defined for dollar quoted strings defined in PostgreSQL spec, this kind of tag is introduced by the pre-processor."
	^ '$ ' asParser , tagIdentifier optional , $$ asParser