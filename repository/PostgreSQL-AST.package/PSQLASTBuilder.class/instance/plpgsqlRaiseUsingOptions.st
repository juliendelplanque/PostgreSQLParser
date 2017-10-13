accessing
plpgsqlRaiseUsingOptions
	^ super plpgsqlRaiseUsingOptions ==> [ :tokens |
		tokens second reject: [ :item  | item = $, ] thenCollect: [ :arr |
			arr first first -> arr first third ] ]