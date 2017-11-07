insert command
onConflictClause
	"ON CONFLICT [ conflict_target ] conflict_action"
	^ kw on trim , kw conflict trim , conflictTarget trim optional , conflictAction