accessing
metaCommand
	^ '\.' asParser / '\?' asParser / '\!' asParser / ($\ asParser , ((#letter asParser / $_ asParser) , (#letter asParser / $_ asParser / #digit asParser / $$ asParser) star))