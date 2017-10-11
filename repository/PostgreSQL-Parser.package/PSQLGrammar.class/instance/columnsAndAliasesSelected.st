accessing
columnsAndAliasesSelected
	"expression [ [ AS ] output_name ] [, ...]"
	^ (expression , (kw as trim , columnAlias) optional) plus separatedBy: comma trim