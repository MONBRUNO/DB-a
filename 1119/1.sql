create or replace trigger movie_trig
before insert or update on movie
for each row
DECLARE
    cnt int;
begin
    if :new.length is null then
        select avg(length) into :new.length from movie;
    end if;
    if :new.incolor is null then
        :new.incolor := 't';
    end if;
    if :new.studioname is null then
        select name into :new.studioname
        from (select * from studio order by dbms_random.value)
        where rownum = 1;
    else 
        select count(*) into cnt from studio
        where name = :new.studioname;
        if cnt = 0 then
            insert into studio(name) values (:new.studioname);
        end if;
    end if;
    if :new.producerno is null then
        select certno into :new.producerno
        from (select * from movieexec
            where certno not in ( select producerno from movie)
            order by dbms_random.value)
        where rownum = 1;
    end if;
end;