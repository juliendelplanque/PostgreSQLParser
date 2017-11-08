insert command
conflictAction
	"DO NOTHING
    DO UPDATE SET { column_name = { expression | DEFAULT } |
                    ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
                    ( column_name [, ...] ) = ( sub-SELECT )
                  } [, ...]
              [ WHERE condition ]"
	^ (kw do trim , kw nothing) /
	(kw do trim , kw update trim , setClause trim , kw whereKeyword trim , expression)