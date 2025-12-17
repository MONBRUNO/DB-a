declare
  cursor csr_stu is
    select s.name,
           s.address,
           p.name as president
      from studio s
      left join movieexec p
        on s.presno = p.certno
     order by s.name;

  cursor csr_movies(p_studio varchar2) is
    select m.title,
           m.year,
           (select e.name from movieexec e where e.certno = m.producerno) as producer
      from movie m
     where m.studioname = p_studio
     order by m.year, m.title;

  cursor csr_stars(p_studio varchar2) is
    select distinct s.starname as name
      from starsin s
      join movie m
        on m.title = s.movietitle
       and m.year  = s.movieyear
     where m.studioname = p_studio
     order by lower(s.starname);

  v_sql          varchar2(4000);
  v_mv_budget    number;
  v_star_salary  number;
  v_cont_years   number;
begin
  for st in csr_stu loop
    v_sql := 'insert into StudioInfo(name, address, president, movies, stars)
              values(:1, :2, :3, movie_tab(), star_tab())';
    execute immediate v_sql using st.name, st.address, st.president;

    for mv in csr_movies(st.name) loop
      v_mv_budget := trunc(dbms_random.value(1000000, 200000000));
      v_sql := 'insert into table(
                  select movies from StudioInfo where name = :1
               ) values ( mv_ty(:2, :3, :4, :5) )';
      execute immediate v_sql using
        st.name,
        mv.title,
        mv.year,
        v_mv_budget,
        mv.producer;
    end loop;

    for a in csr_stars(st.name) loop
      v_star_salary := trunc(dbms_random.value(50000, 1000000));
      v_cont_years  := trunc(dbms_random.value(1, 11));
      v_sql := 'insert into table(
                  select stars from StudioInfo where name = :1
               ) values ( star_ty(:2, :3, :4) )';
      execute immediate v_sql using
        st.name,
        a.name,
        v_star_salary,
        v_cont_years;
    end loop;
  end loop;
end;