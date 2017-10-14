accessing
columnDefinition
	^ columnReference trim , (identifier plus separatedBy: #space asParser plus)