drop table temp cascade constraints
/
drop table test cascade constraints
/
create table test (
    name    varchar(100) primary key,
    age     number(3) not null,
    address varchar(200),
    check(age > 10 and age < 110)
)
/
create table temp (
    num     number(3) primary key,
    name    varchar(100) references test(name)
)
/
insert into test values ('H0', 23, '부산시 남구');
insert into temp values (0, 'H0');

declare
    type    n_type is table of test.name%type;
    type    a_type is table of test.age%type;
    test_n   n_type := n_type('H1', 'H2', 'H3', 'H3', 'H4');
    test_a   a_type := a_type(30, NULL, 28, 40, 5);
    temp_n  n_type := n_type();

    sql_str   varchar2(200) := 'insert into test values (:1, :2, :3)';
    sql_str1  varchar2(200) := 'insert into temp values (:1, :2)';

    e_pk_violation           exception; pragma exception_init(e_pk_violation,           -1);
    e_null_not_allowed       exception; pragma exception_init(e_null_not_allowed,       -1400);
    e_check_constraint       exception; pragma exception_init(e_check_constraint,       -2290);
    e_fk_parent_missing      exception; pragma exception_init(e_fk_parent_missing,      -2291);
    e_fk_child_exists        exception; pragma exception_init(e_fk_child_exists,        -2292);
    e_invalid_number         exception; pragma exception_init(e_invalid_number,         -1722);
    e_value_error            exception; pragma exception_init(e_value_error,            -6502);
    e_invalid_identifier     exception; pragma exception_init(e_invalid_identifier,     -904);
begin
    temp_n := test_n;

    for i in test_n.first..test_n.last loop
        begin
            execute immediate sql_str using test_n(i), test_a(i), dbms_random.string('x',5)||' '||dbms_random.string('a',10);
            execute immediate sql_str1 using i, temp_n(i);

            if i = test_n.first then
                delete from test
                where name = test_n(i);
            elsif i = 3 then
                update temp
                set name = 'H5'
                where num = 3;
            end if;

        exception
            when e_pk_violation then
                dbms_output.put_line(i||' : [ORA-00001] 중복 키 위반');
            when e_null_not_allowed then
                dbms_output.put_line(i||' : [ORA-01400] NOT NULL 컬럼에 NULL 삽입');
            when e_check_constraint then
                dbms_output.put_line(i||' : [ORA-02290] CHECK 제약조건 위반');
            when e_fk_parent_missing then
                dbms_output.put_line(i||' : [ORA-02291] 부모 키가 없어 외래키 위반');
            when e_fk_child_exists then
                dbms_output.put_line(i||' : [ORA-02292] 자식 행이 존재하여 작업 불가');
            when e_invalid_number then
                dbms_output.put_line(i||' : [ORA-01722] 숫자 변환 오류');
            when e_value_error then
                dbms_output.put_line(i||' : [ORA-06502] 숫자/값 오류');
            when e_invalid_identifier then
                dbms_output.put_line(i||' : [ORA-00904] 잘못된 식별자');
            when others then
                dbms_output.put_line(i||' : ['||SQLCODE||'] '||SQLERRM);
        end;
    end loop;

    dbms_output.put_line(lpad(' ', 50, '*'));
    for t in (select * from test) loop
        dbms_output.put_line(t.name||', '||t.age||', '||t.address);
    end loop;
    dbms_output.put_line(lpad(' ', 50, '*'));
    for t in (select * from temp) loop
        dbms_output.put_line(t.num||', '||t.name);
    end loop;
end;