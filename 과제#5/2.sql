DECLARE
    i NUMBER := 0;
BEGIN
    FOR p IN (
        SELECT certno, name
        FROM movieexec
        ORDER BY LOWER(name)
    ) LOOP
        i := i + 1;
        DECLARE
            had  BOOLEAN := FALSE;
            list VARCHAR2(4000) := '';
        BEGIN
            FOR s IN (
                SELECT name
                FROM studio
                WHERE presno = p.certno
                ORDER BY name DESC
            ) LOOP
                had  := TRUE;
                IF list IS NULL OR list = '' THEN
                    list := s.name;
                ELSE
                    list := list || ', ' || s.name;
                END IF;
            END LOOP;

            IF had THEN
                DBMS_OUTPUT.PUT_LINE('['||i||'] 제작자 '||p.name||'는 '||list||'을(를) 운영한다.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('['||i||'] 제작자 '||p.name||'는 영화사를 운영하지 않는다.');
            END IF;
        END;
    END LOOP;
END;
/
