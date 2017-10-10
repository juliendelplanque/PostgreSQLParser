tests-plpgsql
testPlpgsqlQueryResultsLoop
	self
		parse: 'FOR mviews IN SELECT * FROM cs_materialized_views ORDER BY sort_key LOOP
	var := mviews;
END LOOP' rule: #plpgsqlQueryResultsLoop;
		parse: '<<label>>
FOR mviews IN SELECT * FROM cs_materialized_views ORDER BY sort_key LOOP
	var := mviews;
END LOOP label' rule: #plpgsqlQueryResultsLoop