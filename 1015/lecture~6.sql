declare
    type    tnames_ty is table of varchar2(50);
    tnames tnames_ty := tnames_ty('member', 'soft', 'people', 'source');
    attrs varchar2(200) := '(name varchar2(50) primary key, birthdate date, phone char(13))';
begin
    for i in tnames.first..tnames.last loop
    begin
        execute immediate 'create table '||tnames(i)|| attrs;
        dbms_output.put_line(tnames(i)||' created');
        for j in 1..dbms_randome.value(3,10) loop
            execute immediate 'inser into '||tnames(i)||' values (:1,:2,:3)'
            using '홍길동'||j, to_date('1950-01-01')+dbms_random.value(1.365*50),
            '010-'||trunc(dbms_random.value(1000,9999))||'-'||
            trunc(dbms_random.value(1000,9999));
        end loop;
    exception
        when others then
            dbms_output.put_line(tnames(i)||'exists');
    end;
    end loop;
end;
