accessing
columnsAndAliasesSelected
	"expression [ [ AS ] output_name ] [, ...]"
	^ (expression , (as trim , columnAlias) optional) plus separatedBy: comma trim