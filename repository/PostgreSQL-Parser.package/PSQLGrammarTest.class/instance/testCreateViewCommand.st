tests-create view command
testCreateViewCommand
	self
		parse: 'CREATE VIEW test_view AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE OR REPLACE VIEW test_view AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE TEMPORARY VIEW test_view AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE TEMP VIEW test_view AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE VIEW test_view (a ,b, c) AS SELECT a,b,c FROM table' rule: #createViewCommand;
		parse: 'CREATE VIEW test_view WITH (option=value, option2 , option3 = value3) AS SELECT * FROM table' rule: #createViewCommand;
		parse: 'CREATE OR REPLACE TEMPORARY VIEW test_view (a ,b, c) WITH (option=value, option2 , option3 = value3) AS SELECT * FROM table' rule: #createViewCommand