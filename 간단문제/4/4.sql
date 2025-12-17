DECLARE
  v_studio  studio.name%type := 'Disney';
  v_newaddr studio.address%type := 'Seoul';
BEGIN
  UPDATE studio
  SET address = v_newaddr
  WHERE UPPER(name) = UPPER(v_studio);

  dbms_output.put_line('updated rows = ' || SQL%ROWCOUNT);
END;
/
