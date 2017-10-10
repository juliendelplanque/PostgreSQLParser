expression
typeCastConstruct
	^ (typeCast trim , ((else not , case not , endKeyword not , andKeyword not , or not , then not , identifierOrKeyword) plus separatedBy: #space asParser plus)) optional.