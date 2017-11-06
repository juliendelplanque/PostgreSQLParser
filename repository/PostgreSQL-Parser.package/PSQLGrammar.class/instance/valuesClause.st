insert command
valuesClause
	"DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) [, ...] | query"
	^ (kw default trim , kw values) /
	valuesCommand /
	selectCommand