create or replace trigger StarPlays_Trigger
instead of insert on StarPlays
for each row
declare
    cnt          int;
    v_sql        varchar2(1000);
    v_cert       movieexec.certno%type;
    v_addr       varchar2(255);
    v_birth      date;
    v_gender     moviestar.gender%type;
    v_youngest   date;
begin
    v_sql := 'select count(*) from movie where title = :1 and year = :2';
    execute immediate v_sql into cnt using :new.title, :new.year;

    if cnt = 0 then
        v_sql := '
            select producerno
            from (
                select producerno, count(*) c
                from movie
                where producerno is not null
                group by producerno
                order by c desc, dbms_random.value
            )
            where rownum = 1
        ';
        execute immediate v_sql into v_cert;

        insert into movie(title, year, length, incolor, studioname, producerno)
        values(:new.title, :new.year, null, null, null, v_cert);
    end if;

    v_sql := 'select count(*) from moviestar where name = :1';
    execute immediate v_sql into cnt using :new.name;

    if cnt = 0 then
        v_birth := date '1980-01-01' + trunc(dbms_random.value(0, 365*40));
        v_addr  := '서울시 '||
                   to_char(trunc(dbms_random.value(1, 26)))||'구 '||
                   to_char(trunc(dbms_random.value(1, 51)))||'동';

        select max(birthdate) into v_youngest from moviestar;

        if v_youngest is not null then
            v_sql := '
                select gender
                from (
                    select gender
                    from moviestar
                    where birthdate = :1
                      and gender is not null
                    order by dbms_random.value
                )
                where rownum = 1
            ';
            execute immediate v_sql into v_gender using v_youngest;
        else
            if trunc(dbms_random.value(0,2)) = 0 then
                v_gender := 'M';
            else
                v_gender := 'F';
            end if;
        end if;

        insert into moviestar(name, address, gender, birthdate)
        values(:new.name, v_addr, v_gender, v_birth);
    end if;

    v_sql := 'select count(*) from starsin where movietitle = :1 and movieyear = :2 and starname = :3';
    execute immediate v_sql into cnt using :new.title, :new.year, :new.name;

    if cnt = 0 then
        insert into starsin(movietitle, movieyear, starname)
        values(:new.title, :new.year, :new.name);
    end if;
end;