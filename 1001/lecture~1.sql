    declare
        type m_type is record (
            title movie.title%type,
            year movie.year%type,
            sname movie.studioname%type,
            pname movieexec.name%type,
            boss movieexec.name%type
        );
        type a_type is table of m_type INDEX by VARCHAR2(100);
        cursor csr is
            select title, year, studioname sname, p.name pname, b.name
            from movie, movieexec p, studio s, movieexec b
            where producerno = p.certno and studioname = s.name 
                and presno = b.certno
            order by 1,2; 
        m   m_type;
        i VARCHAR(100);
        mvs a_type;
    begin
        open csr;
        loop
            fetch csr into m;
            exit when csr%notfound;
            mvs(m.title||m.year) := m;
            if m.title like 'K%' or m.title like 'M%' then
                mvs.delete(m.title||m.year);
            end if;
        end loop;
        close csr;
        i := mvs.first;
        while i is not null loop
            dbms_output.put('['||i||'] ');
            dbms_output.put_line(mvs(i).title||'('||mvs(i).year||') 영화사['||
            mvs(i).sname||'('||mvs(i).boss||')] 제작자['||mvs(i).pname||']');
            i := mvs.next(i);
        end loop;
    --    for m in csr loop
    --        dbms_output.put_line(m.title||'('||m.year||
    --            ') 영화사['||m.sname||'] 제작자['||m.pname||']');
    --    end loop;
    end;