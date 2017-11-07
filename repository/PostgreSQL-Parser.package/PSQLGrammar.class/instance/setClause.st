shared
setClause
	"SET { column_name = { expression | DEFAULT } |
                    ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
                    ( column_name [, ...] ) = ( sub-SELECT )
                  } [, ...]"
	^ kw set trim ,
	((setItem1 / setItem2 / setItem3) plus separatedBy: comma trim)