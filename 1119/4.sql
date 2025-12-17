create or replace trigger movieprod_trig
instead of insert or update or delete on movieprod
for each row
DECLARE
    cnt int;
    pno movieexec.certno%type;
begin
    if deleting then
        update movie
        set producerno = null
        where title = :old.title and year = :old.year;
    else
        select count(*) into cnt from movie
        where title = :new.title and year = :new.year;
        if cnt = 0 then
            insert into movie(title,year) values
                (:new.title, :new.year);
        end if;
        select count(*) into cnt from movieexec
        where :new.producer = name;
        if cnt = 0 then
            select max(certno)+1 into pno from movieexec;
            insert into movieexec(certno,name)
                values (pno, :new.producer);
        end if;
        select certno into pno from movieexec
        where :new.producer = name;
        
        update movie 
        set producerno = pno
        where title = :new.title and year = :new.year;
    end if;
end;