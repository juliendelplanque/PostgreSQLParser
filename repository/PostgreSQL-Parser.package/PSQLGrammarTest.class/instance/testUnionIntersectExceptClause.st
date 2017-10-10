tests-select command
testUnionIntersectExceptClause
	self
		parse: 'UNION SELECT * FROM sales2007q2' rule: #unionIntersectExceptClause;
		parse: 'UNION ALL SELECT * FROM sales2007q2' rule: #unionIntersectExceptClause;
		parse: 'UNION ALL SELECT * FROM sales2007q2 ORDER BY name ASC, amount DESC' rule: #unionIntersectExceptClause;
		parse: 'EXCEPT SELECT DISTINCT inventory.film_id, title FROM inventory INNER JOIN film ON film.film_id = inventory.film_id ORDER BY title' rule: #unionIntersectExceptClause;
		parse: 'INTERSECT SELECT employee_id FROM hipos' rule: #unionIntersectExceptClause;
		parse: 'INTERSECT SELECT employee_id FROM hipos ORDER BY employee_id' rule: #unionIntersectExceptClause