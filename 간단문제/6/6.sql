DECLARE
  v_key   VARCHAR2(100) := '%';   -- 여기 바꿔가며 테스트
  v_like  CHAR(1) := 'Y';         -- 'Y'면 LIKE 검색, 아니면 =
  v_esc   VARCHAR2(200);
  cnt     NUMBER := 0;
BEGIN
  -- 1) ESCAPE 처리: \, %, _ 를 문자 그대로 검색되도록 변환
  v_esc := v_key;
  v_esc := REPLACE(v_esc, '\', '\\');  -- 백슬래시 자체도 이스케이프
  v_esc := REPLACE(v_esc, '%', '\%');
  v_esc := REPLACE(v_esc, '_', '\_');

  IF v_like = 'Y' THEN
    -- 2) LIKE 검색(포함 검색) + 대소문자 무시 + ESCAPE '\'
    FOR r IN (
      SELECT title, year
      FROM movie
      WHERE UPPER(title) LIKE '%' || UPPER(v_esc) || '%' ESCAPE '\'
      ORDER BY year, title
    ) LOOP
      cnt := cnt + 1;
      dbms_output.put_line(r.title || ' (' || r.year || ')');
    END LOOP;

  ELSE
    -- 3) 일반 문자열 비교(대소문자 무시)
    FOR r IN (
      SELECT title, year
      FROM movie
      WHERE UPPER(title) = UPPER(v_key)
      ORDER BY year, title
    ) LOOP
      cnt := cnt + 1;
      dbms_output.put_line(r.title || ' (' || r.year || ')');
    END LOOP;
  END IF;

  IF cnt = 0 THEN
    dbms_output.put_line('검색 결과 없음');
  END IF;
END;
/
