declare
    type s_ty is table of moviestar%rowtype index by moviestar.name%type;
    type m_rec is record (
        mov     movie%rowtype,
        stars   s_ty
    );
    type m_tab_ty is table of m_rec;
    mv_tab m_tab_ty :=m_tab_ty();
    cursor m_csr is select * from movie;
    cursor s_csr(tt movie.title%type, yy movie.year%type) is
        select * from moviestar
        where name in (select starname from starsin
                        where movietitle = tt and movieyear = yy)
        order by birthdate asc;
    k   int;
    oldest moviestar.birthdate%type;
    old_mark    char(1);
function get_birth(d moviestar.birthdate%type) return varchar2
is 
begin 
    return to_char (d, '""yyyy"년 "mm"월 "dd"일" ');
end;
begin
    for m in m_csr loop
        mv_tab.extend;
        mv_tab(m_csr%rowcount).mov := m; 
        mv_tab(m_csr%rowcount).stars := s_ty ();
        open s_csr(m.title, m.year);
            fetch s_csr bulk collect into mv_tab(m_csr%rowcount).stars;
        close s_csr;
--        k := 1;
--        for s in s_csr(m.title, m.year) loop
--            mv_tab(m_csr%rowcount).stars.extend;
--            mv_tab(m_csr%rowcount).stars(k) := s;
--            k := k + 1;
--        end loop;
    end loop;
    for i in mv_tab.first..mv_tab.last loop
        select min(birthdate) into oldest from moviestar
        where name in (select starname from starsin
                        where movietitle = mv_tab(i).mov.title
                            and movieyear = mv_tab(i).mov.year);
        dbms_output.put_line(mv_tab(i).mov.title||'('||mv_tab(i).mov.year||
            ') 제일 연장자 생일: '||get_birth(oldest));
        if mv_tab(i).stars.count > 0 then
            for j in mv_tab(i).stars.first..mv_tab(i).stars.last loop
                if mv_tab(i).stars(j).birthdate = oldest then
                    old_mark := '*';
                else 
                    old_mark := '-';
                end if;
                dbms_output.put_line(lpad(' ',4)||'- '||mv_tab(i).stars(j).name||', '||
                    get_birth(mv_tab(i).stars(j).birthdate));
            end loop;
        end if;
    end loop;
end;