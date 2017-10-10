plpgsql
plpgsqlResultValueStatement
	"GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ]"
	^ get trim , current trim optional , diagnostics trim , identifier , ($= asParser / ':=' asParser) trim , ('ROW_COUNT' asParser caseInsensitive / 'RESULT_OID' asParser caseInsensitive / 'PG_CONTEXT' asParser caseInsensitive)