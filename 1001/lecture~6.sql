declare
    m   movie%rowtype;
begin
    begin
        select * into m
        from movie
        where year = 2025;
        if sql%found then
            dbms_output.put_line(m.title||'('||m.year||')');
        elsif sql%notfound then
            dbms_output.put_line('검색 실패');
        end if;
    EXCEPTION
        when too_many_rows then
            dbms_output.put_line('여러 개 튜플 검색 됨');
        when others then
            dbms_output.put_line('검색 실패!!!');
    end;
    update movie
    set length = length + 1
    where title like 'K%'or title like 'M%';
    dbms_output.put_line('갱신 된 튜플 수 : '||sql%rowcount);

end;