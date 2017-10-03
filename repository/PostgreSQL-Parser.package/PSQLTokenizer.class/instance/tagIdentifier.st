accessing
tagIdentifier
	^ ((#letter asParser / $_ asParser) , (#letter asParser / $_ asParser / #digit asParser) star)