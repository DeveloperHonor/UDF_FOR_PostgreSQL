# UDF  FOR  PostgreSQL #

> **Migrating database from Oracle to RDS for PostgreSQL compatible function**

**Step 1： Copy the the code of compatible.sql**

**Step 2:  Using PGADMIN client tools logging to rds for PostgreSQL**

**Step 3:  Select your database and open the editor of SQL**

**Step 4:  Press F5 or click run button** 

**Step 5:  Verify these function**
## Example ##
    postgres=# SELECT nvl(1,2);
     nvl 
    -----
       1
    (1 row)
    
    postgres=# SELECT nvl(null,1);
     nvl 
    -----
       1
    (1 row)
    
    postgres=# SELECT nvl('SQL',null);
     nvl 
    -----
     SQL
    (1 row)
    
    postgres=# SELECT nvl('','PostgreSQL');
     nvl 
    -----
     
    (1 row)
    
    postgres=# SELECT nvl(null,'PostgreSQL');
    nvl 
    ------------
     PostgreSQL
    (1 row)

    postgres=# SELECT add_months(current_date,1);
     add_months 
    ------------
     2020-11-26
    (1 row)
    
    postgres=# SELECT current_date;
     current_date 
    --------------
     2020-10-26
    (1 row)
    
    postgres=# SELECT add_months(current_date,1);
     add_months 
    ------------
     2020-11-26
    (1 row)
    
    postgres=# SELECT add_months(current_date,-1);
     add_months 
    ------------
     2020-09-26
    (1 row)
    
    postgres=# SELECT add_months('2020-01-02',-1);
     add_months 
    ------------
     2019-12-01
    (1 row)
    
    postgres=# SELECT add_months('2020-01-02',3);
     add_months 
    ------------
     2020-04-01
    (1 row)
    
    postgres=# SELECT add_months('20200102',3);
     add_months 
    ------------
     2020-04-02
    (1 row)
    
