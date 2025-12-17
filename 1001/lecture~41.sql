declare
    type m_type is table of movie%rowtype;
    movs    m_type := m_type();
    cursor csr is select * from movie order by 1,2;
    i   INT;
    m   movie%rowtype;
    pname   movieexec.name%type;
begin
    open csr;
    loop
        fetch csr into m;
        exit when csr%notfound;
        movs.extend;
        movs(csr%rowcount) := m;
    end loop;
    close csr;
    i := movs.first;
    while i is not null loop
        select name into pname from movie, movieexec
        where producerno = certno 
            and title = movs(i).title and year = movs(i).year;
        dbms_output.put_line(rpad(movs(i).title,35)||'('||movs(i).year||')'
            || lpad('[제작자:'||pname||']',20));
        i := movs.next(i);
    end loop;
end;








