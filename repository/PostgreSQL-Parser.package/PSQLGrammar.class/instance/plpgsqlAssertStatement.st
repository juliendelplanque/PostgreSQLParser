plpgsql
plpgsqlAssertStatement
	"ASSERT condition [ , message ]"
	^ kw assert trim , expression trim , (comma trim , expression) optional