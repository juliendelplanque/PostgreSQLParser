baselines
definePackages: spec
	^ spec
		package: 'PgMetadata-Core' with: [ spec requires: #('Garage') ];
		package: 'PgMetadata-SQL-Extractors' with: [ spec requires: #('PgMetadata-Core') ];
		package: 'PgMetadata-SQL-Model-Objects' with: [ spec requires: #('PgMetadata-Core') ];
		package: 'PgMetadata-SQL-Model-References' with: [ spec requires: #('PgMetadata-Core') ];
		package: 'PgMetadata-tests' with: [ spec requires: #('PgMetadata-Core') ];
		yourself