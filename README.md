# PostgreSQLParser [![Build Status](https://travis-ci.org/juliendelplanque/PostgreSQLParser.svg?branch=master)](https://travis-ci.org/juliendelplanque/PostgreSQLParser)
A parser for PostgreSQL written in Pharo using PetitParser.

For now, the focus is made on PL/pgSQL source code.

- [Install](#install)
	- [Groups](#groups)
	- [Use it as a dependency](#use-it-as-a-dependency)
- [Usage](#usage)


## Install
```
Metacello new
	baseline: 'PostgreSQLParser';
	repository: 'github://juliendelplanque/PostgreSQLParser/src';
	load
```

### Groups
You can use the groups defined in the baseline to install only what you need. The following groups are available:

- `parser` : Only the tokenizer and the grammar.
- `parser-tests` : `parser` and its unit tests.
- `ast` : Only the Abstract Syntactic Tree model.
- `ast-builder` : `ast` + the object that builds the AST from the source code (also requires `parser`).
- `ast-builder-tests` : `ast-builder` + its unit tests.
- `visitors` : `ast` + default visitors of the AST.
- `core` : `parser` + `ast` + `ast-builder`.
- `core-tests` : `core` + all unit tests associated.
- `future` : Experimental code of this project, do not use this in production.
- `dev` : Everything you need to help in this project development loads `future` group as well.

Let's say you only need the `ast` group, the following code will load this specific group:
```
Metacello new
	baseline: 'PostgreSQLParser';
	repository: 'github://juliendelplanque/PostgreSQLParser/src';
	load: 'ast'
```

### Use it as a dependency
To use this project as a dependency, add the following code in your baseline:

```
[...]
spec baseline: 'PostgreSQLParser' with: [ 
	spec
		repository: 'github://juliendelplanque/PostgreSQLParser/src' ]
[...]
```

# Usage
The complexity of the parsing process is hidden (for users) behind a [facade](https://en.wikipedia.org/wiki/Facade_pattern): `PostgreSQLParser` class. The class-side methods provide a simple API to parse SQL code and get an AST as return.

For example:

```
ast := PostgreSQLParser parseSelectQuery: 'SELECT person.id, person.name, person.city_id 
FROM person, city
WHERE person.city_id = city.id
LIMIT 10'. "Mind that there is not trailing ';' because this is part of statement's grammar not query grammar."

"... process the AST... "
```

There other methods work similarly:

- `PostgreSQLParser class>>#parseUpdateQuery:`
- `PostgreSQLParser class>>#parseCRUDQuery:`
- `PostgreSQLParser class>>#parseDeleteQuery:`
- `PostgreSQLParser class>>#parseInsertQuery:`
- `PostgreSQLParser class>>#parseSelectQuery:`
- `PostgreSQLParser class>>#parseStoredProcedureBody:`
