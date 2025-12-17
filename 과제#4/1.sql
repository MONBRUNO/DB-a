ACCEPT stname PROMPT '배우 이름 입력: '

DECLARE
    cnt NUMBER;
    avg_len NUMBER;
BEGIN
    SELECT COUNT(*), AVG(m.length)
    INTO cnt, avg_len
    FROM starsin s, movie m
    WHERE s.movietitle = m.title
      AND s.movieyear = m.year
      AND LOWER(s.starname) = LOWER('&stname');

    IF cnt = 0 THEN
        DBMS_OUTPUT.PUT_LINE('&stname 검색 실패!!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('&stname : 출연 영화편수['||cnt||'편], '||
                             '출연 영화의 평균상영시간['||ROUND(avg_len,1)||'분]');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('&stname 검색 실패!!');
END;

