as yet unclassified
currentResultValueStatement
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ kw get trim , kw current trim optional , kw diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)