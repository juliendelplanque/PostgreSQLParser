plpgsql
plpgsqlRaiseLevel
	^ (self buildKeyword: 'debug') / (self buildKeyword: 'log') / (self buildKeyword: 'info') / (self buildKeyword: 'notice') / (self buildKeyword: 'warning') / (self buildKeyword: 'exception')