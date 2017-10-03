accessing
identifierOrKeyword
	"From the documentation (https://www.postgresql.org/docs/9.5/static/sql-syntax-lexical.html):
	SQL identifiers and key words must begin with a letter (a-z, but also letters with diacritical marks and non-Latin letters) or an underscore (_). Subsequent characters in an identifier or key word can be letters, underscores, digits (0-9), or dollar signs ($). Note that dollar signs are not allowed in identifiers according to the letter of the SQL standard, so their use might render applications less portable. The SQL standard will not define a key word that contains digits or starts or ends with an underscore, so identifiers of this form are safe against possible conflict with future extensions of the standard."
	^ quotedIdentifier / unquotedIdentifierOrKeyword