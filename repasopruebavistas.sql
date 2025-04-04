delimiter // 
create function clienteFrecuente (clienteId int) returns text deterministic
begin
declare frecuencia text;
declare var int default 0;
declare var1 int default 0;
select count(Cliente_codCliente) into var from pedido where  fecha>"2019-11-4" and clienteId = Cliente_codCliente;
select count(*) into var1 from pedido ;
        if(var*100/var1>5) then 
        set frecuencia="No es frecuente";
        else 
        set frecuencia="Es frecuente";
        end if;
        return frecuencia;
end //
delimiter ;
select clienteFrecuente(1);


-- ej 4

delimiter // 
create function clientePendiente (clienteId int) returns int deterministic
begin
declare var int default 0;
select count(*) into var from pedido join estado on idEstado=Estado_idEstado where estado.nombre="Por Enviar" and clienteId = Cliente_codCliente;
return var;
end //
delimiter ;

select clientePendiente(1);
drop function clientePendiente;


-- ej 2 tema 2

delimiter // 
create function promP (prodId int) returns float deterministic
begin
declare var float default 0;
select avg(precio) into var from producto_proveedor where prodId=Producto_codProducto;
return var;
end //
delimiter ;


-- ej 1 tema 3

delimiter // 
create function entradasC (funcionId int) returns int deterministic
begin
declare var int default 0;
select sum(cantEntradas) into var from compra where funcion_idFuncion=funcionId;
return var;
end //
delimiter ;

-- ej 3 tema 3

delimiter // 
create function calcularP (idC int) returns float deterministic
begin
declare ptos float default 0;
set ptos=0.25*(select sum(cantEntradas*valorEntradas) from compra join funcion on idFuncion=funcion.Id_funcion where idCliente=idC and timestampdiff(month,fecha,current_date())=1);
return ptos;
end //
delimiter ;
select calcularP();

