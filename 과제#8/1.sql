create or replace trigger Star_Insert
before insert on MovieStar
for each row
declare
    v_birthdate  date;
    v_addr       varchar2(255);
    cnt_m        number;
    cnt_f        number;
    v_sql        varchar2(1000);
begin
    if :new.birthdate is null then
        v_birthdate := date '1980-01-01' + trunc(dbms_random.value(0, 365*40));
        :new.birthdate := v_birthdate;
    else
        v_birthdate := :new.birthdate;
    end if;

    if :new.address is null then
        v_addr := '서울시 ' ||
                  to_char(trunc(dbms_random.value(1, 26))) || '구 ' ||
                  to_char(trunc(dbms_random.value(1, 51))) || '동';
        :new.address := v_addr;
    end if;

    if :new.gender is null then
        v_sql := 'select count(*) from moviestar where birthdate > :1 and gender = ''M''';
        execute immediate v_sql into cnt_m using v_birthdate;

        v_sql := 'select count(*) from moviestar where birthdate > :1 and gender = ''F''';
        execute immediate v_sql into cnt_f using v_birthdate;

        if cnt_m > cnt_f then
            :new.gender := 'M';
        elsif cnt_f > cnt_m then
            :new.gender := 'F';
        else
            if trunc(dbms_random.value(0, 2)) = 0 then
                :new.gender := 'M';
            else
                :new.gender := 'F';
            end if;
        end if;
    end if;
end;    