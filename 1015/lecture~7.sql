declare
    cursor csr is select * from user_tables;
begin
    for t in csr loop
        execute immediate 'drop table '||t.table_name||'cascade constraints PURGE';
        dbms_output.put_line(t.table_name||' dropped');
    end loop;
end;