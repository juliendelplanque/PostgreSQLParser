plpgsql
plpgsqlReturnForm4
	^ kw return trim , kw query trim , kw execute trim , stringConstant trim , (kw using trim , (expression plus separatedBy: comma trim)) optional