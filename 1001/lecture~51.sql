declare
    type m_type is table of movie%rowtype;
    movs    m_type := m_type();
    cursor csr is select * from movie order by 1,2;
    cursor csr2(tt movie.title%type, yy movie.year%type) is
            select * from starsin
            where movietitle = tt and movieyear = yy;
    i   INT;
    m   movie%rowtype;
    pname   movieexec.name%type;
    cnt     int;
    str VARCHAR2(100);
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
        select count(*) into cnt from starsin
        where movietitle = movs(i).title
                and movieyear = movs(i).year;
        if cnt = 0 then
            str := '출연 배우 정보 없음';
        else 
            str := '출연 배우 수:'||cnt||'명';
        end if;
        dbms_output.put_line(movs(i).title||'('||movs(i).year||')'
            || '[제작자:'||pname||'] 출연 배우 수:'||cnt||'명');
        for st in csr2(movs(i).title, movs(i).year) loop
            dbms_output.put_line(lpad('-',5)||' '||st.starname);
        end loop;
        i := movs.next(i);
    end loop;
end;








