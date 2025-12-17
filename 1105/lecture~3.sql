declare
    k   int := 10;
begin
    for n in reverse -2..2 loop
        k := k / 0;
        dbms_output.put_line(k);
    end loop;
exception
    when others then
        dbms_output.put_line('['||SQLCPDE||'] '||SQLERRM);
end;