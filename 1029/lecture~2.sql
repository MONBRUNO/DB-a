CREATE OR REPLACE FUNCTION get_phone RETURN VARCHAR2
is
BEGIN
    RETURN '010-' || TRUNC(DBMS_RANDOM.VALUE(1000,9999)) || '-' || TRUNC(DBMS_RANDOM.VALUE(1000,9999));
END;
/
create or replace function get_addr(ty varchar2) RETURN varchar2
is 
    type s_ty is table of varchar2(100);
    city s_ty := s_ty('부산', '울산', '대전', '경주', '창원', '인천');
    gu s_ty := s_ty('동', '서', '북', '중', '해운대', '수영');
    dong s_ty := s_ty('대연', '용호', '대잠', '동착', '연제', '우', '동서');
begin
    case
        when ty = 'city' then return city(dbms_random.value(1,city.last))||'시';
        when ty = 'gu' then return gu(dbms_random.value(1,gu.last))||'구';
        when ty = 'dong' then return dong(dbms_random.value(1,dong.last))||'동';
    end case;
exception
    when case_not_found then
        return city(dbms_random.value(1,city.last))||'시 '||
            gu(dbms_random.value(1,gu.last))||'구 '||
            dong(dbms_random.value(1,dong.last))||'동';
end;