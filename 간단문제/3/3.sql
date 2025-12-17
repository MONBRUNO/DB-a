DECLARE
  v_title movie.title%type := 'Star Wars';
  v_year  movie.year%type  := 1977;

  CURSOR s_csr(tt movie.title%type, yy movie.year%type) IS
    SELECT starname
    FROM starsin
    WHERE UPPER(movietitle) = UPPER(tt)
      AND movieyear = yy
    ORDER BY starname;

  cnt NUMBER := 0;
BEGIN
  FOR r IN s_csr(v_title, v_year) LOOP
    cnt := cnt + 1;
    dbms_output.put_line(cnt || '. ' || r.starname);
  END LOOP;

  IF cnt = 0 THEN
    dbms_output.put_line('출연 배우 없음');
  END IF;
END;
/
