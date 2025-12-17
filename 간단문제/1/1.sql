DECLARE
  v_title movie.title%type := 'Star Wars';
  v_year  movie.year%type  := 1977;
  v_len   movie.length%type;
BEGIN
  SELECT length INTO v_len
FROM movie
WHERE UPPER(title) = UPPER(v_title)
  AND year = v_year;

  dbms_output.put_line('length = ' || v_len);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('영화 없음');
END;
/