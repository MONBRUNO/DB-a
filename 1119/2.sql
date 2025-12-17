insert into movie values ('Z1', 2024, null, null, null, null);
insert into movie values ('Z2', 2024, null, null, null, null);
insert into movie values ('Z3', 2024, null, null, 'fox', 5);
insert into movie values ('Z4', 2024, null, null, 'X1', 5);
insert into movieexec values ('X2', null, 53, null);
insert into movieprod values ('star wars', 1977, 'sharky');
insert into movieprod values ('Z1', 2024, 'X1');
insert into movieprod values ('Z2', 2024, 'X2');
insert into movieprod values ('Z5', 2024, 'X1');
insert into movieprod values ('Z6', 2024, 'X5');
insert into movieprod values ('Z7', 2024, 'X6');
delete from movieprod
where title = 'Z1';
update movieprod
set producer = 'X9'
where title = 'Z7';
u
select * from movie where title like 'z%';
select * from movieexec where certno > 50;
select * from studio where name like 'X%';
select * from studioinfo;
select * from movieprod where title like 'Z%';