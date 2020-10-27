--Migrate database from Oracle to PostgreSQL
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
    execute v_sql INTO v_date;
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

/********************************************************************
*decode(value,if1,result1,if2,result2,...,ifn,resultn,default)      * 
*Example:                                           *               *
*SELECT decode('Math','Math','Mathmatics','Eng','English','Other'); *
*   decode                                                          *
*------------                                                       *
* Mathmatics                                                        *
*SELECT decode(1,1,01,2,02,0);                                      *
* decode                                                            *
*--------  
* 01                                                         *
*********************************************************************/
CREATE OR REPLACE FUNCTION decode(variadic text[])
RETURNS text
AS 
$FUNCTION$
DECLARE
    v_array_length      bigint := array_length($1,1);
    v_result            text;
    v_err_msg           text;
    v_err_code          text;
BEGIN
    IF v_array_length < 3 THEN 
        v_err_code    := 'p60001';
        v_err_msg     := 'Not enough arguments for function,which needs at least three arguments.';
        RAISE EXCEPTION '%: %',v_err_code ,v_err_msg;
        RETURN NULL;
    ELSE
        FOR i IN 2..(v_array_length - 1) LOOP 
            v_result := NULL; 
            IF mod(i, 2) = 0 THEN 
                IF $1[1] = $1[i] THEN 
                v_result := $1[i+1]; 
                ELSIF $1[1] != $1[i] THEN 
                    IF v_array_length = i + 2 AND v_array_length > 3 THEN 
                        v_result := $1[v_array_length]; 
                    END IF; 
                END IF; 
            END IF; 
        exit WHEN v_result IS NOT NULL; 
        END LOOP; 
    END IF;
    RETURN v_result;
END;
$FUNCTION$
LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION decode(variadic bigint[])
RETURNS text
AS 
$FUNCTION$
DECLARE
    v_array_length      bigint := array_length($1,1);
    v_result            text;
    v_err_msg           text;
    v_err_code          text;
BEGIN
    IF v_array_length < 3 THEN 
        v_err_code    := 'p60001';
        v_err_msg     := 'Not enough arguments for function,which needs at least three arguments.';
        RAISE EXCEPTION '%: %',v_err_code ,v_err_msg;
        RETURN NULL;
    ELSE
        FOR i IN 2..(v_array_length - 1) LOOP 
            v_result := NULL; 
            IF mod(i, 2) = 0 THEN 
                IF $1[1] = $1[i] THEN 
                v_result := $1[i+1]; 
                ELSIF $1[1] != $1[i] THEN 
                    IF v_array_length = i + 2 AND v_array_length > 3 THEN 
                        v_result := $1[v_array_length]; 
                    END IF; 
                END IF; 
            END IF; 
        exit WHEN v_result IS NOT NULL; 
        END LOOP; 
    END IF;
    RETURN v_result;
END;
$FUNCTION$
LANGUAGE PLPGSQL;



postgres=# SELECT decode('Math','Math','Mathmatics','Eng','English','Other');
   decode   
------------
 Mathmatics
(1 row)

postgres=# SELECT decode('Eng','Math','Mathmatics','Eng','English','Other');
 decode  
---------
 English
(1 row)

postgres=# SELECT decode('Physical','Math','Mathmatics','Eng','English','Other');
 decode 
--------
 Other
(1 row)

postgres=# SELECT decode(1,1,01,2,02,0);
 decode 
--------
 1
(1 row)

postgres=# SELECT decode(2,1,01,2,02,0);
 decode 
--------
 2
(1 row)

postgres=# SELECT decode(3,1,01,2,02,0);
 decode 
--------
 0
(1 row)
