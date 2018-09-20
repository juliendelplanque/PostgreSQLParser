Class {
	#name : #PSQLExpressionGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #'PostgreSQL-Parser-Tests'
}

{ #category : #accessing }
PSQLExpressionGrammarTest >> parserClass [
	^ PSQLExpressionGrammar
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testAggregateExpression [
	self
		parse: 'array_agg(a ORDER BY b DESC)' rule: #expression;
		parse: 'string_agg(a, '','' ORDER BY a)' rule: #expression;
		parse: 'string_agg(a ORDER BY a, '','')' rule: #expression
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testBinaryLogicalOperator [
	self
		parse: 'AND ' rule: #binaryLogicalOperator;
		parse: 'OR ' rule: #binaryLogicalOperator
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testBinaryOperator [
	self
		parse: '2*2' rule: #expression;
		parse: '2*$3*4' rule: #expression;
		parse: '2*(3+value)' rule: #expression;
		parse: '(3+value)/2' rule: #expression
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testColumnReference [
	self
		parse: 'column' rule: #columnReference
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testCommaSubscript [
	self
		parse: 'ARRAY[4,59,1]' rule: #expression
]

{ #category : #'tests-expression' }
PSQLExpressionGrammarTest >> testConditionalExpression [
	self
		parse: 'CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END' rule: #conditionalExpression;
		parse: 'CASE WHEN 1 = 1 THEN ''Ok'' ELSE CASE WHEN 1 = 2 THEN ''Ooops''::text END END' rule: #conditionalExpression;
		parse: 'CASE WHEN "policy_row"."defeat_strength" = ''simple''::"defeat_strength" THEN NULL ELSE "matrix_p"[1]["i"]."primary" >= 0 END' rule: #conditionalExpression
]

{ #category : #'tests-expression' }
PSQLExpressionGrammarTest >> testExpression [
	self
		parse: 'fct()' rule: #expression;
		parse: '++1' rule: #expression;
		parse: '1+1' rule: #expression;
		parse: '1++' rule: #expression;
		parse: '(fct(fct1(variable[1:$2],2),fct2(42)))' rule: #expression;
		parse: '"initiative"."issue_id" = "interest"."issue_id"'
			rule: #expression;
		parse: '(id)' rule: #expression;
		parse: '(rowfunction(a,b))' rule: #expression;
		parse: 'affectation.cle_support = support.cle AND support.cle_personne = personne.cle AND personne.cle = clepersonne AND	affectation.cle_equipe = cleequipe AND affectation.fin <= finperiode'
			rule: #expression;
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE)'
			rule: #expression;
		parse: 'personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL'
			rule: #expression;
		parse: '(personne.cle IN (SELECT these.cle_coencadrant FROM these))'
			rule: #expression;
		parse: '''IG''::character varying' rule: #expression;
		parse: '1 = - 1' rule: #expression;
		parse: 'ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text])'
			rule: #expression;
		parse: '((grade.cle_catgrade)::text = ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text]))'
			rule: #expression;
		parse: '''a'' || ''b''' rule: #expression;
		parse: 'parentid IS NULL OR parentid = ''''' rule: #expression;
		parse: 'x BETWEEN 0 AND 10' rule: #expression;
		parse: 'x NOT BETWEEN 0 AND 10' rule: #expression;
		parse: '(x BETWEEN 0 AND 10) OR (x NOT BETWEEN 15 AND 20)'
			rule: #expression;
		parse: 'x IS DISTINCT FROM y' rule: #expression;
		parse: 'x IS NOT DISTINCT FROM y' rule: #expression;
		parse: 'x IS TRUE' rule: #expression;
		parse: 'x IS NOT TRUE' rule: #expression;
		parse: 'x IS FALSE' rule: #expression;
		parse: 'x IS NOT FALSE' rule: #expression;
		parse: 'x IS UNKNOWN' rule: #expression;
		parse: 'x IS NOT UNKNOWN' rule: #expression;
		parse: 'x BETWEEN SYMMETRIC 0 AND 10' rule: #expression;
		parse: 'x NOT BETWEEN SYMMETRIC 0 AND 10' rule: #expression;
		parse: '"matrix_p"["i"]["j"] > "matrix_p"["j"]["i"]'
			rule: #expression;
		parse: '((-1::INT8) << 63, 0)::"link_strength"' rule: #expression;
		fail: 'a..nbrspechar' rule: #expression;
		parse: '''{{" "," "," "},{" "," "," "},{" "," "," "}}'''
			rule: #expression;
		parse: '"matrix_p"[1]["i"]."primary" >= 0' rule: #expression;
		parse: 'e''\\''' rule: #expression;
		parse: 'ts_headline(''pg_catalog.simple'', replace(replace("body_p", e''\\'', e''\\\\''), ''*'', e''\\*''), "text_search_query"("query_text_p"), ''StartSel=* StopSel=* HighlightAll=TRUE'' )'
			rule: #expression;
		parse: '"weight_ary"["i"]::INTEGER' rule: #expression;
		parse: '"weight_ary"["i"]::NUMERIC(18,19)' rule: #expression;
		parse: '"weight_ary"["i"]::NUMERIC(18,9)::NUMERIC(12,3)'
			rule: #expression;
		parse: '(genere_url_carto(localisation.cle_batiment, localisation.bureau))::text'
			rule: #expression;
		parse: '(''<a href="''::text || (genere_url_carto(localisation.cle_batiment, localisation.bureau))::text)'
			rule: #expression;
		parse: '((((((((((((''<a href="''::text || (genere_url_carto(localisation.cle_batiment, localisation.bureau))::text) || ''" target="_blank">''::text) || (site.nom)::text) || ''<br>''::text) || (batiment.nom)::text) || ''<br>''::text) || (affiche_etage(localisation.etage))::text) || ''Bureau ''::text) || (localisation.bureau)::text) || ''</a><br>''::text) || (localisation.telephone)::text) || ''<br>''::text)'
			rule: #expression;
		parse: 'min(max(localisation.cle))' rule: #expression;
		parse: '((min(max(localisation))))' rule: #expression;
		parse: '((grade.cle = 27) OR (grade.cle = 17))' rule: #expression;
		fail: 'k..nbrspechar' rule: #expression;
		parse: 'date1 - interval ''1'' day' rule: #expression
]

{ #category : #'tests-expression' }
PSQLExpressionGrammarTest >> testExtractFunctionCall [
	self
		parse: 'EXTRACT(MONTH FROM dateobservation)' rule: #extractFunctionCall;
		parse: 'EXTRACT(DAY FROM origine)' rule: #extractFunctionCall;
		parse: 'EXTRACT(MONTH FROM origine)' rule: #extractFunctionCall
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testFieldSelection [
	self
		parse: 'mytable.mycolumn' rule: #expression;
		parse: '$1.somecolumn' rule: #expression;
		parse: '(rowfunction(a,b)).col3' rule: #expression;
		parse: '(compositecol).somefield' rule: #expression;
		parse: '(mytable.compositecol).somefield' rule: #expression;
		parse: '(compositecol).*' rule: #expression
]

{ #category : #tests }
PSQLExpressionGrammarTest >> testFunctionCall [
	self
		parse: 'fct()' rule: #expression;
		parse: 'sqrt(2)' rule: #expression;
		parse: 'fct(''test'')' rule: #expression;
		parse: 'fct(table)' rule: #expression;
		parse: 'fct(table.column)' rule: #expression;
		parse: 'fct(1,2)' rule: #expression;
		parse: 'fct(fct1(1,2), fct2(42))' rule: #expression;
		parse: 'fct(a := 1, b := hello)' rule: #expression;
		parse: '"defeat_strength"(
            "matrix_a"["i"]["j"],
            "matrix_a"["j"]["i"],
            "policy_row"."defeat_strength"
          )' rule: #expression
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testParenthesedExpression [
	self
		parse: '(1+$1)' rule: #expression;
		parse: '(fct())' rule: #expression;
		parse: '(fct(table.column)[1])' rule: #expression;
		parse: '(++fct(table,42))' rule: #expression;
		parse: '(fct(fct2(table),42))' rule: #expression
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testSubscript [
	self
		parse: 'identifier[1]' rule: #expression;
		parse: 'identifier[4:59]' rule: #expression;
		parse: 'mytable.arraycolumn[4]' rule: #expression;
		parse: 'mytable.two_d_column[17][34]' rule: #expression;
		parse: '$1[10:42]' rule: #expression;
		parse: '(arrayfunction(a,b))[42]' rule: #expression
]

{ #category : #'tests-expression' }
PSQLExpressionGrammarTest >> testTypeCastConstruct [
	self
		parse: '::NUMERIC(18,9)' rule: #typeCastConstruct
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testUnaryPostfixOperator [
	self
		parse: '42++' rule: #expression;
		parse: 'id--' rule: #expression;
		parse: '1++--' rule: #expression;
		parse: '$1++' rule: #expression
]

{ #category : #'tests-accessing' }
PSQLExpressionGrammarTest >> testUnaryPrefixOperator [
	self
		parse: '++42' rule: #expression;
		parse: '--id' rule: #expression;
		parse: '++(--1)' rule: #expression;
		parse: '++$1' rule: #expression
]
