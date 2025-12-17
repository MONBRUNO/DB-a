BEGIN
  FOR r IN (
    SELECT title, year
    FROM movie
    WHERE year >= 2000
    ORDER BY year, title
  ) LOOP
    dbms_output.put_line(r.title || ' (' || r.year || ')');
  END LOOP;
END;
/