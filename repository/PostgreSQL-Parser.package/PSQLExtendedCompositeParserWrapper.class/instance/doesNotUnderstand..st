reflective operations
doesNotUnderstand: aMessage

	^ [extendedCompositeParser rule: aMessage selector]
		 on: KeyNotFound
		 do: [ PPFailure message: ('Unknown rule in ExtendedCompositeParser : ' , aMessage selector asString) ]