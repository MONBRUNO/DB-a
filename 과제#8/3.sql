create or replace trigger Movie_Insert
before insert on movie
for each row
declare
    v_len        movie.length%type;
    v_studioname studio.name%type;
    v_exec       movieexec.certno%type;
    v_sql        varchar2(1000);
begin
    if :new.length is null then
        v_sql := 'select avg(length) from movie';
        execute immediate v_sql into v_len;
        :new.length := v_len;
    end if;

    if :new.incolor is null then
        :new.incolor := 'true';
    end if;

    if :new.studioname is null then
        v_sql := '
            select name
            from (
                select s.name, count(*) cnt
                from studio s, movie m
                where s.name = m.studioname
                group by s.name
                having count(*) > 0
                order by cnt, dbms_random.value
            )
            where rownum = 1
        ';
        execute immediate v_sql into v_studioname;
        :new.studioname := v_studioname;
    end if;

    if :new.producerno is null then
        v_sql := '
            select certno
            from (
                select certno
                from movieexec
                order by dbms_random.value
            )
            where rownum = 1
        ';
        execute immediate v_sql into v_exec;
        :new.producerno := v_exec;
    end if;
end;