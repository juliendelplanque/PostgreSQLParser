tests-select command
testFromItems2
	self
		parse: '(SELECT * FROM table) AS alias' rule: #fromItems2;
		parse: '(SELECT * FROM table) AS alias (c1,c2,C3)' rule: #fromItems2;
		parse: '(VALUES (1, ''one''), (2, ''two''), (3, ''three'')) alias (c1 , c2)' rule: #fromItems2