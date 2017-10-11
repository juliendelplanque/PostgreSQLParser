select command
fromItems6
	"from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	Normally it should behaves as precedently described ^ BUT, because of recursivity problems, it is defined here as:
	
	[ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]
	
	and the 'from_item' is manged in #fromItems parser."
	
	^ kw natural trim optional , joinType trim , fromItems trim , 
		((kw on trim , expression) / 
		(kw using trim ,
			openParenthesis trim , 
			(columnReference separatedBy: comma trim),
			closeParenthesis trim)) optional