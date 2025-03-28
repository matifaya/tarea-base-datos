delimiter //
create procedure getCiudadesOffices (out listadoCiudades varchar(4000)) 
begin
declare hayFilas boolean default 1;
declare ciudadA varchar(45) default "";
declare cityCursor cursor for select city from offices ;
declare continue handler for not found set hayFilas = 0;
set listadoCiudades  = "";
open cityCursor;
ordenesLoop:loop
fetch cityCursor into ciudadA;
if hayFilas = 0 then
leave ordenesLoop;
end if;
set listadoCiudades=concat(ciudadA,",",listadoCiudades);
end loop ordenesLoop;
close cityCursor;
end//
delimiter ;

call getCiudadesOffices(@var);
select @var;

-- 2

delimiter //
create procedure insertCancelledOrders () 
begin
declare hayFilas boolean default 1;
declare ordenA int default 0;
declare fechaOrdenA date;
declare fechaLlegoA date;
declare customerA int default 0;
declare orderCursor cursor for select orderNumber,orderDate,shippedDate,customerNumber from cancelledOrders;
declare continue handler for not found set hayFilas = 0;
open productosCursor;
ordenesLoop:loop
fetch productosCursor into productoObtenido;
if hayFilas = 0 then
leave ordenesLoop;
end if;
insert into cancelledOrders values();
end loop ordenesLoop;
close productosCursor;
end//
delimiter ;

