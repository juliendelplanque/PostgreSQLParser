create view command
createViewCommand
	"CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] VIEW name [ ( column_name [, ...] ) ]
    [ WITH ( kw view_option_name [= kw view_option_value] [, ... ] ) ]
    AS query"
	self flag: 'TODO: support VALUES command for kw view definition.'.
	^ kw create trim ,
		(kw or trim , kw replace) trim optional ,
		(kw temporary / kw temp) trim optional ,
		kw view trim ,
		identifier trim , 
		(openParenthesis trim ,
			(columnName plus separatedBy: comma trim) ,
		closeParenthesis trim) trim optional ,
		(kw with trim , openParenthesis trim ,
			((identifierOrKeyword trim , ($= asParser trim , identifierOrKeyword trim) optional ) plus separatedBy: comma trim) , 
		closeParenthesis trim) trim optional ,
		kw as trim ,
		selectCommand trim