DECLARE
    TYPE studio_rec IS RECORD (
        sname     studio.name%TYPE,
        addr      studio.address%TYPE,
        boss      movieexec.name%TYPE,
        boss_addr movieexec.address%TYPE
    );
    TYPE studio_tab IS TABLE OF studio_rec INDEX BY VARCHAR2(100);

    m   studio_rec;
    t   studio_tab;
    k   VARCHAR2(100);

    CURSOR csr IS
        SELECT s.name AS sname, s.address AS addr,
               e.name AS boss, e.address AS boss_addr
        FROM studio s LEFT JOIN movieexec e
             ON s.presno = e.certno
        ORDER BY s.name;
BEGIN
    OPEN csr;
    LOOP
        FETCH csr INTO m;
        EXIT WHEN csr%NOTFOUND;
        t(m.sname) := m;
    END LOOP;
    CLOSE csr;

    DBMS_OUTPUT.PUT_LINE(
        RPAD('영화사',20)||RPAD('영화사주소',30)||
        RPAD('사장',20)||'사장주소'
    );

    k := t.FIRST;
    WHILE k IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(
            RPAD(NVL(t(k).sname,'-'),20)||
            RPAD(NVL(t(k).addr,'-'),30)||
            RPAD(NVL(t(k).boss,'-'),20)||
            NVL(t(k).boss_addr,'-')
        );
        k := t.NEXT(k);
    END LOOP;
END;
/
