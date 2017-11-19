Class {
	#name : #BaselineOfPostgreSQL,
	#superclass : #BaselineOf,
	#category : #BaselineOfPostgreSQL
}

{ #category : #baselines }
BaselineOfPostgreSQL >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec 
			package: #'PostgreSQL-Parser' with: [ spec requires: #('PetitParser' 'PetitParserExtension') ];
			package: #'PostgreSQL-Parser-Tests' with: [ spec requires: #('PostgreSQL-Parser') ];
			package: #'PostgreSQL-AST' with: [ spec requires: #('PostgreSQL-Parser') ];
		project: 'PetitParser' with: [
			spec
				className: 'ConfigurationOfPetitParser';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main' ];
		project: 'PetitParserExtension' with: [
			spec
				className: 'ConfigurationOfPetitParserExtension';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Moose/PetitParserExtensions/main' ] ]
]
