create or replace trigger Exec_Update
before update on MovieExec
for each row
declare
    cnt        int;
    cnt2       int;
    mx_net     movieexec.networth%type;
    avg_net    movieexec.networth%type;
    v_sql      varchar2(1000);
    v_studioname studio.name%type;
    is_star    int;
begin
    if :new.name <> :old.name then
        v_sql := 'select count(*) from studio where presno = :1';
        execute immediate v_sql into cnt using :old.certno;

        v_sql := 'select count(*) from movie where producerno = :1';
        execute immediate v_sql into cnt2 using :old.certno;

        cnt := cnt + cnt2;

        if cnt > 0 then
            :new.name := :old.name;
        end if;
    end if;

    if :new.networth is null then
        v_sql := 'select max(networth) from movieexec';
        execute immediate v_sql into mx_net;
        :new.networth := mx_net;
    else
        if :old.networth is not null and :new.networth > :old.networth then
            v_sql := 'select count(*) from studio where presno = :1';
            execute immediate v_sql into cnt using :old.certno;

            v_sql := 'select count(*) from movie where producerno = :1';
            execute immediate v_sql into cnt2 using :old.certno;

            cnt := cnt + cnt2;

            if cnt = 0 then
                v_sql := 'select avg(networth) from movieexec';
                execute immediate v_sql into avg_net;

                if :new.networth > avg_net then
                    v_sql := 'select name from (select name from studio order by dbms_random.value) where rownum = 1';
                    execute immediate v_sql into v_studioname;

                    v_sql := 'update studio set presno = :1 where name = :2';
                    execute immediate v_sql using :old.certno, v_studioname;
                end if;
            end if;
        end if;
    end if;

    v_sql := 'select count(*) from starsin where starname = :1';
    execute immediate v_sql into is_star using :new.name;

    if is_star > 0 then
        if :old.address is not null then
            :new.address := :old.address || '에 배우가 삽니다!';
        else
            :new.address := '배우가 삽니다!';
        end if;
    end if;
end;