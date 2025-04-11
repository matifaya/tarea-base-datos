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


-- 10 

delimiter //
create procedure creation(out canti int)
	begin 
	declare hayFilas boolean default 1;
    declare variable1, variable4 int;
    declare variable2, variable3 date;
    declare ordenesCursor cursor for select orderNumber, orderDate, shippedDate, customerNumber 
    from orders where status="cancelled";
    declare continue handler for not found set hayFilas=0;
    open ordenesCursor;
    bucle:loop
		fetch ordenesCursor into variable1, variable2, variable3, variable4;
        if hayFilas=0 then
			leave bucle;
        end if;
        insert into cancelled_orders values(variable1, variable2, variable3, variable4);
    end loop bucle;
    select count(*) into canti from cancelled_orders;
    close ordenesCursor;
end//
delimiter ;    
call creation(@canti);
select @canti;
select * from cancelled_orders;

-- 11

delimiter //
create procedure ej11(in clienteNum int ) 
	begin 
    declare hayFilas boolean default 1;
	declare variable1,variable3 int ;
    declare comentario,variable2 text;
    declare totalOrden int ;
    declare cursorO cursor for select orderNumber,comments,customerNumber from orders join orderdetails on orderLineNumber = orders.orderNumber where clienteNum=customerNumber;
	declare continue handler for not found set hayFilas=0;
    open cursorO;
    bucle:loop
			fetch cursorO into variable1,variable2,variable3;
            if(hayFilas=0) then
				leave bucle;
            end if;
            set totalOrden=sum(quantituOrdered*priceEach);
            if variable2=NULL then
				set variable2=concat("El total de la orden es",totalOrden);
            end if;
            end loop bucle;
            select variable2 from cursorO;
            close cursorO;

end//
delimiter ;

call ej11(@var);
select @var;


delimiter //
create procedure ej12(out )
	








