declare
    ins_str varchar2(200) := 'insert into movieexec values (:1, :2, :3, :4)';
    cno movieexec.certno%type;
begin
    select max(certno)+1 into cno from movieexec;
    
    for i in 1..dbms_random.value(1,10) loop
        execute immediate ins_str using 'KIM'||cno, get_addr('all'), cno, 
            dbms_random.value(1000000,100000000);
        cno := cno + 1;
    end loop;
end;