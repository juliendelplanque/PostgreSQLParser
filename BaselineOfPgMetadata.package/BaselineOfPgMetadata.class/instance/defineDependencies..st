baselines
defineDependencies: spec
	^ spec
		project: 'Garage' with: [
			spec
				className: 'ConfigurationOfGarage';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo60/main';
				loads ];
		yourself