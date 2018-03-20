# PostgreSQLParser [![Build Status](https://travis-ci.org/juliendelplanque/PostgreSQLParser.svg?branch=master)](https://travis-ci.org/juliendelplanque/PostgreSQLParser)
A parser for PostgreSQL written in Pharo using PetitParser.

For now, the focus is made on PL/pgSQL source code.

## Install
```
Metacello new
	baseline: 'PostgreSQL';
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
	baseline: 'PostgreSQL';
	repository: 'github://juliendelplanque/PostgreSQLParser/src';
	load: 'ast'
```

### Use it as a dependency
To use this project as a dependency, add the following code in your baseline:

```
[...]
spec baseline: 'PostgreSQL' with: [ 
	spec
		repository: 'github://juliendelplanque/PostgreSQLParser/src' ]
[...]
```
