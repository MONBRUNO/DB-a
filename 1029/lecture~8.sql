declare
    type s_ty is table of varchar2(100);
    names   s_ty := s_ty('홍길동', '김기리', '경성대', '이미리', '강아지');
    types   s_ty := s_ty('mobile', 'home', 'office');
    p_ins   varchar2(200) := 'insert into people values (
        :1, :2, phone_tab(), addr_tab())';
    ph_ins  varchar2(200) := 'insert into 
        table(select phone_list from people where name = :1)
        values (phone_ty(:2, :3, :4))';
    add_ins varchar2(200) := 'insert into 
        table(select addresses from people where name = :1)
        values addr_ty(:2, :3, :4))';
begin
    for i in name.first..name.last loop
        execute IMMEDIATE p_ins using name(i), 
            to_date('1950-01-01')+dbms_random.value(1,50*365);
        for j in 1..dbms_random.value(1,5) loop
            execute IMMEDIATE ph_ins using names(i)
                names(dbms_randome.value(1,names.last)), j, get_phone;
        end loop;
        for j in 1..dbms_random.value(1,3) loop
            execute IMMEDIATE ph_ins using names(i)                
                get_addr('city'), get_addr('gu'), get_addr('dong');
        end loop;
    end loop;
end;