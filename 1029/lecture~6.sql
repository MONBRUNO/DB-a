insert into people values (
    'KIM', '2002-01-01',
    phone_tab(),
    addr_tab()
);
insert into table(select phone_list from people where name = 'KIM')
    values (phone_ty('mobile',1,'010-1234-4567'));
insert into table(select address from people where name = 'KIM')
    values addr_ty('울산시', '중구', '대연3동'));
insert into people values (
    'LEE', '2010-11-01',
    phone_tab(
        phone_ty('mobile',1,'010-1234-4567'),
        phone_ty('home',2,'051-1234-4567')
    ),
    addr_tab(
        addr_ty('부산시', '남구', '대연3동')
    )
);
insert into people values (
    'PARK', '1990-11-01',
    phone_tab(
        phone_ty('mobile',1,'010-1234-4567'),
        phone_ty('home',2,'051-1234-4567'),
        phone_ty('home',2,'051-1234-4567')
    ),
    addr_tab(
        addr_ty('부산시', '남구', '대연3동'),
        addr_ty('부산시', '남구', '대연3동'),
        addr_ty('부산시', '남구', '대연3동')
    )
);