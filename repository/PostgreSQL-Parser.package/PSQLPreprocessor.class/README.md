With dollar-quoted string it is hard to find out how strings are nested because open tag and close tag are the same.
e.g. '$function$ body $inner$in$inner$$function$'

Space are not allowed in tag name according to PostgreSQL spec, therefore, a space is used to be able to recognize close tags.
e.g. '$function$ body $inner$in$ inner$$ function$'