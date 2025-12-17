BEGIN
  FOR r IN (
    SELECT title, length
    FROM (
      SELECT title, length
      FROM movie
      ORDER BY length DESC, title
    )
    WHERE ROWNUM <= 3
  ) LOOP
    dbms_output.put_line(r.title || ' - ' || r.length);
  END LOOP;
END;
/