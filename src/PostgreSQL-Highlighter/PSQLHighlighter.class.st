Class {
	#name : #PSQLHighlighter,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'streamPosition',
		'keyword'
	],
	#category : #PostgreSQL-Highlighter
}

{ #category : #accessing }
PSQLHighlighter >> binaryBitStringConstant [
	^ self extractSyntaxColorationData: super binaryBitStringConstant forRule: #binaryBitStringConstant
]

{ #category : #accessing }
PSQLHighlighter >> closeBracket [
	^ self extractSyntaxColorationData: super closeBracket forRule: #closeBracket
]

{ #category : #accessing }
PSQLHighlighter >> closeParenthesis [
	^ self extractSyntaxColorationData: super closeParenthesis forRule: #closeParenthesis
]

{ #category : #accessing }
PSQLHighlighter >> comma [
	^ self extractSyntaxColorationData: super comma forRule: #comma
]

{ #category : #accessing }
PSQLHighlighter >> escapeStringConstant [
	^ self extractSyntaxColorationData: super escapeStringConstant forRule: #escapeStringConstant
]

{ #category : #helpers }
PSQLHighlighter >> extractSyntaxColorationData: aParser forRule: aSymbol [
	^ (streamPosition , aParser , streamPosition) ==> [ :tokens |
			PSQLColorationInterval new
				interval: (tokens first + 1 to: tokens last);
				rule: aSymbol;
				yourself ]
]

{ #category : #accessing }
PSQLHighlighter >> hexBitStringConstant [
	^ self extractSyntaxColorationData: super hexBitStringConstant forRule: #hexBitStringConstant
]

{ #category : #accessing }
PSQLHighlighter >> keyword [
	^ self extractSyntaxColorationData: (self rawKeywords allButFirst
		inject: self rawKeywords first asString asParser
		into: [ :p :currentKeyword |
			p / currentKeyword asString asParser ]) forRule: #keyword
]

{ #category : #accessing }
PSQLHighlighter >> metaCommand [
	^ self extractSyntaxColorationData: super metaCommand forRule: #metaCommand
]

{ #category : #accessing }
PSQLHighlighter >> multiLineComment [
	^ self extractSyntaxColorationData: super multiLineComment forRule: #multiLineComment
]

{ #category : #accessing }
PSQLHighlighter >> numericConstant [
	^ self extractSyntaxColorationData: super numericConstant forRule: #numericConstant
]

{ #category : #accessing }
PSQLHighlighter >> oneLineComment [
	^ self extractSyntaxColorationData: super oneLineComment forRule: #oneLineComment
]

{ #category : #accessing }
PSQLHighlighter >> openBracket [
	^ self extractSyntaxColorationData: super openBracket forRule: #openBracket
]

{ #category : #accessing }
PSQLHighlighter >> openParenthesis [
	^ self extractSyntaxColorationData: super openParenthesis forRule: #openParenthesis
]

{ #category : #accessing }
PSQLHighlighter >> operator [
	^ self extractSyntaxColorationData: super operator forRule: #operator
]

{ #category : #accessing }
PSQLHighlighter >> positionalParameter [
	^ self extractSyntaxColorationData: super positionalParameter forRule: #positionalParameter
]

{ #category : #accessing }
PSQLHighlighter >> psqlToken [
	^ keyword / super psqlToken
]

{ #category : #'accessing - keywords' }
PSQLHighlighter >> rawKeywords [
	"Must be sorted in reverse lexical order to ensure the parser does not mismatch a keyword."
	^ #(#YEAR #WITHOUT #WITHIN #WITH #WINDOW #WHILE #WHERE #WHENEVER #WHEN #VARYING #VARCHAR #VALUES #VALUE #USING #USER #UPDATE #UNTIL #UNNEST #UNKNOWN #UNIQUE #UNION #UNDO #TRUE #TRIGGER #TREAT #TRANSLATION #TRAILING #TO #TIMEZONE_MINUTE #TIMEZONE_HOUR #TIMESTAMP #TIME #THEN #TABLESAMPLE #TABLE #SYSTEM_USER #SYSTEM #SYMMETRIC #SUBMULTISET #STATIC #START #SQLWARNING #SQLSTATE #SQLEXCEPTION #SQL #SPECIFICTYPE #SPECIFIC #SOME #SMALLINT #SIMILAR #SIGNAL #SET #SESSION_USER #SENSITIVE #SELECT #SECOND #SEARCH #SCROLL #SCOPE #SAVEPOINT #ROWS #ROW #ROLLUP #ROLLBACK #RIGHT #REVOKE #RETURNS #RETURN #RESULT #RESIGNAL #REPEAT #RELEASE #REFERENCING #REFERENCES #REF #RECURSIVE #REAL #READS #RANGE #PROCEDURE #PRIMARY #PREPARE #PRECISION #PARTITION #PARAMETER #OVERLAPS #OVER #OUTPUT #OUTER #OUT #ORDER #OR #OPEN #ONLY #ON #OLD #OF #NUMERIC #NULL #NOT #NONE #NO #NEW #NCLOB #NCHAR #NATURAL #NATIONAL #MULTISET #MONTH #MODULE #MODIFIES #MINUTE #METHOD #MERGE #MEMBER #MATCH #LOOP #LOCALTIMESTAMP #LOCALTIME #LOCAL #LIKE #LEFT #LEAVE #LEADING #LATERAL #LARGE #LANGUAGE #JOIN #ITERATE #IS #INTO #INTERVAL #INTERSECT #INTEGER #INT #INSERT #INSENSITIVE #INPUT #INOUT #INNER #INDICATOR #IN #IMMEDIATE #IF #IDENTITY #HOUR #HOLD #HAVING #HANDLER #GROUPING #GROUP #GRANT #GLOBAL #GET #FUNCTION #FULL #FROM #FREE #FOREIGN #FOR #FLOAT #FILTER #FETCH #FALSE #EXTERNAL #EXIT #EXISTS #EXECUTE #EXEC #EXCEPT #ESCAPE #END #ELSEIF #ELSE #ELEMENT #EACH #DYNAMIC #DROP #DOUBLE #DO #DISTINCT #DISCONNECT #DETERMINISTIC #DESCRIBE #DEREF #DELETE #DEFAULT #DECLARE #DECIMAL #DEC #DEALLOCATE #DAY #DATE #CYCLE #CURSOR #CURRENT_USER #CURRENT_TRANSFORM_GROUP_FOR_TYPE #CURRENT_TIMESTAMP #CURRENT_TIME #CURRENT_ROLE #CURRENT_PATH #CURRENT_DEFAULT_TRANSFORM_GROUP #CURRENT_DATE #CURRENT #CUBE #CROSS #CREATE #CORRESPONDING #CONTINUE #CONSTRAINT #CONNECT #CONDITION #COMMIT #COLUMN #COLLATE #CLOSE #CLOB #CHECK #CHARACTER #CHAR #CAST #CASE #CASCADED #CALLED #CALL #BY #BOTH #BOOLEAN #BLOB #BINARY #BIGINT #BETWEEN #BEGIN #AUTHORIZATION #ATOMIC #AT #ASYMMETRIC #ASENSITIVE #AS #ARRAY #ARE #ANY #AND #ALTER #ALLOCATE #ALL #ADD)
]

{ #category : #accessing }
PSQLHighlighter >> semicolon [
	^ self extractSyntaxColorationData: super semicolon forRule: #semicolon
]

{ #category : #accessing }
PSQLHighlighter >> simpleStringConstant [
	^ self extractSyntaxColorationData: super simpleStringConstant forRule: #simpleStringConstant
]

{ #category : #accessing }
PSQLHighlighter >> start [
	^ (psqlToken separatedBy: whiteSpace star) ==> [ :tokens |
		tokens flattened select: [ :item | item class = PSQLColorationInterval ] ]
]

{ #category : #stream }
PSQLHighlighter >> streamPosition [
	^ [ :stream | stream position ] asParser
]

{ #category : #accessing }
PSQLHighlighter >> stringConstantWithUnicodeEscape [
	^ self extractSyntaxColorationData: super stringConstantWithUnicodeEscape forRule: #stringConstantWithUnicodeEscape
]

{ #category : #accessing }
PSQLHighlighter >> unicodeQuotedIdentifier [
	^ self extractSyntaxColorationData: super unicodeQuotedIdentifier forRule: #unicodeQuotedIdentifier
]
