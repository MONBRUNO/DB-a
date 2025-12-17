create or replace trigger movieexec_trig
before insert or update on movieexec
for each row
DECLARE
    cnt int;
begin
    if :new.name is null then
        :new.name := '경성대-'||systimestamp;
    end if;
    if :new.address is null then
        :new.address := '부산시-'||systimestamp;
    end if;
    if :new.networth is null then
        select avg(networth) into :new.networth from movieexec;
    end if;
end;