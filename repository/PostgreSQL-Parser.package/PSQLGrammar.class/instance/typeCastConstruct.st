expression
typeCastConstruct
	^ (typeCast trim , ((kw else not , kw case not , kw endKeyword not , kw andKeyword not , kw or not , kw then not , identifierOrKeyword) plus separatedBy: #space asParser plus)) optional.