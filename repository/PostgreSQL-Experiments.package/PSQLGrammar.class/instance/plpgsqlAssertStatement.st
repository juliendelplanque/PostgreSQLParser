plpgsql
plpgsqlAssertStatement
	"ASSERT condition [ , message ]"
	^ (self buildKeyword: 'assert') trim , expression trim , (comma trim , expression) optional