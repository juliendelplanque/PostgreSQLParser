plpgsql
plpgsqlAssignmentLeftPart
	^ (identifier , ($. asParser , identifier) star) , (self subscriptWith: expression) star