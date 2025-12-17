DECLARE
    i NUMBER := 0;
BEGIN
    FOR st IN (
        SELECT name
        FROM moviestar
        ORDER BY LOWER(name)
    ) LOOP
        DECLARE
            cnt  NUMBER := 0;
            list VARCHAR2(4000) := '';
        BEGIN
            FOR m IN (
                SELECT m.title, m.year
                FROM starsin s, movie m
                WHERE s.movietitle = m.title
                  AND s.movieyear = m.year
                  AND LOWER(s.starname) = LOWER(st.name)
                ORDER BY m.year
            ) LOOP
                cnt := cnt + 1;
                IF list IS NULL OR list = '' THEN
                    list := m.title || '(' || m.year || '년)';
                ELSE
                    list := list || ', ' || m.title || '(' || m.year || '년)';
                END IF;
            END LOOP;

            IF cnt > 0 THEN
                i := i + 1;

                IF cnt >= 2 THEN
                    DBMS_OUTPUT.PUT_LINE(
                        '['||i||'] '||st.name||' : '||list||' 등의 '||cnt||'편에 출연'
                    );
                ELSE
                    DBMS_OUTPUT.PUT_LINE(
                        '['||i||'] '||st.name||' : '||list||' '||cnt||'편 출연'
                    );
                END IF;
            END IF;
        END;
    END LOOP;
END;
/
