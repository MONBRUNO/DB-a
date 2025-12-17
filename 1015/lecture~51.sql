select * from (select s.*, rownum r from studio s)
where r = 5;
select systimestamp from dual;
select trunc(dbms_random.value(1,10)) from dual;
select to_date('1950-01-01')+dbms_random.value(1.365*50) from dual;
select '010-'||
    trunc(dbms_random.value(1000,9999))||'-'||
    trunc(dbms_random.value(1000,9999))
from dual;
select * from studio
order by dbms_random.value;