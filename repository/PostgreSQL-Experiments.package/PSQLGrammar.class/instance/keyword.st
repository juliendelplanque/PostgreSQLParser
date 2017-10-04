keywords
keyword
	^ ((Pragma allNamed: #psqlkeyword in: self class)
		collect: [ :pragma | pragma methodSelector value: self ])
		fold: [ :k1 :k2 | k1 / k2 ]