declare
    type n_ty is table of moviestar.name%type;
    type b_ty is table of moviestar.birthdate%type;
    n_tab   n_ty;
    b_tab   b_ty;
    cursor csr is select name, birthdate from moviestar;
begin
    open csr;
        fetch csr bulk collect into n_tab, b_tab;
    close csr;
    for i in n_tab.first..n_tab.last loop
        dbms_output.put_line(n_tab(i)||', '||b_tab(i));
    end loop;
end;
