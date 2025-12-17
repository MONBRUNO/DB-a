declare
    type i_type is VARRAY(100) of VARCHAR2(100);
    type n_type is table of VARCHAR2(100);
    arr_i   n_type := n_type('One', 'Two', 'Three');
begin   
    arr_i.extend(3);
    arr_i(4) := 'Four';
    arr_i(5) := 'Five';
    arr_i(6) := 'Six';
    arr_i.delete(3,4);
    for i in arr_i.first..arr_i.last loop
        if not arr_i.exists(i) then
            continue;
        end if;
        dbms_output.put_line(i||' - '||arr_i(i));
    end loop;
    dbms_output.put_line(arr_i.count||', '||arr_i.limit);
end;