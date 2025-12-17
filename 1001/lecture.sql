declare
    type i_type is table of varchar2(100) index by varchar2(100);
    arr_i i_type;
    i   varchar2(100);
begin
    arr_i('하나') := 'Three';
    arr_i('둘') := 'One';
    arr_i('셋') := 'Two';
    arr_i('넷') := 'Five';
    arr_i('다섯') := 'Nine';
    arr_i.delete('셋');
    arr_i('하나') := '둘';
    i := arr_i.first;
    while i is not null loop
        dbms_output.put_line(i||' - '||arr_i(i));
        i := arr_i.next(i);
    end loop;
end;