tests-plpgsql
testPlpgsqlBody
	self
		parse: 'BEGIN
IF TG_OP = ''INSERT'' THEN
  NEW.textvector = to_tsvector(NEW.old_text);
ELSIF NEW.old_text != OLD.old_text THEN
  NEW.textvector := to_tsvector(NEW.old_text);
END IF;
RETURN NEW;
END;' rule: #plpgsqlBody;
	parse: 'BEGIN
	if (photo IS NULL) THEN
		RETURN ''photos/membreSansPhoto.jpg'';
	ELSE
		return photo;
	END IF;
END;' rule: #plpgsqlBody;
	parse: 'DECLARE
	clepersonne int4;

BEGIN
	SELECT cle INTO clepersonne
	FROM
		personne
	WHERE
		uidpersonne = uid;

	RETURN clepersonne;
END;' rule: #plpgsqlBody;
	parse: 'BEGIN
	RETURN join(str1,str2,'' / '');
END;' rule: #plpgsqlBody;
	parse: 'DECLARE
	nbrjours int4;
	dateexpiration date;

BEGIN
	SELECT
		typesupport.expiration INTO nbrjours
	FROM
		typesupport
	WHERE
		typesupport.cle = cletypesupport;

	IF (datefin IS NOT NULL) AND (nbrjours IS NOT NULL) THEN
		dateexpiration = datefin + nbrjours;
	END IF;

	RETURN dateexpiration;
END;' rule: #plpgsqlBody;
	parse: 'DECLARE
	nbrsupportscotutelle int := 0;
BEGIN
	SELECT count(support.cle) INTO nbrsupportscotutelle
	FROM
		support
	WHERE
		support.cle_personne = clepersonne::INT4
	AND	support.cle_typesupport = 12
	AND est_dans_interval(debutobservation::DATE,finobservation::date,support.debut,support.fin) = TRUE;

	return (nbrsupportscotutelle > 0);
END;' rule: #plpgsqlBody