--These function will be used in PostgreSQL when migrating database from Oracle to rds for PostgreSQL
/*************************************************************
*Author:Songshaohua                                          *
*Date:2020-10-22                                             *
*Version:1.0                                                 *
*************************************************************/
--NVL()
CREATE OR REPLACE FUNCTION nvl(text,text)
RETURNS text
AS
$FUNCTION$
    BEGIN
        IF $1 IS NULL THEN
            RETURN $2;
        ELSE
            RETURN $1;
        END IF;
    END;
$FUNCTION$
LANGUAGE PLPGSQL; 

CREATE OR REPLACE FUNCTION nvl(bigint,bigint)
RETURNS bigint
AS
$FUNCTION$
    BEGIN
        IF $1 IS NULL THEN
            RETURN $2;
        ELSE
            RETURN $1;
        END IF;
    END;
$FUNCTION$
LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION nvl(date,date)
RETURNS date
AS
$FUNCTION$
	BEGIN
		IF $1 IS NULL THEN
			RETURN $2;
		ELSE 
			RETURN $1;
		END IF;
	END;
$FUNCTION$
LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION nvl(timestamp,timestamp)
RETURNS timestamp
AS 
$FUNCTION$
	BEGIN
		IF $1 IS NULL THEN 
			RETURN $2;
		ELSE
			RETURN $1;
		END IF;
	END;
$FUNCTION$
LANGUAGE PLPGSQL;
/***************************************************
*nvl2(args1,args2,args3)                           *
*IF args1 is null ,then returns args3              *
*otherwise,return args2                            *
****************************************************/
CREATE OR REPLACE FUNCTION nvl2(bigint,bigint,bigint)
RETURNS bigint
AS
$FUNCTION$
	BEGIN
		IF $1 IS NULL THEN
			RETURN $3;
		ELSE 
			RETURN $2;
		END IF;
	END;
$FUNCTION$
LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION nvl2(text,text,text)
RETURNS text
AS
$FUNCTION$
	BEGIN
		IF $1 IS NULL THEN
			RETURN $3;
		ELSE 
			RETURN $2;
		END IF;
	END;
$FUNCTION$
LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION nvl2(date,date,date)
RETURNS date
AS
$FUNCTION$
	BEGIN
		IF $1 IS NULL THEN
			RETURN $3;
		ELSE 
			RETURN $2;
		END IF;
	END;
$FUNCTION$
LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION nvl2(timestamp,timestamp,timestamp)
RETURNS timestamp
AS
$FUNCTION$
	BEGIN
		IF $1 IS NULL THEN
			RETURN $3;
		ELSE 
			RETURN $2;
		END IF;
	END;
$FUNCTION$
LANGUAGE PLPGSQL;


/****************************************************
*add_months(date,integer)                           *
*Example:                                           *
* SELECT add_months(current_date,1);                *
* add_months                                        *
*------------                                       *
* 2020-11-26                                        *
* SELECT add_months(current_date,-1);               *
* add_months                                        *
*------------                                       *
* 2020-09-26                                        *
****************************************************/

CREATE OR REPLACE FUNCTION add_months(text,bigint)
RETURNS date
AS 
$FUNCTION$
DECLARE 
	v_date date;
	v_sql  text;
BEGIN
	v_sql := ' SELECT to_date(' ||chr(39) || $1 || chr(39) || ',' || chr(39) || 'YYYYMMDD' || chr(39) || ')' ||
	'+' || ' INTERVAL ' || chr(39)|| $2 || ' Mon' || chr(39);
	execute v_sql INTO v_date;
	RETURN v_date;
END;
$FUNCTION$
LANGUAGE PLPGSQL; 

CREATE OR REPLACE FUNCTION add_months(date,bigint)
RETURNS date
AS 
$FUNCTION$
DECLARE 
	v_date date;
	v_sql  text;
BEGIN
	v_sql := 'SELECT to_date(to_char('
	||chr(39) || $1 || chr(39) || '::date,' || chr(39) || 'YYYYMMDD' || chr(39) || ')' ||
	',' || chr(39) || 'YYYYMMDD' || chr(39) || ')' || '+' || ' INTERVAL ' || chr(39) || $2 || ' Mon' || chr(39);
	execute v_sql INTO v_date;
	RETURN v_date;
END;
$FUNCTION$
LANGUAGE PLPGSQL; 

CREATE OR REPLACE FUNCTION add_months(timestamp,bigint)
RETURNS date
AS 
$FUNCTION$
DECLARE 
	v_date date;
	v_sql  text;
BEGIN
	v_sql := 'SELECT to_date(to_char('
	||chr(39) || $1 || chr(39) || '::date,' || chr(39) || 'YYYYMMDD' || chr(39) || ')' ||
	',' || chr(39) || 'YYYYMMDD' || chr(39) || ')' || '+' || ' INTERVAL ' || chr(39) || $2 || ' Mon' || chr(39);
	RETURN v_date;
END;
$FUNCTION$
LANGUAGE PLPGSQL; 

CREATE OR REPLACE FUNCTION add_months(timestamp without time zone,bigint)
RETURNS date
AS 
$FUNCTION$
DECLARE 
	v_date date;
	v_sql  text;
BEGIN
	v_sql := 'SELECT to_date(to_char('
	||chr(39) || $1 || chr(39) || '::date,' || chr(39) || 'YYYYMMDD' || chr(39) || ')' ||
	',' || chr(39) || 'YYYYMMDD' || chr(39) || ')' || '+' || ' INTERVAL ' || chr(39) || $2 || ' Mon' || chr(39);
	execute v_sql INTO v_date;
	RETURN v_date;
END;
$FUNCTION$
LANGUAGE PLPGSQL;
