declare
    type m_rec is RECORD (
        len movie.length%type,
        sname studio.name%type,
        producer movieexec.name%type,
        president movieexec.name%type
    );
    m m_rec;
    tt   movie.title%type := 'star wars';
    yy   movie.year%type := 1977;
    -- cnt int;
begin
        select length, studioname, e.name, b.name into m
        from movie, movieexec e, studio s, movieexec b
        where title = tt and year = yy and producerno = e.certno and
            studioname = s.name and presno = b.certno;

        dbms_output.put_line(tt||'('||yy||')) 상영시간: '||
        get_length(tt,yy)||', 제작사: '||m.sname||', 제작자: '||m.producer||
        ', 영화사 사장: '||m.president);
EXCEPTION
    when others then
        dbms_output.put_line(tt||'('||yy||') 검색 실패!!');
end;