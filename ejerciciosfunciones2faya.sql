delimiter // 
create function nivelEmpleado (empleadoNum int) returns text deterministic
begin
declare nivel text;
declare var int default 0;
    select count(*) into var from employees where empleadoNum = reportsTo;
        if(var>20) then 
        set nivel="Nivel 3";
        else if(var>10 and var<20) then
        set nivel="Nivel 2";
        else
		set nivel="Nivel 1";
        end if;
        end if;
        return nivel;
end //
delimiter ;
select nivelEmpleado(1002);


-- ejercicio 2

delimiter // 
create function diferenciaF(fechaOrden date,fechaEntrega date) returns int deterministic
begin
declare cantDias int;
    select datediff(fechaOrden,fechaEntrega)  into cantDias from orders where fechaOrden = orderDate and fechaEntrega = shippedDate;
        return cantDias;
end //
delimiter ;
select diferenciaF("2003-01-06","2003-01-10");
drop function diferenciaF;

-- ejercicio 3

delimiter // 
create function modificaEstado(empleadoNum int) returns int deterministic
begin
declare cantidad int default 0;
    select count(*) into cantidad from employees where diferenciaF(orderDate,shippedDate) > 10;
    update orders set status = "Cancelled" where diferenciaF(orderDate,shippedDate) > 10;
    return cantidad;        
end //
delimiter ;

-- ejercicio 4

delimiter // 
create function eliminarProducto(prodCod int,ordenN int) returns int deterministic
begin
declare cantidad int default 0;
    select quantityOrdered into cantidad from orderdetail where productCode=prodCod and orderNumber=ordenN;
    delete  from orderdetails where prodCod=productCode AND orderNumber=ordenN;
    return cantidad;
end //
delimiter ;



-- EJERCICIO 5 
delimiter // 
create function elstock(prodCod varchar(15)) returns text deterministic
begin
declare cantidad int default 0;
declare estado text;
    select quantityInStock into cantidad from products where productCode=prodCod;
    if cantidad>1000 and cantidad<5000  then
    set estado="stock adecuado";
    else if cantidad<1000 then
    set estado = "bajo stock";
    else 
    set estado="sobrestock";
    end if;
    end if;
    return estado;
end //
delimiter ;
select elstock("S10_1678");
drop function elstock;


-- EJERCICIO 6 

delimiter // 
create function prodMasV(anio date) returns int deterministic
begin
declare cantidad int default 0;
    select count(*) into cantidad from employees where diferenciaF(orderDate,shippedDate) > 10;
    update orders set status = "Cancelled" where diferenciaF(orderDate,shippedDate) > 10;
    return cantidad;        
end //
delimiter ;
