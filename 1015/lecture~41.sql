declare
    cursor csr is select * from studio for update;
    cnt int;
begin
    for s in csr loop
        select count(*) into cnt
        from movie
        where studioname = s.name;
        if cnt > 0 then
            if s.address not like '[*]%' then
                update studio
                set address = '[*] '||address
                where current of csr;
            end if;
        else
            delete from studio
            where current of csr;
        end if;
        dbms_output.put_line(s.name||'('||s.address||') 제작편수: '||cnt);
    end loop;
end;