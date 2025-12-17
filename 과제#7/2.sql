declare
  cursor csr_exec is
    select name, address, networth, certno
      from movieexec
     order by lower(name);

  v_sql   varchar2(4000);
  v_sal   number;
  v_emp   number;
  v_year  movie.year%type;
  v_cdate date;
begin
  begin
    execute immediate 'delete from MovieExecInfo';
  exception when others then null;
  end;

  for e in csr_exec loop
    v_sal := trunc(dbms_random.value(80000, 2000000));
    v_emp := trunc(dbms_random.value(5, 200));

    select min(year) into v_year from movie where producerno = e.certno;
    if v_year is not null then
      v_cdate := add_months(to_date(v_year||'-01-01','yyyy-mm-dd'), -trunc(dbms_random.value(1,24)));
    else
      v_cdate := add_months(trunc(sysdate), -trunc(dbms_random.value(1,60)));
    end if;

    v_sql := 'insert into MovieExecInfo(name, address, networth, movies, studios)
              values(:1, :2, :3, movie_tab(), studio_tab())';
    execute immediate v_sql using e.name, e.address, e.networth;

    for m in (select title, year from movie where producerno = e.certno order by year, title) loop
      v_sal := trunc(dbms_random.value(80000, 2000000));
      if m.year is not null then
        v_cdate := add_months(to_date(m.year||'-01-01','yyyy-mm-dd'), -trunc(dbms_random.value(1,24)));
      else
        v_cdate := add_months(trunc(sysdate), -trunc(dbms_random.value(1,60)));
      end if;

      v_sql := 'insert into table(
                  select movies from MovieExecInfo where name = :1
               ) values ( movie_ty(:2, :3, :4, :5) )';
      execute immediate v_sql using
        e.name,
        m.title,
        m.year,
        v_cdate,
        v_sal;
    end loop;

    for s in (select name from studio where presno = e.certno order by name) loop
      v_emp := trunc(dbms_random.value(5, 200));
      v_sql := 'insert into table(
                  select studios from MovieExecInfo where name = :1
               ) values ( studio_ty(:2, :3) )';
      execute immediate v_sql using
        e.name,
        s.name,
        v_emp;
    end loop;
  end loop;
end;