create or replace trigger studioinfo_trig
instead of insert or update or delete on studioinfo
for each row
DECLARE
    cnt int;
    pno movieexec.certno%type;
begin
        select count(*) into cnt from movie
        where title = :new.title and year = :new.year;
        if cnt = 0 then
            insert into studio(name) values (:new.name);
        end if;
        select count(*) into cnt from movieexec
        where :new.boss = name;
        if cnt = 0 then
            select max(certno)+1 into pno from movieexec;
            insert into movieexec(certno,name)
                values (pno, :new.boss);
        end if;
        
        select certno into pno from movieexec
        where :new.producer = name;
        
        update studio 
        set producerno = pno
        where name = :new.name;
end;