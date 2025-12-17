declare
    s_csr sys_refcursor
    cursor csr is
        select name,address,gender,
            cursor(select * from table(s_movies))
        from star_info;
    s_mvs   star_info.s_movies%type;
    p_mvs   star_info.p_movies%type;
begin
    for s in csr loop
        dbms_output.put_line(s.name||'('||s.gender||') '||s.address);
        s_mvs := s.s_movies;
        p_mvs := s.p_movies;
        if s_mvs.count > 0 then
            for i in 1..s_mvs.last loop
                dbms_output.put_line(lpad(' ',4)||' - '||
                    s_mvs(i).title||'('||s_mvs(i).year
                    ||') 출연 배우