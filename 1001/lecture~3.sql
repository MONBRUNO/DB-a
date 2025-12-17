    declare
        type m_type is record (
            title movie.title%type,
            year movie.year%type,
            sname movie.studioname%type,
            pname movieexec.name%type,
            boss movieexec.name%type
        );
        type a_type is table of m_type;
        cursor csr is
            select title, year, studioname sname, p.name pname, b.name
            from movie, movieexec p, studio s, movieexec b
            where producerno = p.certno and studioname = s.name 
                and presno = b.certno
            order by 1,2; 
        m   m_type;
        i integer := 1;
        mvs a_type := a_type();
    begin
        open csr;
        loop
            fetch csr into m;
            exit when csr%not found;
            mvs.extend;
            mvs(i) := m;
            i := i+1;
            end if;
        end loop;
        close csr;
    end;