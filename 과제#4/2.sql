CREATE OR REPLACE PROCEDURE Get_StarInfo(
    star_name IN VARCHAR2,
    cnt OUT NUMBER,
    average OUT NUMBER
) IS
BEGIN
    SELECT COUNT(*), AVG(m.length)
    INTO cnt, average
    FROM starsin s, movie m
    WHERE s.movietitle = m.title
      AND s.movieyear = m.year
      AND LOWER(s.starname) = LOWER(star_name);

    -- 배우 없을 경우
    IF cnt = 0 THEN
        cnt := -1;
        average := -1;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        cnt := -1;
        average := -1;
    WHEN OTHERS THEN
        cnt := -1;
        average := -1;
END;


