
-- 4
delimiter //
create procedure cantOrdenes ()
begin
select count(status),status from orders group by status;
end//
delimiter ;

-- 3
 
delimiter //
create procedure cantidadOrdenes (out mensaje text)
begin
declare var1,var2 int;
select productLine into var1 from productlines ;
select productLine into var2 from products ;
if(var1!=var2) then
delete  from productlines where productLine=var1;
set mensaje="La linea de productos fue borrada";
else 
set mensaje="La linea de productos no pudo borrarse porque tiene productos asociados";
end if;

end//
delimiter ;
drop procedure cantidadOrdenes;
call cantidadOrdenes(@mensaje);
select @mensaje;

-- 5
delimiter //
create procedure  cantEmpleados()
begin
declare var1,var2 int;
select count(reportsTo) into var1 from employees group by  employeeNumber;
select employeeNumber into var2 from employees group by  employeeNumber;

if(var1 > 0) then
select count(reportsTo) from employees where reportsTo=var2 ;

end if;
end//
delimiter ;
call cantEmpleados();

-- 5 hecho mas pajero

delimiter //
create procedure empleados_a_cargo(in codigo int)
begin
	select count(*) from employees where reportsTo = codigo;
end//
delimiter ;
call empleados_a_cargo(1002);



-- 6
delimiter //
create procedure listOrden( )
begin
	select sum(priceEach*quantityOrdered), orderNumber from orderdetails group by orderNumber;
end//
delimiter ;
drop procedure listOrden;
call listOrden();

-- 3 de prueba reprobada

delimiter //
create procedure porcentajePiezas(out productosP varchar(4000))
begin 
declare hayFilas boolean default 1;
declare nombresA varchar(60);
declare fechaA date;
declare cursorP cursor for select nombre,max(fecha) from producto join detalleOrden on id_producto=detalleOrden.id_producto join ordenProduccion on id_orden=id_orden group by nombre ;
declare continue handler for not found set hayFilas = 0;
set productosP="";
open cursorP;
bucle:loop
fetch cursorP into nombresA,fechaA;
if hayFilas=0 then
leave bucle;
end if;
if(fechaA=null)then
set productosP=concat(productosP,"Producto:",nombresA,"no se reviso");
else if (datediff(current_date,fechaA)>365) then
	set productosP=concat( productosP,"Producto: ", nombresA, "fecha revision:", fechaA);
END IF;
END if;
end loop;
close cursorP;
end //
delimiter ;





