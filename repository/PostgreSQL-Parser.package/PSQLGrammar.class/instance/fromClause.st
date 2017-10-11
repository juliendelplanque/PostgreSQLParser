select command
fromClause
	"See https://www.postgresql.org/docs/9.1/static/sql-select.html#SQL-FROM"
	^ kw from trim , (fromItems plus separatedBy: comma trim)